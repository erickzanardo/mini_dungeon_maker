import 'dart:io';

/// Class with the environemnet variables.
class Env {
  /// The environment variable for the database location.
  static String get databasePath => String.fromEnvironment(
        'DB_PATH',
        defaultValue: Directory.systemTemp.path,
      );
}
