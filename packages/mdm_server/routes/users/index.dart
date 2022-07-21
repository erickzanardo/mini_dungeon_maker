import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mdm_server/tadpole.dart';
import 'package:user_repository/user_repository.dart';

final onRequest = Tadpole().on(HttpMethod.post, post).build();

Future<Response> post(RequestContext context) async {
  try {
    final body = await context.request.json();

    await context.read<UserRepository>().createUser(
          username: body['username'] as String,
          password: body['password'] as String,
        );

    return Response(statusCode: HttpStatus.noContent);
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest);
  }
}
