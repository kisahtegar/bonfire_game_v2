import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import '../player/knight.dart';
import 'bar_life_component.dart' as bar;

class KnightInterface extends GameInterface {
  late Sprite key;

  @override
  Future<void> onLoad() async {
    key = await Sprite.load('items/key_silver.png');
    add(bar.BarLifeComponent());
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    try {
      _drawKey(canvas);
    } catch (e) {}
    super.render(canvas);
  }

  void _drawKey(Canvas c) {
    if (gameRef.player != null && (gameRef.player as Knight).containKey) {
      key.renderRect(c, const Rect.fromLTWH(150, 20, 35, 30));
    }
  }
}
