import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dungeon_repository/dungeon_repository.dart';
import 'package:mdm_domain/mdm_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/dungeons.dart' as route;

class _MockRequest extends Mock implements Request {}

class _MockRequestContext extends Mock implements RequestContext {}

class _MockDungeonRepository extends Mock implements DungeonRepository {}

void main() {
  group('/dungeons', () {
    group('GET', () {
      test('responds with a 200.', () async {
        final request = _MockRequest();
        when(() => request.method).thenReturn(HttpMethod.get);

        final context = _MockRequestContext();
        final repository = _MockDungeonRepository();

        when(() => context.read<DungeonRepository>()).thenReturn(repository);
        when(() => context.request).thenReturn(request);

        when(repository.listDungeons).thenAnswer((invocation) async {
          return [
            const Dungeon(
              id: 1,
              name: 'Cool dungeon',
              description: 'You will like this on',
            ),
          ];
        });

        final response = await route.onRequest(context);
        expect(response.statusCode, equals(HttpStatus.ok));
        expect(
          await response.json(),
          equals(
            [
              {
                'id': 1,
                'name': 'Cool dungeon',
                'description': 'You will like this on',
              },
            ],
          ),
        );
      });
    });
  });
}
