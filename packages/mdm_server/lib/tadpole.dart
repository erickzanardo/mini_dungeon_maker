// ignore_for_file: avoid_returning_this

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// A helper class to create a dart frog request handler.
class Tadpole {
  final Map<HttpMethod, Handler> _handlers = {};

  /// Register a [handler] for the given [method].
  Tadpole on(HttpMethod method, Handler handler) {
    _handlers[method] = handler;
    return this;
  }

  /// Create a request handler.
  Handler build() {
    return (RequestContext context) async {
      final handler = _handlers[context.request.method];
      if (handler != null) {
        return await handler(context);
      }

      return Response(statusCode: HttpStatus.methodNotAllowed);
    };
  }
}
