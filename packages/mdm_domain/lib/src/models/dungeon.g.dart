// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dungeon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dungeon _$DungeonFromJson(Map<String, dynamic> json) => Dungeon(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$DungeonToJson(Dungeon instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
