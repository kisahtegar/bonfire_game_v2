import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../util/const.dart';
import '../util/sprite_sheet/player_sprite_sheet.dart';

class Knight extends SimplePlayer with Lighting, ObjectCollision {
  Knight(Vector2 position)
      : super(
          animation: PlayerSpriteSheet.playerAnimations(),
          size: Vector2.all(tileSize),
          position: position,
          life: 200,
          speed: tileSize / 0.25,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(valueByTileSize(8), valueByTileSize(8)),
            align: Vector2(
              valueByTileSize(4),
              valueByTileSize(8),
            ),
          ),
        ],
      ),
    );

    setupLighting(
      LightingConfig(
        radius: width * 1.5,
        blurBorder: width,
        color: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
    );
  }
}
