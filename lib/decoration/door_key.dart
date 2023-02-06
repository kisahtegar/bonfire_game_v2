import 'package:bonfire/bonfire.dart';

import '../main.dart';
import '../player/knight.dart';

class DoorKey extends GameDecoration with Sensor {
  DoorKey(Vector2 position)
      : super.withSprite(
          sprite: Sprite.load('items/key_silver.png'),
          position: position,
          size: Vector2(tileSize, tileSize),
        );

  @override
  void onContact(GameComponent component) {
    if (component is Knight) {
      component.containKey = true;
      removeFromParent();
    }
  }

  @override
  void onContactExit(GameComponent component) {
    // TODO: implement onContactExit
  }
}
