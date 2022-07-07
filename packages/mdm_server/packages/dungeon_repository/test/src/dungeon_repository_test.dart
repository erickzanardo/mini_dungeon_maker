// ignore_for_file: prefer_const_constructors
import 'package:dungeon_repository/dungeon_repository.dart';
import 'package:test/test.dart';

void main() {
  group('DungeonRepository', () {
    test('can be instantiated', () {
      expect(DungeonRepository(), isNotNull);
    });

    group('listDungeons', () {
      test('listDungeons returns a list of dungeons', () async {
        final repository = DungeonRepository();
        final dungeons = await repository.listDungeons();
        expect(dungeons, hasLength(1));
      });
    });

    group('listDungeonObjects', () {
      test('listDungeonObjects returns a list of objects', () async {
        final repository = DungeonRepository();
        final objects = await repository.listDungeonObjects(1);
        expect(objects, hasLength(1));
      });
    });
  });
}
