import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mdm_domain/mdm_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

import '../../routes/users/index.dart' as route;

class _MockRequest extends Mock implements Request {}

class _MockRequestContext extends Mock implements RequestContext {}

class _MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('/users', () {
    group('POST', () {
      test('responds with a 204.', () async {
        final request = _MockRequest();
        when(() => request.method).thenReturn(HttpMethod.post);

        final context = _MockRequestContext();
        final repository = _MockUserRepository();

        when(() => context.read<UserRepository>()).thenReturn(repository);
        when(() => context.request).thenReturn(request);
        when(request.json).thenAnswer(
          (_) => Future.value(
            <String, dynamic>{
              'username': 'username',
              'password': 'password',
            },
          ),
        );

        when(
          () => repository.createUser(
            username: 'username',
            password: 'password',
          ),
        ).thenAnswer((invocation) async {
          return const User(id: '', username: 'username');
        });

        final response = await route.onRequest(context);
        expect(response.statusCode, equals(HttpStatus.noContent));
      });

      test('responds with bad request when there is an error.', () async {
        final request = _MockRequest();
        when(() => request.method).thenReturn(HttpMethod.post);

        final context = _MockRequestContext();
        final repository = _MockUserRepository();

        when(() => context.read<UserRepository>()).thenReturn(repository);
        when(() => context.request).thenReturn(request);
        when(request.json).thenAnswer(
          (_) => Future.value(
            <String, dynamic>{
              'username': 'username',
              'password': 'password',
            },
          ),
        );

        when(
          () => repository.createUser(
            username: 'username',
            password: 'password',
          ),
        ).thenThrow(Exception());

        final response = await route.onRequest(context);
        expect(response.statusCode, equals(HttpStatus.badRequest));
      });
    });
  });
}
