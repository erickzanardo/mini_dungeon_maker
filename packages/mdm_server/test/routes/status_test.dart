import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/status.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /status', () {
    test('responds with a 204.', () {
      final context = _MockRequestContext();
      final response = route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.noContent));
    });
  });
}
