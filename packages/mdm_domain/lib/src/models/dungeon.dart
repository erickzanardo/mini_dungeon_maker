import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dungeon.g.dart';

/// {@template dungeon}
/// Model representing a dungeon.
/// {@endtemplate}
@JsonSerializable()
class Dungeon extends Equatable {
  /// {@macro dungeon}
  const Dungeon({
    required this.id,
    required this.name,
    required this.description,
  });

  /// {@macro dungeon}
  factory Dungeon.fromJson(Map<String, dynamic> json) =>
      _$DungeonFromJson(json);

  /// Returns a json representation of this instance.
  Map<String, dynamic> toJson() => _$DungeonToJson(this);

  /// The id of the dungeon.
  final int id;

  /// The name of the dungeon.
  final String name;

  /// The description of the dungeon.
  final String description;

  @override
  List<Object?> get props => [id, name, description];
}
