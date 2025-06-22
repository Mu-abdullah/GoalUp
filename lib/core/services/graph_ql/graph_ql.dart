import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../error/custom_errors.dart';
import '../supabase/supabase_init.dart';

/// A service class for interacting with Supabase's GraphQL API in a professional, type-safe manner.
class GraphQLService {
  final Dio _dio;
  final String _graphqlUrl = '${SupabaseInit.supabaseUrl}/graphql/v1';
  final String _apiKey = SupabaseInit.supabaseAnonKey;
  String? userToken;

  /// Constructs a [GraphQLService] instance with an optional [Dio] client for dependency injection.
  GraphQLService({Dio? dio}) : _dio = dio ?? Dio() {
    _configureDio();
  }

  /// Configures the Dio instance with base settings and interceptors for logging.
  void _configureDio() {
    _dio.options.baseUrl = _graphqlUrl;
    _dio.options.contentType = 'application/json';
    _dio.options.headers['apikey'] = _apiKey;
    _dio.options.headers['Authorization'] = 'Bearer $_apiKey';

    // Logging interceptors for debugging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('GraphQL Request: ${options.method} ${options.uri}');
          debugPrint('Headers: ${options.headers}');
          debugPrint('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('GraphQL Response: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint('GraphQL Error: ${e.message}');
          debugPrint('Response: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  /// Sets an authenticated user token for requests, overriding the Anon Key if provided.
  void setUserToken(String? token) {
    userToken = token;
    _dio.options.headers['Authorization'] =
        token != null
            ? 'Bearer $token'
            : 'Bearer ${SupabaseInit.supabaseAnonKey}';
  }

  /// Executes a GraphQL query or mutation with type-safe response handling.
  ///
  /// - [query]: The GraphQL query or mutation string.
  /// - [variables]: Optional variables for parameterized queries.
  /// - [operationName]: Optional name for debugging purposes.
  ///
  /// Returns the response data as type [T] or throws a [CustomError].
  Future<T> executeQuery<T>(
    String query, {
    Map<String, dynamic>? variables,
    String? operationName,
  }) async {
    try {
      final response = await _dio.post(
        '',
        data: {
          'query': query,
          if (variables != null) 'variables': variables,
          if (operationName != null) 'operationName': operationName,
        },
      );

      final data = response.data;
      if (data['errors'] != null) {
        throw CustomError(
          'GraphQL Errors: ${data['errors'].toString()}',
          type: ErrorType.graphql,
        );
      }

      return data['data'] as T;
    } on DioException catch (e) {
      throw CustomError(
        'Network error: ${e.message}',
        type: ErrorType.network,
        details: e.response?.data?.toString(),
      );
    } catch (e, stackTrace) {
      throw CustomError(
        'Unexpected error: $e',
        type: ErrorType.unknown,
        stackTrace: stackTrace,
      );
    }
  }

  /// Fetches data from a Supabase collection with type safety.
  ///
  /// - [collection]: The target collection (e.g., 'users').
  /// - [fields]: Fields to retrieve.
  /// - [filters]: Optional filtering conditions.
  /// - [limit]: Optional pagination limit.
  /// - [offset]: Optional pagination offset.
  /// - [fromJson]: Function to parse JSON into type [T].
  ///
  /// Returns a list of [T].

  Future<List<T>> fetchCollection<T>({
    required String collection,
    required List<String> fields,
    Map<String, dynamic>? filters,
    int? limit,
    int? offset,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final query = _buildQuery(
        collection: collection,
        fields: fields,
        filters: filters,
        limit: limit,
        offset: offset,
      );

      final response = await _dio.post(
        '',
        data: {
          'query': query,
          if (filters != null) 'variables': {'filter': filters},
        },
      );

      final data = response.data;
      if (data['errors'] != null) {
        throw CustomError(
          'GraphQL Errors: ${data['errors'].toString()}',
          type: ErrorType.graphql,
          details: data['errors'].toString(),
        );
      }

      final edges =
          data['data']['${collection}Collection']['edges'] as List<dynamic>;
      return edges
          .map((e) => fromJson(e['node'] as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw CustomError(
        'Network error: ${e.message}',
        type: ErrorType.network,
        details: e.response?.data?.toString(),
      );
    } catch (e, stackTrace) {
      throw CustomError(
        'Unexpected error: $e',
        type: ErrorType.unknown,
        stackTrace: stackTrace,
      );
    }
  }

  /// Inserts records into a Supabase collection with type safety.
  ///
  /// - [collection]: The target collection.
  /// - [objects]: List of objects to insert.
  /// - [returningFields]: Fields to return after insertion (defaults to ['id']).
  /// - [fromJson]: Function to parse JSON into type [T].
  ///
  /// Returns a list of inserted [T].
  Future<T> insertIntoCollection<T>({
    required String collection,
    required Map<String, dynamic> object,
    List<String> returningFields = const ['id'],
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final mutation = _buildInsertMutation(
        collection: collection,
        returningFields: returningFields,
      );

      debugPrint('Executing mutation: $mutation with object: $object');

      final data = await executeQuery<Map<String, dynamic>>(
        mutation,
        variables: {'object': object},
        operationName: 'InsertInto$collection',
      );

      final record =
          data['insertInto${collection}Collection']['records'][0]
              as Map<String, dynamic>;
      debugPrint('Inserted record: $record');
      return fromJson(record);
    } catch (e) {
      debugPrint('Error in insertIntoCollection: $e');
      rethrow;
    }
  }

  /// Updates records in a Supabase collection with type safety.
  ///
  /// - [collection]: The target collection.
  /// - [filter]: Conditions to select records.
  /// - [updates]: Fields to update.
  /// - [returningFields]: Fields to return after update (defaults to ['id']).
  /// - [fromJson]: Function to parse JSON into type [T].
  ///
  /// Returns a list of updated [T].
  Future<List<T>> updateCollection<T>({
    required String collection,
    required Map<String, dynamic> filter,
    required Map<String, dynamic> updates,
    List<String> returningFields = const ['id'],
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final mutation = _buildUpdateMutation(
      collection: collection,
      returningFields: returningFields,
    );

    final data = await executeQuery<Map<String, dynamic>>(
      mutation,
      variables: {'filter': filter, 'updates': updates},
      operationName: 'Update$collection',
    );

    final records =
        data['update${collection}Collection']['records'] as List<dynamic>;
    return records.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  /// Deletes records from a Supabase collection with type safety.
  ///
  /// - [collection]: The target collection.
  /// - [filter]: Conditions to select records.
  /// - [returningFields]: Fields to return after deletion (defaults to ['id']).
  /// - [fromJson]: Function to parse JSON into type [T].
  ///
  /// Returns a list of deleted [T].
  Future<List<T>> deleteFromCollection<T>({
    required String collection,
    required Map<String, dynamic> filter,
    List<String> returningFields = const ['id'],
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final mutation = _buildDeleteMutation(
      collection: collection,
      returningFields: returningFields,
    );

    final data = await executeQuery<Map<String, dynamic>>(
      mutation,
      variables: {'filter': filter},
      operationName: 'DeleteFrom$collection',
    );

    final records =
        data['delete${collection}Collection']['records'] as List<dynamic>;
    return records.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  // Helper method to construct a GraphQL query dynamically
  String _buildQuery({
    required String collection,
    required List<String> fields,
    Map<String, dynamic>? filters,
    int? limit,
    int? offset,
  }) {
    final fieldsString = fields.join('\n');
    // Define the variable declaration for the filter
    final variableDeclaration =
        filters != null ? '(\$filter: ${collection}Filter)' : '';
    // Define the argument for the collection
    final args = [
      if (filters != null) 'filter: \$filter',
      if (limit != null) 'first: $limit',
      if (offset != null) 'offset: $offset',
    ].join(', ');

    return '''
      query Fetch$collection$variableDeclaration {
        ${collection}Collection${args.isNotEmpty ? '($args)' : ''} {
          edges {
            node {
              $fieldsString
            }
          }
        }
      }
    ''';
  }
}

// Helper method to construct an insert mutation
String _buildInsertMutation({
  required String collection,
  required List<String> returningFields,
}) {
  final fieldsString = returningFields.join('\n');
  return '''
      mutation InsertInto$collection(\$objects: [${collection}InsertInput!]!) {
        insertInto${collection}Collection(objects: \$objects) {
          affectedCount
          records {
            $fieldsString
          }
        }
      }
    ''';
}

// Helper method to construct an update mutation
String _buildUpdateMutation({
  required String collection,
  required List<String> returningFields,
}) {
  final fieldsString = returningFields.join('\n');
  return '''
      mutation Update$collection(\$filter: ${collection}Filter!, \$updates: ${collection}UpdateInput!) {
        update${collection}Collection(filter: \$filter, set: \$updates) {
          affectedCount
          records {
            $fieldsString
          }
        }
      }
    ''';
}

// Helper method to construct a delete mutation
String _buildDeleteMutation({
  required String collection,
  required List<String> returningFields,
}) {
  final fieldsString = returningFields.join('\n');
  return '''
      mutation DeleteFrom$collection(\$filter: ${collection}Filter!) {
        delete${collection}Collection(filter: \$filter) {
          affectedCount
          records {
            $fieldsString
          }
        }
      }
    ''';
}
