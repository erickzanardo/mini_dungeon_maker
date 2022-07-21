// ignore_for_file: prefer_const_constructors
import 'package:database_client/database_client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

class MockDatabaseClient extends Mock implements DatabaseClient {}

void main() {
  group('UserRepository', () {
    test('can be instantiated', () {
      expect(UserRepository(db: MockDatabaseClient()), isNotNull);
    });

    group('createUser', () {
      test('throws CreateUserException if the password is empty', () async {
        final db = MockDatabaseClient();
        final repository = UserRepository(db: db);

        expect(
          () => repository.createUser(username: '', password: ''),
          throwsA(isA<CreateUserException>()),
        );
      });

      test('throws CreateUserException if the username is in use', () async {
        final db = MockDatabaseClient();
        final repository = UserRepository(db: db);

        when(
          () => db.query(
            any(),
            any(),
          ),
        ).thenAnswer(
          (_) => Future.value(
            [
              <String, dynamic>{'id': ''}
            ],
          ),
        );

        expect(
          () => repository.createUser(username: '', password: 'aaaa'),
          throwsA(isA<CreateUserException>()),
        );
      });

      test('returns the user if the user creation succeeded', () async {
        final db = MockDatabaseClient();
        final repository = UserRepository(db: db);

        when(
          () => db.query(
            any(),
            any(),
          ),
        ).thenAnswer((_) => Future.value([]));

        when(() => db.insert(any(), any())).thenAnswer(
          (_) => Future.value('1'),
        );

        final user = await repository.createUser(username: '', password: '12');

        expect(user, isNotNull);
        // TODO AQUI
      });
    });
  });
}
