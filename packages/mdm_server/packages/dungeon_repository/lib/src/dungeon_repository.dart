import 'package:mdm_domain/mdm_domain.dart';

/// {@template dungeon_repository}
/// Repository to access dungeon data
/// {@endtemplate}
class DungeonRepository {
  /// {@macro dungeon_repository}
  const DungeonRepository();

  /// Returns a list of the lat dungeons.
  Future<List<Dungeon>> listDungeons() async {
    return [
      const Dungeon(
        id: 1,
        name: 'Dark Carve',
        description: 'An adventure on a dark cave',
      ),
    ];
  }

  /// Returns the dungeon objects for the given id.
  Future<List<DungeonObject>> listDungeonObjects(int dungeonId) async {
    return [
      DungeonObject(
        id: 1,
        dungeonId: dungeonId,
        x: 1,
        y: 1,
        name: 'Wall',
        description: 'a wall',
        solid: true,
      ),
    ];
  }
}
