import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

class LoggingClient extends http.BaseClient {
  final http.Client _inner;

  LoggingClient([http.Client? inner]) : _inner = inner ?? http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    _logRequest(request);

    try {
      final response = await _inner.send(request);
      final streamedResponse = await _logResponse(response);
      return streamedResponse;
    } catch (e) {
      developer.log('ERROR: $e', name: 'Starting Request');
      rethrow;
    }
  }

  void _logRequest(http.BaseRequest request) {
    final buffer = StringBuffer();
    buffer.writeln(
      '┌── Request ─────────────────────────────────────────────────────────────────────',
    );
    buffer.writeln('│ Method: ${request.method}');
    buffer.writeln('│ URL: ${request.url}');
    // buffer.writeln('│ Headers:');
    // request.headers.forEach((key, value) {
    //   buffer.writeln('│   $key: $value');
    // });

    if (request is http.Request && request.body.isNotEmpty) {
      buffer.writeln('│ Body:');
      buffer.writeln('│   ${request.body}');
    }

    buffer.writeln(
      '└── End of Request ──────────────────────────────────────────────────────────────',
    );
    developer.log(buffer.toString(), name: 'Supabase Network');
  }

  Future<http.StreamedResponse> _logResponse(
    http.StreamedResponse response,
  ) async {
    final buffer = StringBuffer();
    buffer.writeln(
      '┌── Response ────────────────────────────────────────────────────────────────────',
    );
    buffer.writeln('│ URL: ${response.request?.url}');
    buffer.writeln('│ Status: ${response.statusCode} ${response.reasonPhrase}');
    // buffer.writeln('│ Headers:');
    // response.headers.forEach((key, value) {
    //   buffer.writeln('│   $key: $value');
    // });

    // Peaking into the stream is tricky with StreamedResponse.
    // We need to read it, buffer it, and return a NEW StreamedResponse.
    final bytes = await response.stream.toBytes();
    final body = utf8.decode(bytes, allowMalformed: true);

    if (body.isNotEmpty) {
      buffer.writeln('│ Body:');
      try {
        // Try pretty printing JSON
        const JsonDecoder decoder = JsonDecoder();
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        final object = decoder.convert(body);
        final prettyString = encoder.convert(object);
        prettyString.split('\n').forEach((line) => buffer.writeln('│   $line'));
      } catch (e) {
        // Fallback to raw body
        buffer.writeln('│   $body');
      }
    }

    buffer.writeln(
      '└── End of Response ─────────────────────────────────────────────────────────────',
    );
    developer.log(buffer.toString(), name: 'Supabase Network');

    // Return a new StreamedResponse with the consumed bytes
    return http.StreamedResponse(
      http.ByteStream.fromBytes(bytes),
      response.statusCode,
      contentLength: response.contentLength,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }

  @override
  void close() {
    _inner.close();
    super.close();
  }
}
