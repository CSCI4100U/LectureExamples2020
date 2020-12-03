// CSCI 4100U - 12 - Game Development

import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:gamedev/ui/background.dart';
import 'package:gamedev/ui/image_button.dart';
import 'package:gamedev/ui/image_toggle_button.dart';
import 'package:gamedev/ui/player.dart';
import 'package:gamedev/ui/text.dart';
import 'package:gamedev/screens/screen.dart';
import 'package:gamedev/screens/credits.dart';
import 'audio/audio.dart';
import 'levels/level.dart';

class TreasureDashGame extends Game {
  Size screenSize;
  double tileSize;
  double fps = 20;
  double frameDelay;

  Screen currentScreen;
  ImageButton playButton;
  ImageButton quitButton;
  ImageButton creditsButton;
  ImageButton musicButton;
  ImageButton playAgainButton;

  Background background;
  Level level;
  Player player;
  ImageButton jumpButton;
  ImageButton slideButton;
  Text currentScoreText;
  Text highScoreText;
  Text gameOverText;

  CreditsScreen creditsScreen;

  int score;
  int highScore;

  Audio audio;

  bool gameOver = false;

  final SharedPreferences storage;

  TreasureDashGame(this.storage) {
    initialize();
  }

  Future<void> initialize() async {
    score = 0;
    highScore = storage.containsKey('highScore') ? storage.get('highScore') : 0;

    audio = Audio();

    frameDelay = 1.0 / fps;

    resize(await Flame.util.initialDimensions());

    tileSize = 50; // override
    level = Level(screenSize: screenSize, tileSize: tileSize);

    background = Background(this);

    playButton = ImageButton(
      screenSize: screenSize,
      image: 'button_background.png',
      text: 'Play',
      textSize: 50,
      xPadding: 60,
      yPadding: 35,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.3,
      onClick: () {
        goToGameState(Screen.gameplay);
        score = 0;
      }
    );

    creditsButton = ImageButton(
      screenSize: screenSize,
      image: 'button_background.png',
      text: 'Credits',
      textSize: 30,
      xPadding: 40,
      yPadding: 25,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.6,
      onClick: () {
        creditsScreen.show();
      }
    );

    quitButton = ImageButton(
      screenSize: screenSize,
      image: 'button_background.png',
      text: 'Quit',
      textSize: 30,
      xPadding: 40,
      yPadding: 25,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.8,
      onClick: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    );

    musicButton = ImageToggleButton(
      screenSize: screenSize,
      imageOn: 'controls/music-on.png',
      imageOff: 'controls/music-off.png',
      xPosRatio: 0.05,
      yPosRatio: 0.1,
      toggleState: true,
      onClick: (toggleState) {
        //audio.toggleMusic(toggleState);
      }
    );

    creditsScreen = CreditsScreen(
      screenSize: screenSize,
      image: 'parchment.png',
      onClose: () {
        creditsScreen.hide();
      }
    );

    // create the player
    player = Player(
      screenSize: screenSize, 
      frameDelay: frameDelay * 2, 
      jumpSpeed: 11.0, 
      gameOverCallback: () {
        gameOver = true;
        currentScreen = Screen.playagain;
      }
    );

    // create the controls
    jumpButton = ImageButton(
      screenSize: screenSize,
      image: 'controls/arrow-up.png',
      text: ' ',
      textSize: 30,
      xPadding: 40,
      yPadding: 25,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.9,
      yPosRatio: 0.3,
      onClick: () {
        player.jump();
      }
    );

    slideButton = ImageButton(
      screenSize: screenSize,
      image: 'controls/arrow-down.png',
      text: ' ',
      textSize: 30,
      xPadding: 40,
      yPadding: 25,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.9,
      yPosRatio: 0.7,
      onClick: () {
        player.slide();
      }
    );

    currentScoreText = Text(
      screenSize: screenSize,
      text: 'Score: $score',
      textSize: 30,
      xOffset: 0,
      yOffset: 0,
      xPosRatio: 0.2,
      yPosRatio: 0.1,
    );

    highScoreText = Text(
      screenSize: screenSize,
      text: 'High Score: $highScore',
      textSize: 30,
      xOffset: 0,
      yOffset: 0,
      xPosRatio: 0.8,
      yPosRatio: 0.1,
    );

    gameOverText = Text(
      screenSize: screenSize,
      text: 'Game Over',
      textSize: 70,
      xOffset: 0,
      yOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.4,
    );

    playAgainButton = ImageButton(
      screenSize: screenSize,
      image: 'button_background.png',
      text: 'Play Again',
      textSize: 50,
      xPadding: 60,
      yPadding: 35,
      xOffset: 0,
      yOffset: 5,
      xTextOffset: 0,
      yTextOffset: 0,
      xPosRatio: 0.5,
      yPosRatio: 0.7,
      onClick: () {
        goToGameState(Screen.gameplay);
        level.initialize();
        player.reset();
        score = 0;
        gameOver = false;
      }
    );

    // initially, show the menu
    goToGameState(Screen.menu);
  }

  void goToGameState(Screen gameState) {
    currentScreen = gameState;

    audio.resetMusic();
  }

  void render(Canvas canvas) {
    background?.render(canvas);

    if (currentScreen == Screen.menu) {
      playButton?.render(canvas);
      creditsButton?.render(canvas);
      quitButton?.render(canvas);
      musicButton?.render(canvas);
      creditsScreen?.render(canvas);
    } else if (currentScreen == Screen.gameplay) {
      level?.render(canvas);
      player?.render(canvas);
      jumpButton?.render(canvas);
      slideButton?.render(canvas);
      currentScoreText?.render(canvas);
      highScoreText?.render(canvas);
    } else if (currentScreen == Screen.playagain) {
      gameOverText?.render(canvas);
      playAgainButton?.render(canvas);
      currentScoreText?.render(canvas);
      highScoreText?.render(canvas);
    }
  }

  void update(double dt) {
    if (!gameOver && currentScreen == Screen.gameplay) {
      // update tiles, obstacles, and coins
      level?.update(dt);

      // update player animations and position
      player?.update(dt);

      // check for collisions with obstacles and coins
      addToScore(level?.checkPlayerCollisions(player));
    }
  }

  void resize(Size size) {
    screenSize = size;
  }

  void addToScore(int amount) {
    score += amount;
    currentScoreText.setText('Score: $score');

    if (score > highScore) {
      highScore = score;
      storage.setInt("highScore", highScore);
      highScoreText.setText('High Score: $highScore');
    }
  }

  bool passTapIfNecessary(Screen desiredScreen, ImageButton button, TapDownDetails event) {
    if (button.rect.contains(event.globalPosition)) {
      if (currentScreen == desiredScreen) {
        button.onTapDown();
        return true;
      }
    }
    return false;
  }

  void onTapDown(TapDownDetails event) {
    bool isHandled = false;

    // pass along taps to the buttons, if within their rectangle bounds

    if (creditsScreen.isVisible) {
      isHandled = passTapIfNecessary(Screen.menu, creditsScreen, event);
      if (isHandled) return;
    }

    isHandled = passTapIfNecessary(Screen.menu, playButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.menu, creditsButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.menu, quitButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.menu, musicButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.gameplay, jumpButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.gameplay, slideButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.playagain, playAgainButton, event);
    if (isHandled) return;
  }
}