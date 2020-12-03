// CSCI 4100U - 12 - Game Development

import 'package:flame/flame.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:gamedev/screens/screen.dart';
import 'package:gamedev/treasure_dash_game.dart';

class Audio {
  TreasureDashGame game;

  AudioPlayer menuMusicPlayer;
  AudioPlayer gameplayMusicPlayer;
  
  bool musicEnabled = false;

  Audio({this.game}) {
    // background music
    /*
    menuMusicPlayer = await Flame.audio.loopLongAudio('music/menu.mp3', volume: 0.5);
    menuMusicPlayer.pause();
    gameplayMusicPlayer = await Flame.audio.loopLongAudio('music/gameplay.mp3', volume: 0.5);
    gameplayMusicPlayer.pause();
    */
  }

  void toggleMusic(bool enable) {
    AudioPlayer player;
    if (game.currentScreen == Screen.menu) {
      player = menuMusicPlayer;
    } else {
      player = gameplayMusicPlayer;
    }

    if (enable) {
      player.resume();
    } else {
      player.pause();
    }
  }

  void resetMusic() {
    /*
    gameplayMusicPlayer.pause();
    gameplayMusicPlayer.seek(Duration.zero);
    menuMusicPlayer.pause();
    menuMusicPlayer.seek(Duration.zero);

    if (game.currentScreen == Screen.menu) {
      menuMusicPlayer.resume();
    } else if (game.currentScreen == Screen.gameplay) {
      gameplayMusicPlayer.resume();
    }
    */
  }
}