import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:database_client/database_client.dart';
import 'package:mdm_domain/mdm_domain.dart';

/// Throw when the user creation failed.
class CreateUserException implements Exception {}

/// {@template user_repository}
/// Repository that offer access and features for Users
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  const UserRepository({
    required DatabaseClient db,
  }) : _db = db;

  final DatabaseClient _db;

  static const _table = 'users';

  /// Creates an user with the provided [username] and [password].
  ///
  /// Throws [CreateUserException] if the user creation failed.
  Future<User> createUser({
    required String username,
    required String password,
  }) async {
    try {
      if (password.isEmpty) {
        throw CreateUserException();
      }

      final users = await _db.query(
        _table,
        [Condition.eq(field: 'username', value: username)],
      );

      if (users.isNotEmpty) {
        throw CreateUserException();
      }

      final id = await _db.insert(_table, <String, dynamic>{
        'username': username,
        'password': _generateMd5(password),
      });

      return User(id: id, username: username);
    } on CreateUserException {
      rethrow;
    } catch (e) {
      throw CreateUserException();
    }
  }

  /// Returns the user with the provided [username] and [password].
  ///
  /// Returns null if the user does not exist.
  Future<User?> fetchByUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    final users = await _db.query(
      _table,
      [
        Condition.eq(field: 'username', value: username),
        Condition.eq(field: 'password', value: _generateMd5(password)),
      ],
    );

    if (users.isEmpty) {
      return null;
    }

    return User.fromJson(users.first);
  }

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
