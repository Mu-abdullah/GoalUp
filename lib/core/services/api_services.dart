import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/foundation.dart';

class ApiServices {
  final Dio _dio;
  final String _url = 'https://newsapi.org/v2/';
  final String _apiKey = "${dotenv.env['NEWS_API_KEY']}";

  ApiServices({Dio? dio}) : _dio = dio ?? Dio() {
    _configureDio();
  }

  void _configureDio() {
    _dio.options.baseUrl = _url;
    _dio.options.contentType = 'application/json';
    _dio.options.headers['X-API-Key'] = _apiKey;

    // Logging interceptors for debugging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('News API Request: ${options.method} ${options.uri}');
          debugPrint('Headers: ${options.headers}');
          debugPrint('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint('News API Response: ${response.statusCode}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          debugPrint('News API Error: ${e.message}');
          debugPrint('Response: ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> getData({
    required String endpoint,
    required Map<String, dynamic> query,
  }) async {
    return await _dio.get(endpoint, queryParameters: query);
  }

  // مثال لاستخدام API الأخبار الطبية

  Future<Response> getHealthNews({
    String country = 'eg',
    int pageSize = 20,
    int page = 1,
  }) async {
    return await getData(
      endpoint: 'top-headlines',
      query: {'country': country, 'category': 'health'},
    );
  }
}
