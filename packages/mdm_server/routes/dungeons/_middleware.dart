import 'package:dart_frog/dart_frog.dart';
import 'package:dungeon_repository/dungeon_repository.dart';

Handler middleware(Handler handler) {
  const dungeonRepository = DungeonRepository();

  return handler
      .use(requestLogger())
      .use(provider<DungeonRepository>((_) => dungeonRepository));
}
