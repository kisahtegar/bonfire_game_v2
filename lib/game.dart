import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import 'decoration/torch.dart';

import 'enemies/boss_enemy.dart';
import 'enemies/imp_enemy.dart';
import 'interface/knight_interface.dart';
import 'enemies/goblin_enemy.dart';
import 'enemies/miniboss_enemy.dart';
import 'main.dart';
import 'npc/kid.dart';
import 'npc/wizard_npc.dart';
import 'player/knight.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> implements GameListener {
  late GameController _gameController;

  @override
  void initState() {
    _gameController = GameController()..addListener(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;
    tileSize = max(sizeScreen.height, sizeScreen.width) / 15;

    var joystick = Joystick(
      directional: JoystickDirectional(
        spriteBackgroundDirectional:
            Sprite.load('joystick/joystick_background.png'),
        spriteKnobDirectional: Sprite.load('joystick/joystick_knob.png'),
        size: 100,
        isFixed: false,
      ),
      actions: [
        JoystickAction(
          actionId: 0,
          sprite: Sprite.load('joystick/joystick_atack.png'),
          spritePressed: Sprite.load('joystick/joystick_atack_selected.png'),
          size: 80,
          margin: const EdgeInsets.only(bottom: 50, right: 50),
        ),
        JoystickAction(
          actionId: 1,
          sprite: Sprite.load('joystick/joystick_atack_range.png'),
          spritePressed:
              Sprite.load('joystick/joystick_atack_range_selected.png'),
          size: 50,
          margin: const EdgeInsets.only(bottom: 50, right: 160),
        )
      ],
    );

    return Material(
      color: Colors.transparent,
      child: BonfireWidget(
        gameController: _gameController,
        joystick: joystick,
        player: Knight(
          Vector2(2 * tileSize, 3 * tileSize),
        ),
        lightingColorGame: Colors.black.withOpacity(0.6),
        background: BackgroundColorGame(Colors.grey[900]!),
        interface: KnightInterface(),
        map: WorldMapByTiled(
          'tiled/map.json',
          forceTileSize: Vector2(tileSize, tileSize),
          objectsBuilder: {
            'torch': (p) => Torch(p.position),
            'wizard': (p) => WizardNpc(p.position),
            'goblin': (p) => GoblinEnemy(p.position),
            'mini_boss': (p) => MiniBoss(p.position),
            'imp': (p) => Imp(p.position),
            'boss': (p) => Boss(p.position),
            'kid': (p) => Kid(p.position),
          },
        ),
        progress: Container(
          color: Colors.black,
          child: const Center(
            child: Text(
              "Loading...",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Normal',
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void changeCountLiveEnemies(int count) {}

  @override
  void updateGame() {
    // TODO: implement updateGame
  }
}
