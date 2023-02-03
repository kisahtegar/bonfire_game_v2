import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static void interaction() {
    FlameAudio.play('sound_interaction.wav', volume: 0.4);
  }

  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'sound_interaction.wav',
    ]);
  }
}
