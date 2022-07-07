import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dungeon_object.g.dart';

/// {@template dungeon_object}
/// A dungeon object is an object that can be placed in a dungeon.
/// {@endtemplate}
@JsonSerializable()
class DungeonObject extends Equatable {
  /// {@macro dungeon_object}
  const DungeonObject({
    required this.id,
    required this.dungeonId,
    required this.name,
    required this.description,
    required this.solid,
    this.sprite,
  });

  /// {@macro dungeon_object}
  factory DungeonObject.fromJson(Map<String, dynamic> json) =>
      _$DungeonObjectFromJson(json);

  /// The unique identifier of the dungeon object.
  final int id;

  /// The unique identifier of the dungeon that this object is on.
  final int dungeonId;

  /// The name of the dungeon object.
  final String name;

  /// The description of the dungeon object.
  final String description;

  /// Whether the dungeon object is solid.
  final bool solid;

  /// The sprite of the dungeon object.
  final String? sprite;

  /// Returns a json representation of this instance.
  Map<String, dynamic> toJson() => _$DungeonObjectToJson(this);

  @override
  List<Object?> get props => [
        id,
        dungeonId,
        name,
        description,
        solid,
        sprite,
      ];
}
