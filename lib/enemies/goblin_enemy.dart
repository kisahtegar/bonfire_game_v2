import 'package:bonfire/bonfire.dart';

import '../main.dart';
import '../util/const.dart';
import '../util/sprite_sheet/enemy_sprite_sheet.dart';

class GoblinEnemy extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 25;

  GoblinEnemy(this.initPosition)
      : super(
          animation: EnemySpriteSheet.goblinAnimations(),
          position: initPosition,
          size: Vector2.all(tileSize * 0.8),
          speed: tileSize / 0.35,
          life: 120,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(
              valueByTileSize(7),
              valueByTileSize(7),
            ),
            align: Vector2(valueByTileSize(3), valueByTileSize(4)),
          ),
        ],
      ),
    );
  }
}
