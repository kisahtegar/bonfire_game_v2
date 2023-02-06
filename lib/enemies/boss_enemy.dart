import 'dart:ui';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../util/const.dart';
import '../util/localization/strings_location.dart';
import '../util/sounds.dart';
import '../util/sprite_sheet/custom_sprite_animation_widget.dart';
import '../util/sprite_sheet/enemy_sprite_sheet.dart';
import '../util/sprite_sheet/game_sprite_sheet.dart';
import '../util/sprite_sheet/npc_sprite_sheet.dart';
import '../util/sprite_sheet/player_sprite_sheet.dart';
import 'imp_enemy.dart';
import 'miniboss_enemy.dart';

class Boss extends SimpleEnemy with ObjectCollision {
  final Vector2 initPosition;
  double attack = 1; // 40

  bool firstSeePlayer = false;
  List<Enemy> childrenEnemy = [];

  Boss(this.initPosition)
      : super(
          animation: EnemySpriteSheet.bossAnimations(),
          position: initPosition,
          size: Vector2(tileSize * 1.5, tileSize * 1.7),
          speed: tileSize / 0.35,
          life: 200,
        ) {
    setupCollision(
      CollisionConfig(
        collisions: [
          CollisionArea.rectangle(
            size: Vector2(valueByTileSize(14), valueByTileSize(16)),
            align: Vector2(valueByTileSize(5), valueByTileSize(11)),
          ),
        ],
      ),
    );
  }

  // Update Statement
  @override
  void update(double dt) {
    if (!firstSeePlayer) {
      seePlayer(
        observed: (p) {
          firstSeePlayer = true;
          gameRef.camera.moveToTargetAnimated(
            this,
            zoom: 2,
            finish: () {
              _showConversation();
            },
          );
        },
        radiusVision: tileSize * 5,
      );
    }

    if (life < 150 && childrenEnemy.isEmpty) {
      addChildInMap(dt);
    }

    if (life < 100 && childrenEnemy.length == 1) {
      addChildInMap(dt);
    }

    if (life < 50 && childrenEnemy.length == 2) {
      addChildInMap(dt);
    }

    seeAndMoveToPlayer(
      closePlayer: (player) {
        execAttack();
      },
      radiusVision: tileSize * 3,
    );
    super.update(dt);
  }

  // Rendering
  @override
  void render(Canvas canvas) {
    drawDefaultLifeBar(canvas);
    drawBarSummonEnemy(canvas);
    super.render(canvas);
  }

  // Received Damage from Player
  @override
  void receiveDamage(AttackFromEnum attacker, double damage, identify) {
    showDamage(
      damage,
      config: TextStyle(
        fontSize: valueByTileSize(5),
        color: Colors.white,
        fontFamily: 'Normal',
      ),
    );
    super.receiveDamage(attacker, damage, identify);
  }

  // if boss die...
  @override
  void die() {
    gameRef.add(
      AnimatedObjectOnce(
        animation: GameSpriteSheet.explosion(),
        position: position,
        size: Vector2(32, 32),
      ),
    );
    for (var e in childrenEnemy) {
      if (!e.isDead) e.die();
    }
    removeFromParent();
    super.die();
  }

  // This bar for summoning Enemy (by default have 3 bar)
  void drawBarSummonEnemy(Canvas canvas) {
    double yPosition = position.y;
    double widthBar = (width - 10) / 3;
    if (childrenEnemy.isEmpty) {
      canvas.drawLine(
          Offset(position.x, yPosition),
          Offset(position.x + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);
    }

    double lastX = position.x + widthBar + 5;
    if (childrenEnemy.length < 2) {
      canvas.drawLine(
          Offset(lastX, yPosition),
          Offset(lastX + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);
    }

    lastX = lastX + widthBar + 5;
    if (childrenEnemy.length < 3) {
      canvas.drawLine(
          Offset(lastX, yPosition),
          Offset(lastX + widthBar, yPosition),
          Paint()
            ..color = Colors.orange
            ..strokeWidth = 1
            ..style = PaintingStyle.fill);
    }
  }

  // Execute attack
  void execAttack() {
    simpleAttackMelee(
      size: Vector2.all(tileSize * 0.62),
      damage: attack,
      interval: 1500,
      animationRight: EnemySpriteSheet.enemyAttackEffectRight(),
      execute: () {
        Sounds.attackEnemyMelee();
      },
    );
  }

  // Initialize child
  void addInitChild() {
    addImp(position.x - tileSize, position.x - tileSize);
    addImp(position.x - tileSize, position.x); //position.bottom + tileSize);
  }

  // Adding Imp enemyy
  void addImp(double x, double y) {
    gameRef.add(
      AnimatedObjectOnce(
        animation: GameSpriteSheet.smokeExplosion(),
        position: Vector2(x, y),
        size: Vector2(32, 32),
      ),
    );
    gameRef.add(
      Imp(
        Vector2(x, y),
      ),
    );
  }

  // Show Conversation
  void _showConversation() {
    Sounds.interaction();
    TalkDialog.show(
      gameRef.context,
      [
        Say(
          text: [TextSpan(text: getString('talk_kid_1'))],
          person: CustomSpriteAnimationWidget(
            animation: NpcSpriteSheet.kidIdleLeft(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_boss_1'))],
          person: CustomSpriteAnimationWidget(
            animation: EnemySpriteSheet.bossIdleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_player_3'))],
          person: CustomSpriteAnimationWidget(
            animation: PlayerSpriteSheet.idleRight(),
          ),
          personSayDirection: PersonSayDirection.LEFT,
        ),
        Say(
          text: [TextSpan(text: getString('talk_boss_2'))],
          person: CustomSpriteAnimationWidget(
            animation: EnemySpriteSheet.bossIdleRight(),
          ),
          personSayDirection: PersonSayDirection.RIGHT,
        ),
      ],
      onFinish: () {
        Sounds.interaction();
        addInitChild();
        Future.delayed(Duration(milliseconds: 500), () {
          gameRef.camera.moveToPlayerAnimated();
          Sounds.playBackgroundBossSound();
        });
      },
      onChangeTalk: (index) {
        Sounds.interaction();
      },
      logicalKeyboardKeysToNext: [
        LogicalKeyboardKey.space,
      ],
    );
  }

  // Adding child to map
  void addChildInMap(double dt) {
    if (checkInterval('addChild', 5000, dt)) {
      Vector2 positionExplosion = Vector2.zero();

      switch (directionThePlayerIsIn()) {
        case Direction.left:
          positionExplosion = position.translate(width * -2, 0);
          break;
        case Direction.right:
          positionExplosion = position.translate(width * 2, 0);
          break;
        case Direction.up:
          positionExplosion = position.translate(0, height * -2);
          break;
        case Direction.down:
          positionExplosion = position.translate(0, height * 2);
          break;
        case Direction.upLeft:
          // TODO: Handle this case.
          break;
        case Direction.upRight:
          // TODO: Handle this case.
          break;
        case Direction.downLeft:
          // TODO: Handle this case.
          break;
        case Direction.downRight:
          // TODO: Handle this case.
          break;
        default:
      }

      Enemy e = childrenEnemy.length == 2
          ? MiniBoss(
              Vector2(
                positionExplosion.x,
                positionExplosion.y,
              ),
            )
          : Imp(
              Vector2(
                positionExplosion.x,
                positionExplosion.y,
              ),
            );

      gameRef.add(
        AnimatedObjectOnce(
          animation: GameSpriteSheet.smokeExplosion(),
          position: positionExplosion,
          size: Vector2(32, 32),
        ),
      );

      childrenEnemy.add(e);
      gameRef.add(e);
    }
  }
}
