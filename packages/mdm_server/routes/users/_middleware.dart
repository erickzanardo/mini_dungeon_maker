import 'package:dart_frog/dart_frog.dart';
import 'package:database_client/database_client.dart';
import 'package:mdm_server/env.dart';
import 'package:user_repository/user_repository.dart';

Handler middleware(Handler handler) {
  final userRepository = UserRepository(
    db: DatabaseClient(databasePath: Env.databasePath),
  );

  return handler
      .use(requestLogger())
      .use(provider<UserRepository>((_) => userRepository));
}
