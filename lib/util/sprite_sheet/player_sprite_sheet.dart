import 'package:bonfire/bonfire.dart';

class PlayerSpriteSheet {
  static Future<SpriteAnimation> idleRight() => SpriteAnimation.load(
        'player/knight_idle.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 16),
        ),
      );

  static SimpleDirectionAnimation playerAnimations() =>
      SimpleDirectionAnimation(
        // Player AFK
        idleRight: idleRight(),
        idleLeft: SpriteAnimation.load(
          'player/knight_idle_left.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),

        // Player Run
        runRight: SpriteAnimation.load(
          'player/knight_run.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
        runLeft: SpriteAnimation.load(
          'player/knight_run_left.png',
          SpriteAnimationData.sequenced(
            amount: 6,
            stepTime: 0.1,
            textureSize: Vector2(16, 16),
          ),
        ),
      );
}
