// ignore_for_file: prefer_const_constructors

import 'package:mdm_domain/mdm_domain.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('can be instantiated', () {
      expect(User(id: 0, username: ''), isNotNull);
    });

    test('supports value comparison', () {
      expect(
        User(id: 0, username: ''),
        equals(User(id: 0, username: '')),
      );

      expect(
        User(id: 0, username: ''),
        isNot(equals(User(id: 1, username: ''))),
      );

      expect(
        User(id: 0, username: ''),
        isNot(equals(User(id: 0, username: 'a'))),
      );
    });

    test('serializes to json', () {
      expect(
        User(id: 0, username: 'username').toJson(),
        equals(
          {
            'id': 0,
            'username': 'username',
          },
        ),
      );
    });

    test('deserializes from json', () {
      expect(
        User.fromJson(const <String, dynamic>{
          'id': 0,
          'username': 'username',
        }),
        equals(
          User(id: 0, username: 'username'),
        ),
      );
    });
  });
}
