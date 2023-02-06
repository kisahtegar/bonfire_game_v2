import 'dart:async' as async;

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class PotionLife extends GameDecoration with Sensor {
  final Vector2 initPosition;
  final double life;
  double _lifeDistributed = 0;

  PotionLife(this.initPosition, this.life)
      : super.withSprite(
          sprite: Sprite.load('items/potion_red.png'),
          position: initPosition,
          size: Vector2(tileSize, tileSize),
        );

  // when player make contact
  @override
  void onContact(GameComponent component) {
    if (component is Player) {
      gameRef.player?.addLife(100);
      // _starTimeAddLife(component);
      removeFromParent();
    }
  }

  // when done
  @override
  void onContactExit(GameComponent component) {
    // TODO: implement onContactExit
    super.onContactExit(component);
  }

  // Add HP or lif
  // void _starTimeAddLife(GameComponent component) {
  //   async.Timer.periodic(
  //     const Duration(milliseconds: 100),
  //     (timer) {
  //       if (_lifeDistributed >= life) {
  //         timer.cancel();
  //       } else {
  //         _lifeDistributed += 2;
  //         gameRef.player!.addLife(5);
  //       }
  //     },
  //   );
  // }
}
