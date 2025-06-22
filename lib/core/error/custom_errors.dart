import 'package:sport/core/language/lang_keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum ErrorType { network, graphql, noData, parsing, unknown }

class CustomError {
  final String message;
  final ErrorType type;
  final String? details;
  final StackTrace? stackTrace;

  CustomError(
    this.message, {
    this.type = ErrorType.unknown,
    this.details,
    this.stackTrace,
  });

  @override
  String toString() => 'CustomError: $message (Type: $type, Details: $details)';
}

class AuthExceptionHandler {
  static String handle(dynamic error) {
    if (error is AuthException || error is AuthApiException) {
      return _mapMessage((error as dynamic).message);
    }
    return LangKeys.somethingWentWrong;
  }

  static String _mapMessage(String message) {
    switch (message.toLowerCase()) {
      case 'invalid login credentials':
        return LangKeys.invalidLoginCredentials;
      case 'user not found':
        return LangKeys.userNotFound;

      default:
        return LangKeys.somethingWentWrong;
    }
  }
}
