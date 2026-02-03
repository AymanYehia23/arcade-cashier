import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

/// Converts technical error objects to user-friendly error messages.
///
/// This function maps common network and system exceptions to clear,
/// actionable messages that end users can understand.
String getUserFriendlyErrorMessage(Object error) {
  if (error is SocketException) {
    return 'Unable to connect to server. Please check your internet connection.';
  } else if (error is http.ClientException) {
    return 'Connection error. Please try again.';
  } else if (error is TimeoutException) {
    return 'Request timed out. Please try again.';
  } else if (error is HttpException) {
    return 'Server error. Please try again later.';
  } else if (error is FormatException) {
    return 'Invalid data received. Please try again.';
  } else if (error.toString().contains('WebSocketChannelException')) {
    return 'Connection lost. Please check your internet connection.';
  } else if (error.toString().contains('Failed host lookup')) {
    return 'Cannot reach server. Please check your internet connection.';
  } else {
    // Generic fallback for unknown errors
    return 'An unexpected error occurred. Please try again.';
  }
}
