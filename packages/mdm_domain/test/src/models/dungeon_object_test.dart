// ignore_for_file: prefer_const_constructors

import 'package:mdm_domain/mdm_domain.dart';
import 'package:test/test.dart';

void main() {
  group('DungeonObject', () {
    test('can be instantiated', () {
      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          x: 0,
          y: 0,
          solid: true,
          name: '',
          description: '',
        ),
        isNotNull,
      );
    });

    test('supports value comparison', () {
      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          x: 0,
          y: 0,
          solid: true,
          name: '',
          description: '',
          sprite: '',
        ),
        equals(
          DungeonObject(
            id: 0,
            dungeonId: 0,
            x: 0,
            y: 0,
            solid: true,
            name: '',
            description: '',
            sprite: '',
          ),
        ),
      );

      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          x: 0,
          y: 0,
          solid: true,
          name: '',
          description: '',
          sprite: '',
        ),
        isNot(
          equals(
            DungeonObject(
              id: 1,
              dungeonId: 0,
              solid: true,
              x: 0,
              y: 0,
              name: '',
              description: '',
              sprite: '',
            ),
          ),
        ),
      );

      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          x: 0,
          y: 0,
          solid: true,
          name: '',
          description: '',
          sprite: '',
        ),
        isNot(
          equals(
            DungeonObject(
              id: 0,
              dungeonId: 1,
              x: 0,
              y: 0,
              solid: true,
              name: '',
              description: '',
              sprite: '',
            ),
          ),
        ),
      );

      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          x: 0,
          y: 0,
          solid: true,
          name: '',
          description: '',
          sprite: '',
        ),
        isNot(
          equals(
            DungeonObject(
              id: 0,
              dungeonId: 0,
              x: 0,
              y: 0,
              solid: false,
              name: '',
              description: '',
              sprite: '',
            ),
          ),
        ),
      );

      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          x: 0,
          y: 0,
          solid: true,
          name: '',
          description: '',
          sprite: '',
        ),
        isNot(
          equals(
            DungeonObject(
              id: 0,
              dungeonId: 0,
              x: 0,
              y: 0,
              solid: true,
              name: 'a',
              description: '',
              sprite: '',
            ),
          ),
        ),
      );

      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          x: 0,
          y: 0,
          solid: true,
          name: '',
          description: '',
          sprite: '',
        ),
        isNot(
          equals(
            DungeonObject(
              id: 0,
              dungeonId: 0,
              x: 0,
              y: 0,
              solid: true,
              name: '',
              description: '1',
              sprite: '',
            ),
          ),
        ),
      );

      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          solid: true,
          x: 0,
          y: 0,
          name: '',
          description: '',
          sprite: '',
        ),
        isNot(
          equals(
            DungeonObject(
              id: 0,
              dungeonId: 0,
              x: 0,
              y: 0,
              solid: true,
              name: '',
              description: '',
              sprite: '1',
            ),
          ),
        ),
      );

      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          solid: true,
          x: 0,
          y: 0,
          name: '',
          description: '',
          sprite: '',
        ),
        isNot(
          equals(
            DungeonObject(
              id: 0,
              dungeonId: 0,
              x: 1,
              y: 0,
              solid: true,
              name: '',
              description: '',
              sprite: '',
            ),
          ),
        ),
      );

      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          solid: true,
          x: 0,
          y: 0,
          name: '',
          description: '',
          sprite: '',
        ),
        isNot(
          equals(
            DungeonObject(
              id: 0,
              dungeonId: 0,
              x: 0,
              y: 1,
              solid: true,
              name: '',
              description: '',
              sprite: '',
            ),
          ),
        ),
      );
    });

    test('serializes to json', () {
      expect(
        DungeonObject(
          id: 0,
          dungeonId: 0,
          solid: true,
          x: 0,
          y: 0,
          name: 'name',
          description: 'description',
          sprite: '1',
        ).toJson(),
        equals(
          {
            'id': 0,
            'name': 'name',
            'dungeonId': 0,
            'solid': true,
            'x': 0,
            'y': 0,
            'description': 'description',
            'sprite': '1',
          },
        ),
      );
    });

    test('deserializes from json', () {
      expect(
        DungeonObject.fromJson(const <String, dynamic>{
          'id': 0,
          'name': 'name',
          'dungeonId': 0,
          'solid': true,
          'x': 1,
          'y': 1,
          'description': 'description',
          'sprite': '1',
        }),
        equals(
          DungeonObject(
            id: 0,
            dungeonId: 0,
            solid: true,
            x: 1,
            y: 1,
            name: 'name',
            description: 'description',
            sprite: '1',
          ),
        ),
      );
    });
  });
}
