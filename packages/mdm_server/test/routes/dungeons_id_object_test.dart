import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:dungeon_repository/dungeon_repository.dart';
import 'package:mdm_domain/mdm_domain.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/dungeons/[id]/objects.dart' as route;

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

        when(() => repository.listDungeonObjects(1))
            .thenAnswer((invocation) async {
          return [
            const DungeonObject(
              id: 1,
              dungeonId: 1,
              name: 'Wall',
              description: '',
              solid: true,
            ),
          ];
        });

        final response = await route.onRequest(context, 1.toString());
        expect(response.statusCode, equals(HttpStatus.ok));
        expect(
          await response.json(),
          equals(
            [
              {
                'id': 1,
                'dungeonId': 1,
                'name': 'Wall',
                'description': '',
                'solid': true,
                'sprite': null,
              },
            ],
          ),
        );
      });
    });
  });
}
