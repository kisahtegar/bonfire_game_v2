import 'package:bonfire/bonfire.dart';

class GameSpriteSheet {
  static Future<SpriteAnimation> torch() => SpriteAnimation.load(
        'items/torch_spritesheet.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );
}
