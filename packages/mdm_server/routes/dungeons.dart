import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dungeon_repository/dungeon_repository.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method == HttpMethod.get) {
    return _getAllDungeons(context);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _getAllDungeons(RequestContext context) async {
  final dungeonRepository = context.read<DungeonRepository>();
  final dungeons = await dungeonRepository.listDungeons();
  return Response.json(body: dungeons);
}
