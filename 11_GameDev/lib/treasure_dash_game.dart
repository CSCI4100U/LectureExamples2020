import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:gamedev/screens/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'ui/background.dart';
import 'ui/image_button.dart';
import 'ui/text.dart';

class TreasureDashGame extends Game {
  Size screenSize;
  double tileSize;
  double fps = 20;
  double frameDelay;

  Screen currentScreen;
  Background background;

  // menu components

  ImageButton playButton;
  ImageButton creditsButton;
  ImageButton exitButton;

  // gameplay components

  // Level level;
  // Player player;
  int score;
  ImageButton jumpButton;
  ImageButton slideButton;
  Text currentScoreText;
  Text highScoreText;

  // gameover components

  // Text gameOverText;

  final SharedPreferences storage;

  TreasureDashGame(this.storage) {
    initialize();
  }

  Future<void> initialize() async {
    // TODO: load the high score

    // TODO: prepare the audio system

    frameDelay = 1.0 / fps;

    resize(await Flame.util.initialDimensions());

    tileSize = 50;

    // TODO: create our level

    background = Background(this);

    // menu
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
      },
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
        // TODO: Show the credits screen
        print('Show credits');
      },
    );

    exitButton = ImageButton(
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
      },
    );

    // gameplay
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
      xPosRatio: 0.85,
      yPosRatio: 0.3,
      onClick: () {
        // TODO: player jump
        print('jump');
      },
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
      xPosRatio: 0.85,
      yPosRatio: 0.7,
      onClick: () {
        // TODO: player slide
        print('slide');
      },
    );

    goToGameState(Screen.menu);
  }

  void render(Canvas canvas) {
    background?.render(canvas);

    if (currentScreen == Screen.menu) {
      playButton?.render(canvas);
      creditsButton?.render(canvas);
      exitButton?.render(canvas);
    } else if (currentScreen == Screen.gameplay) {
      jumpButton?.render(canvas);
      slideButton?.render(canvas);
    }
  }

  void update(double dt) {
    // TODO: update the level

    // TODO: update the player

    // TODO: update the score
  }

  bool passTapIfNecessary(
      Screen desiredScreen, ImageButton button, TapDownDetails event) {
    if ((currentScreen == desiredScreen) &&
        button.rect.contains(event.globalPosition)) {
      button.onTapDown();
      return true;
    }
    return false;
  }

  void onTapDown(TapDownDetails event) {
    bool isHandled = false;

    isHandled = passTapIfNecessary(Screen.menu, playButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.menu, creditsButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.menu, exitButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.gameplay, jumpButton, event);
    if (isHandled) return;

    isHandled = passTapIfNecessary(Screen.gameplay, slideButton, event);
    if (isHandled) return;
  }

  void goToGameState(Screen gameState) {
    currentScreen = gameState;

    // TODO: reset the audio
  }

  void resize(Size size) {
    screenSize = size;
  }
}
