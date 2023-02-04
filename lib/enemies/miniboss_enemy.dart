import 'package:bonfire/bonfire.dart';

import '../main.dart';
import '../util/const.dart';
import '../util/sprite_sheet/enemy_sprite_sheet.dart';

class MiniBoss extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 50;
  bool _seePlayerClose = false;

  MiniBoss(this.initPosition)
      : super(
          animation: EnemySpriteSheet.miniBossAnimations,
          position: initPosition,
          size: Vector2(tileSize * 0.68, tileSize * 0.93),
          speed: tileSize / 0.35,
          life: 150,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(valueByTileSize(6), valueByTileSize(7)),
            align: Vector2(valueByTileSize(2.5), valueByTileSize(8)),
          ),
        ],
      ),
    );
  }
}
