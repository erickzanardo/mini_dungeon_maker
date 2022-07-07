import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dungeon_repository/dungeon_repository.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  if (context.request.method == HttpMethod.get) {
    return _getAllObjects(context, id);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _getAllObjects(RequestContext context, String id) async {
  final dungeonRepository = context.read<DungeonRepository>();
  final objects = await dungeonRepository.listDungeonObjects(int.parse(id));
  return Response.json(body: objects);
}
