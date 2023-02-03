import 'package:bonfire/bonfire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'game.dart';

double tileSize = 32;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Flame.device.setLandscape();
    await Flame.device.fullScreen();
  }
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Normal',
      ),
      home: const Game(),
    ),
  );
}
