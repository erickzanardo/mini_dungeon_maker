// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dungeon_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DungeonObject _$DungeonObjectFromJson(Map<String, dynamic> json) =>
    DungeonObject(
      id: json['id'] as int,
      dungeonId: json['dungeonId'] as int,
      x: json['x'] as int,
      y: json['y'] as int,
      solid: json['solid'] as bool,
      name: json['name'] as String?,
      description: json['description'] as String?,
      sprite: json['sprite'] as String?,
    );

Map<String, dynamic> _$DungeonObjectToJson(DungeonObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dungeonId': instance.dungeonId,
      'x': instance.x,
      'y': instance.y,
      'solid': instance.solid,
      'name': instance.name,
      'description': instance.description,
      'sprite': instance.sprite,
    };
