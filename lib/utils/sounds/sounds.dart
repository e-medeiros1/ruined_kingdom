import 'package:flame_audio/flame_audio.dart';

class Sounds {
  static Future initialize() async {
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll([
      'normal_attack.wav',
      'especial_attack.mp3',
    ]);
  }

//Super sounds
  static void normalAttack() {
    FlameAudio.play('normal_attack.wav', volume: 0.3);
  }

  static void especialAttack() {
    FlameAudio.play('especial_attack.mp3', volume: 0.3);
  }

  static void superDeath() {
    FlameAudio.play('super_death.wav', volume: 0.3);
  }

//Enemies sounds
  static void firerDeath() {
    FlameAudio.play('boss_death.wav', volume: 0.3);
  }

  static void deatherDeath() {
    FlameAudio.play('deather_death.wav', volume: 0.3);
  }

  static void ghostDeath() {
    FlameAudio.play('ghost_death.wav', volume: 0.3);
  }

  static void canineDeath() {
    FlameAudio.play('canine_death.wav', volume: 0.3);
  }

  static void bossDeath() {
    FlameAudio.play('firer_death.wav', volume: 0.3);
  }

  static stopBackgroundSound() {
    return FlameAudio.bgm.stop();
  }

  //Game sounds
  // static void playBackgroundSound() async {
  //   await FlameAudio.bgm.stop();
  //   FlameAudio.bgm.play('sound_bg.mp3', volume: 0.1);
  // }

  static void playBackgroundBoosSound() async {
    await FlameAudio.bgm.stop();
    FlameAudio.bgm.play('battle_boss.mp3', volume: 0.1);
  }

  static void pauseBackgroundSound() {
    FlameAudio.bgm.pause();
  }

  static void resumeBackgroundSound() {
    FlameAudio.bgm.resume();
  }

  static void dispose() {
    FlameAudio.bgm.dispose();
  }
}
