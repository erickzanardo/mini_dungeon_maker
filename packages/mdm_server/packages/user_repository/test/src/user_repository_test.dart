// ignore_for_file: prefer_const_constructors
import 'package:database_client/database_client.dart';
import 'package:mdm_domain/mdm_domain.dart';
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

      test('throws CreateUserException is insert fails', () async {
        final db = MockDatabaseClient();
        final repository = UserRepository(db: db);

        when(
          () => db.query(
            any(),
            any(),
          ),
        ).thenThrow(Exception());

        when(() => db.insert(any(), any())).thenAnswer(
          (_) => Future.value('1'),
        );

        expect(
          () => repository.createUser(
            username: 'john',
            password: '12',
          ),
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

        final user = await repository.createUser(
          username: 'john',
          password: '12',
        );

        expect(
          user,
          isA<User>()
              .having((user) => user.username, 'username', equals('john'))
              .having((user) => user.id, 'id', isA<String>()),
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

        final user = await repository.createUser(
          username: 'john',
          password: '12',
        );

        expect(
          user,
          isA<User>()
              .having((user) => user.username, 'username', equals('john'))
              .having((user) => user.id, 'id', isA<String>()),
        );
      });
    });

    group('fetchByUsernameAndPassword', () {
      test('returns the user when username and password matches', () async {
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
              <String, dynamic>{
                'id': '1',
                'username': 'john',
              }
            ],
          ),
        );

        final user = await repository.fetchByUsernameAndPassword(
          username: 'john',
          password: '12',
        );

        expect(user, equals(User(id: '1', username: 'john')));
      });

      test('returns null when there is no matches', () async {
        final db = MockDatabaseClient();
        final repository = UserRepository(db: db);

        when(
          () => db.query(
            any(),
            any(),
          ),
        ).thenAnswer(
          (_) => Future.value([]),
        );

        final user = await repository.fetchByUsernameAndPassword(
          username: 'john',
          password: '12',
        );

        expect(user, isNull);
      });
    });
  });
}
