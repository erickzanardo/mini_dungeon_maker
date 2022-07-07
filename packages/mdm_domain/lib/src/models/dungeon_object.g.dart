// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dungeon_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DungeonObject _$DungeonObjectFromJson(Map<String, dynamic> json) =>
    DungeonObject(
      id: json['id'] as int,
      dungeonId: json['dungeonId'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      solid: json['solid'] as bool,
      sprite: json['sprite'] as String?,
    );

Map<String, dynamic> _$DungeonObjectToJson(DungeonObject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dungeonId': instance.dungeonId,
      'name': instance.name,
      'description': instance.description,
      'solid': instance.solid,
      'sprite': instance.sprite,
    };
