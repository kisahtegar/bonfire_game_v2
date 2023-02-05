import 'package:bonfire/bonfire.dart';

class GameSpriteSheet {
  // Torch Decoration.
  static Future<SpriteAnimation> torch() => SpriteAnimation.load(
        'items/torch_spritesheet.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static smokeExplosion() => SpriteAnimation.load(
        'smoke_explosin.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  // Fireball attack effect in right position.
  static Future<SpriteAnimation> fireBallAttackRight() => SpriteAnimation.load(
        'player/fireball_right.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  // Fireball attack effect in left position.
  static Future<SpriteAnimation> fireBallAttackLeft() => SpriteAnimation.load(
        'player/fireball_left.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  // Fireball attack effect in top position.
  static Future<SpriteAnimation> fireBallAttackTop() => SpriteAnimation.load(
        'player/fireball_top.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  // Fireball attack effect in bottom position.
  static Future<SpriteAnimation> fireBallAttackBottom() => SpriteAnimation.load(
        'player/fireball_bottom.png',
        SpriteAnimationData.sequenced(
          amount: 3,
          stepTime: 0.1,
          textureSize: Vector2(23, 23),
        ),
      );

  // Fireball attack effect exposion.
  static Future<SpriteAnimation> fireBallExplosion() => SpriteAnimation.load(
        'player/explosion_fire.png',
        SpriteAnimationData.sequenced(
          amount: 6,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );

  static Future<SpriteAnimation> explosion() => SpriteAnimation.load(
        'explosion.png',
        SpriteAnimationData.sequenced(
          amount: 7,
          stepTime: 0.1,
          textureSize: Vector2(32, 32),
        ),
      );
}
