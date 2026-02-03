import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';

/// Converts technical error objects to user-friendly error messages.
///
/// This function maps common network and system exceptions to clear,
/// actionable messages that end users can understand.
String getUserFriendlyErrorMessage(Object error, BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  if (error is SocketException) {
    return loc.errorConnection;
  } else if (error is http.ClientException) {
    return loc.errorConnection;
  } else if (error is TimeoutException) {
    return loc.errorRequestTimedOut;
  } else if (error is HttpException) {
    return loc.errorServer;
  } else if (error is FormatException) {
    return loc.errorInvalidData;
  } else if (error.toString().contains('WebSocketChannelException')) {
    return loc.errorConnection;
  } else if (error.toString().contains('Failed host lookup')) {
    return loc.errorConnection;
  } else {
    // Generic fallback for unknown errors
    return loc.errorGeneric;
  }
}
