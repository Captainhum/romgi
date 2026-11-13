import 'package:dio/dio.dart';
import '../l10n/l10n.dart';

class ErrorUtils {
  static String getUserFriendlyMessage(dynamic error) {
    if (error is DioException) {
      return _getDioErrorMessage(error);
    }

    final errorString = error.toString().toLowerCase();

    // Check for common error patterns
    if (errorString.contains('socketexception') ||
        errorString.contains('connection refused')) {
      return appL10n.errorCannotConnectServer;
    }

    if (errorString.contains('timeout') || errorString.contains('timed out')) {
      return appL10n.errorTimeoutSlow;
    }

    if (errorString.contains('handshake') ||
        errorString.contains('certificate')) {
      return appL10n.errorSecureConnection;
    }

    // Generic fallback
    return appL10n.errorGeneric;
  }

  static String _getDioErrorMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return appL10n.errorConnectTimeout;
      case DioExceptionType.sendTimeout:
        return appL10n.errorSendTimeout;
      case DioExceptionType.receiveTimeout:
        return appL10n.errorReceiveTimeout;
      case DioExceptionType.badCertificate:
        return appL10n.errorSecureConnection;
      case DioExceptionType.badResponse:
        return _getHttpErrorMessage(error.response?.statusCode);
      case DioExceptionType.cancel:
        return appL10n.errorCancelled;
      case DioExceptionType.connectionError:
        return appL10n.errorCannotConnect;
      case DioExceptionType.unknown:
        // Check the underlying error
        final message = error.message?.toLowerCase() ?? '';
        if (message.contains('socketexception') ||
            message.contains('connection refused') ||
            message.contains('network is unreachable')) {
          return appL10n.errorCannotConnect;
        }

        if (message.contains('handshake')) {
          return appL10n.errorSecureConnection;
        }

        return appL10n.errorConnectionFailed;
    }
  }

  static String _getHttpErrorMessage(int? statusCode) {
    if (statusCode == null) return appL10n.errorServerRetry;

    switch (statusCode) {
      case 400:
        return appL10n.errorHttp400;
      case 401:
        return appL10n.errorHttp401;
      case 403:
        return appL10n.errorHttp403;
      case 404:
        return appL10n.errorHttp404;
      case 429:
        return appL10n.errorHttp429;
      case 500:
        return appL10n.errorHttp500;
      case 502:
        return appL10n.errorHttp502;
      case 503:
        return appL10n.errorHttp503;
      case 504:
        return appL10n.errorHttp504;
      default:
        if (statusCode >= 500) {
          return appL10n.errorServerLater;
        }

        return appL10n.errorRequestFailed;
    }
  }

  static ErrorDisplay getErrorDisplay(dynamic error) {
    final errorString = error.toString().toLowerCase();
    final isTimeout =
        errorString.contains('timeout') ||
        errorString.contains('timed out') ||
        (error is DioException &&
            (error.type == DioExceptionType.connectionTimeout ||
                error.type == DioExceptionType.receiveTimeout ||
                error.type == DioExceptionType.sendTimeout));

    final isConnectionError =
        errorString.contains('socketexception') ||
        errorString.contains('connection') ||
        errorString.contains('network') ||
        (error is DioException &&
            error.type == DioExceptionType.connectionError);

    if (isTimeout) {
      return ErrorDisplay(
        title: appL10n.errorTitleTimeout,
        message: getUserFriendlyMessage(error),
        icon: ErrorIcon.timeout,
      );
    }

    if (isConnectionError) {
      return ErrorDisplay(
        title: appL10n.errorTitleConnection,
        message: getUserFriendlyMessage(error),
        icon: ErrorIcon.noConnection,
      );
    }

    if (error is DioException && error.type == DioExceptionType.badResponse) {
      final statusCode = error.response?.statusCode ?? 0;
      if (statusCode >= 500) {
        return ErrorDisplay(
          title: appL10n.errorTitleServer,
          message: getUserFriendlyMessage(error),
          icon: ErrorIcon.server,
        );
      }
    }

    return ErrorDisplay(
      title: appL10n.errorTitle,
      message: getUserFriendlyMessage(error),
      icon: ErrorIcon.generic,
    );
  }
}

enum ErrorIcon { noConnection, timeout, server, generic }

class ErrorDisplay {
  final String title;
  final String message;
  final ErrorIcon icon;

  const ErrorDisplay({
    required this.title,
    required this.message,
    required this.icon,
  });
}
