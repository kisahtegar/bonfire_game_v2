import 'package:bonfire/bonfire.dart';

class NpcSpriteSheet {
  // Wizard Idle in left position
  static Future<SpriteAnimation> wizardIdleLeft() => SpriteAnimation.load(
        'npc/wizard_idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 22),
        ),
      );

  // NPC Idle in left position
  static Future<SpriteAnimation> kidIdleLeft() => SpriteAnimation.load(
        'npc/kid_idle_left.png',
        SpriteAnimationData.sequenced(
          amount: 4,
          stepTime: 0.1,
          textureSize: Vector2(16, 22),
        ),
      );
}
