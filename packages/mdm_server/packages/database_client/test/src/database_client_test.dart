// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:database_client/database_client.dart';
import 'package:test/test.dart';

void main() {
  group('DatabaseClient', () {
    test('can be instantiated', () {
      expect(DatabaseClient(databasePath: ''), isNotNull);
    });

    test('in memory can be instantiated', () {
      expect(DatabaseClient.memory(), isNotNull);
    });

    test('get id returns null when nothing is to be found', () async {
      final db = DatabaseClient.memory();
      expect(
        await db.getById('cars', ''),
        isNull,
      );
    });

    test('get all returns empty when nothing is to be found', () async {
      final db = DatabaseClient.memory();
      expect(
        await db.getAll('cars'),
        isEmpty,
      );
    });

    test('get all returns all docs', () async {
      final db = DatabaseClient.memory();
      await db.insert(
        'cars',
        <String, dynamic>{
          'brand': 'VW',
          'model': 'Nivus',
        },
      );
      expect(await db.getAll('cars'), hasLength(1));
    });

    test('an inserted doc can be retrieved', () async {
      final db = DatabaseClient.memory();
      final id = await db.insert(
        'cars',
        <String, dynamic>{
          'brand': 'VW',
          'model': 'Nivus',
        },
      );

      final doc = await db.getById('cars', id);
      expect(
        doc,
        equals(
          <String, dynamic>{
            'id': id,
            'brand': 'VW',
            'model': 'Nivus',
          },
        ),
      );
    });

    test('an inserted doc can be retrieved in file system', () async {
      final db = DatabaseClient(
        databasePath: '${Directory.systemTemp.path}/test.db',
      );
      final id = await db.insert(
        'cars',
        <String, dynamic>{
          'brand': 'VW',
          'model': 'Nivus',
        },
      );

      final doc = await db.getById('cars', id);
      expect(
        doc,
        equals(
          <String, dynamic>{
            'id': id,
            'brand': 'VW',
            'model': 'Nivus',
          },
        ),
      );
    });

    test('an inserted doc can be updated', () async {
      final db = DatabaseClient.memory();
      final id = await db.insert(
        'cars',
        <String, dynamic>{
          'brand': 'VW',
          'model': 'NNivus',
        },
      );

      var doc = await db.getById('cars', id);
      expect(doc?['model'], equals('NNivus'));

      await db.update(
        'cars',
        id,
        <String, dynamic>{
          'id': id,
          'brand': 'VW',
          'model': 'Nivus',
        },
      );

      doc = await db.getById('cars', id);
      expect(doc?['model'], equals('Nivus'));
    });

    group('query', () {
      late DatabaseClient db;

      setUp(() async {
        db = DatabaseClient.memory();

        await db.insert(
          'cars',
          <String, dynamic>{
            'brand': 'VW',
            'model': 'Nivus',
            'category': 'CSUV',
          },
        );

        await db.insert(
          'cars',
          <String, dynamic>{
            'brand': 'VW',
            'model': 'Virtus',
            'category': 'SEDAN',
          },
        );

        await db.insert(
          'cars',
          <String, dynamic>{
            'brand': 'GM',
            'model': 'Onix',
            'category': 'HATCH',
          },
        );
      });

      test('returns the queried field with a single condition', () async {
        final values = await db.query(
          'cars',
          [
            Condition.eq(field: 'brand', value: 'VW'),
          ],
        );

        expect(values.length, equals(2));
        expect(
          values.map<String>((e) => e['model'] as String).toList(),
          equals(['Nivus', 'Virtus']),
        );
      });

      test('returns the queried field with multiple conditions', () async {
        final values = await db.query(
          'cars',
          [
            Condition.eq(field: 'brand', value: 'VW'),
            Condition.eq(field: 'category', value: 'CSUV'),
          ],
        );

        expect(values.length, equals(1));
        expect(
          values.map<String>((e) => e['model'] as String).toList(),
          equals(['Nivus']),
        );
      });

      test('returns the queried field using not equal operator', () async {
        final values = await db.query(
          'cars',
          [
            Condition.different(field: 'brand', value: 'VW'),
          ],
        );

        expect(values.length, equals(1));
        expect(
          values.map<String>((e) => e['model'] as String).toList(),
          equals(['Onix']),
        );
      });
    });

    test('delete removes the doc', () async {
      final db = DatabaseClient.memory();
      final id = await db.insert(
        'cars',
        <String, dynamic>{
          'brand': 'VW',
          'model': 'Nivus',
        },
      );

      await db.delete('cars', id);
      final doc = await db.getById('cars', id);
      expect(doc, isNull);
    });
  });
}
