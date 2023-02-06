import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'sound_interaction.wav',
      'attack_player.mp3',
      'attack_fire_ball.wav',
      'explosion.wav',
      'battle_boss.mp3',
      'attack_enemy.mp3'
    ]);
  }

  static void attackEnemyMelee() {
    FlameAudio.play('attack_enemy.mp3', volume: 0.4);
  }

  static void interaction() {
    FlameAudio.play('sound_interaction.wav', volume: 0.4);
  }

  static void attackPlayerMelee() {
    FlameAudio.play('attack_player.mp3', volume: 0.4);
  }

  static void attackRange() {
    FlameAudio.play('attack_fire_ball.wav', volume: 0.3);
  }

  static void explosion() {
    FlameAudio.play('explosion.wav');
  }

  static void playBackgroundBossSound() {
    FlameAudio.bgm.play('battle_boss.mp3');
  }
}
