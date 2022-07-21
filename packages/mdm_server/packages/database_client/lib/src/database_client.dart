import 'package:objectdb/objectdb.dart';
// ignore: implementation_imports
import 'package:objectdb/src/objectdb_storage_filesystem.dart';
// ignore: implementation_imports
import 'package:objectdb/src/objectdb_storage_in_memory.dart';

enum _DatabaseClientMode {
  fileSystem,
  inMemory,
}

enum _ConditionType {
  equal,
  different,
}

/// {@template condition}
/// A condition to be used in a query.
/// {@endtemplate}
class Condition {
  /// {@macro condition}
  ///
  /// Will compare that the [field] is equal to the [value];
  Condition.eq({
    required this.field,
    required this.value,
  }) : _type = _ConditionType.equal;

  /// {@macro condition}
  ///
  /// Will compare that the [field] is different to the [value];
  Condition.different({
    required this.field,
    required this.value,
  }) : _type = _ConditionType.different;

  /// The field being compared.
  final String field;

  /// The value to compare with.
  final dynamic value;

  final _ConditionType _type;
}

/// {@template database_client}
/// Provides database definitions and access to other layers
/// {@endtemplate}
class DatabaseClient {
  /// {@macro database_client}
  DatabaseClient({required String databasePath})
      : _mode = _DatabaseClientMode.fileSystem,
        _databasePath = databasePath;

  /// {@macro database_client}
  DatabaseClient.memory()
      : _mode = _DatabaseClientMode.inMemory,
        _databasePath = null;

  final String? _databasePath;

  final _DatabaseClientMode _mode;

  final Map<String, ObjectDB> _dbInstances = {};

  ObjectDB _db(String table) {
    _dbInstances.putIfAbsent(
      table,
      () => ObjectDB(
        _mode == _DatabaseClientMode.fileSystem
            ? FileSystemStorage(_databasePath!)
            : InMemoryStorage(),
      ),
    );
    return _dbInstances[table]!;
  }

  /// Adds a document on the given [table].
  Future<String> insert(String table, Map<String, dynamic> data) async {
    final id = await _db(table).insert(<String, dynamic>{
      ...data,
    });
    return id.hexString;
  }

  /// Updates a document with the given [id] on the given [table].
  Future<void> update(
    String table,
    String id,
    Map<String, dynamic> data,
  ) async {
    await _db(table).update(
      <String, String>{'_id': id},
      <String, dynamic>{
        ...data,
      },
    );
  }

  /// Deletes a document with the given [id] on the given [table].
  Future<void> delete(String table, String id) async {
    await _db(table).remove(<String, String>{'_id': id});
  }

  /// Returns a list of all documents on the given [table].
  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final results = await _db(table).find();
    return results.cast<Map<String, dynamic>>();
  }

  /// Returns a list of all documents on the given [table] with the given [id].
  Future<Map<String, dynamic>?> getById(String table, String id) async {
    final results = await _db(table).find(<String, String>{'_id': id});
    if (results.isEmpty) {
      return null;
    }

    return _mapDoc(results.cast<Map<String, dynamic>>().first);
  }

  /// Returns a list of all documents on the given [table] that matches the
  /// given [conditions].
  Future<List<Map<String, dynamic>>> query(
    String table,
    List<Condition> conditions,
  ) async {
    final parsedConditions = <dynamic, dynamic>{};
    for (final condition in conditions) {
      switch (condition._type) {
        case _ConditionType.equal:
          parsedConditions[condition.field] = condition.value;
          break;
        case _ConditionType.different:
          parsedConditions.putIfAbsent(Op.not, () => <dynamic, dynamic>{});
          // ignore: avoid_dynamic_calls
          parsedConditions[Op.not][condition.field] = condition.value;
          break;
      }
    }

    final results = await _db(table).find(parsedConditions);
    return results.cast<Map<String, dynamic>>();
  }

  Map<String, dynamic> _mapDoc(Map<String, dynamic> doc) {
    final docCopy = <String, dynamic>{...doc}..remove('_id');
    return <String, dynamic>{
      // ignore: avoid_dynamic_calls
      'id': doc['_id'],
      ...docCopy,
    };
  }
}
