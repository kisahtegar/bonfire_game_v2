import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../player/knight.dart';
import '../util/localization/strings_location.dart';
import '../util/sprite_sheet/game_sprite_sheet.dart';

class Door extends GameDecoration with ObjectCollision {
  bool open = false;
  bool showDialog = false;

  Door(Vector2 position, Vector2 size)
      : super.withSprite(
          sprite: Sprite.load('items/door_closed.png'),
          position: position,
          size: size,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(width, height / 4),
            align: Vector2(0, height * 0.75),
          ),
        ],
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameRef.player != null) {
      seeComponent(
        gameRef.player!,
        observed: (player) {
          if (!open) {
            Knight p = player as Knight;
            if (p.containKey == true) {
              open = true;
              gameRef.add(
                AnimatedObjectOnce(
                  animation: GameSpriteSheet.openTheDoor(),
                  position: position,
                  onFinish: () {
                    p.containKey = false;
                  },
                  size: Vector2(32, 32),
                ),
              );
              Future.delayed(const Duration(milliseconds: 200), () {
                removeFromParent();
              });
            } else {
              if (!showDialog) {
                showDialog = true;
                _showIntroduction();
              }
            }
          }
        },
        notObserved: () {
          showDialog = false;
        },
        radiusVision: (1 * tileSize),
      );
    }
  }

  void _showIntroduction() {
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [
            TextSpan(
              text: getString('door_without_key'),
            )
          ],
          person: (gameRef.player as SimplePlayer?)
                  ?.animation
                  ?.idleRight
                  ?.asWidget() ??
              const SizedBox.shrink(),
          personSayDirection: PersonSayDirection.LEFT,
        )
      ],
    );
  }
}
