// CSCI 4100U - 12 - Game Development

import 'dart:ui';

//import 'package:flutter/painting.dart';

import 'package:flame/sprite.dart';

enum PlayerState {
  running,
  jumping,
  sliding,
  dying,
  gameover,
}

class Player {
  static const double PLAYER_WIDTH = 50;
  static const double PLAYER_HEIGHT = 50;

  Size screenSize;

  List<String> runFrames;
  List<String> jumpFrames;
  List<String> slideFrames;
  List<String> dieFrames;

  PlayerState playerState;
  int frameNum;
  int lastActionTime;

  double xOffset = 0;
  double yOffset = 0;
  double xSize = 1;
  double ySize = 1;
  double xSpeed = 0;
  double ySpeed = 0;
  double yAccel = 0;
  double jumpSpeed;

  Rect rect;
  Sprite sprite;

  double frameDelay;
  double timeSinceLastFrame;

  double timeSinceLastAction;
  double deathDuration = 1.2;
  double slideDuration = 0.8;

  Rect hitBox;
  bool debugShowHitBox = false;
  Paint debugPaint;

  Function gameOverCallback;

  Player({this.screenSize,
          this.frameDelay,
          this.xOffset = 3,
          this.yOffset = 1.9,
          this.xSize = PLAYER_WIDTH * 2,
          this.ySize = PLAYER_HEIGHT * 2,
          this.jumpSpeed,
          this.debugShowHitBox = false,
          this.gameOverCallback}) {

    hitBox = Rect.fromLTWH(toScreenX(xOffset) + xSize / 4, toScreenY(yOffset) + ySize / 8, xSize * 0.4, ySize * 0.75);
    debugPaint = Paint();
    debugPaint.color = Color.fromARGB(255, 0, 0, 0);
    debugPaint.style = PaintingStyle.stroke;

    timeSinceLastFrame = 0;
    timeSinceLastAction = 0;

    yAccel = -20.0;

    rect = Rect.fromLTWH(toScreenX(xOffset), toScreenY(yOffset), xSize, ySize);

    runFrames = [
      'adventuregirl/run1.png',
      'adventuregirl/run2.png',
      'adventuregirl/run3.png',
      'adventuregirl/run4.png',
      'adventuregirl/run5.png',
      'adventuregirl/run6.png',
      'adventuregirl/run7.png',
      'adventuregirl/run8.png',
    ];

    jumpFrames = [
      'adventuregirl/jump1.png',
      'adventuregirl/jump2.png',
      'adventuregirl/jump3.png',
      'adventuregirl/jump4.png',
      'adventuregirl/jump5.png',
      'adventuregirl/jump6.png',
      'adventuregirl/jump7.png',
      'adventuregirl/jump8.png',
      'adventuregirl/jump9.png',
      'adventuregirl/jump10.png',
    ];

    slideFrames = [
      'adventuregirl/slide1.png',
      'adventuregirl/slide2.png',
      'adventuregirl/slide3.png',
      'adventuregirl/slide4.png',
      'adventuregirl/slide5.png',
    ];

    dieFrames = [
      'adventuregirl/dead1.png',
      'adventuregirl/dead2.png',
      'adventuregirl/dead3.png',
      'adventuregirl/dead4.png',
      'adventuregirl/dead5.png',
      'adventuregirl/dead6.png',
      'adventuregirl/dead7.png',
      'adventuregirl/dead8.png',
      'adventuregirl/dead9.png',
      'adventuregirl/dead10.png',
    ];

    playerState = PlayerState.running;
    frameNum = 0;
    sprite = Sprite(runFrames[0]);
  }

  void jump() {
    if (playerState == PlayerState.running) {
      playerState = PlayerState.jumping;

      timeSinceLastAction = 0;
      ySpeed = jumpSpeed;

      frameNum = 0;
      sprite = Sprite(jumpFrames[0]);
    }
  }

  void slide() {
    if (playerState == PlayerState.running) {
      playerState = PlayerState.sliding;

      timeSinceLastAction = 0;

      frameNum = 0;
      sprite = Sprite(slideFrames[0]);
    }
  }

  void die() {
    if (playerState != PlayerState.dying) { // catch duplicates
      timeSinceLastAction = 0;

      playerState = PlayerState.dying;

      frameNum = 0;
      sprite = Sprite(dieFrames[0]);

      ySpeed = 0;
    }
  }
  void reset() {
    yOffset = 1.9;
    playerState = PlayerState.running;
  }

  double toScreenX(double x) {
    return x * PLAYER_WIDTH;
  }

  double toScreenY(double y) {
    return 370.0 - (y * PLAYER_HEIGHT);
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    if (debugShowHitBox) {
      c.drawRect(hitBox, debugPaint);
    }
  }

  void update(double dt) {
    if (playerState == PlayerState.gameover) return;

    if (playerState == PlayerState.jumping || playerState == PlayerState.dying) {
      ySpeed += yAccel * dt;
      yOffset += ySpeed * dt;
    }

    // update the frame delay and action timer
    timeSinceLastFrame += dt;
    timeSinceLastAction += dt;

    if (playerState == PlayerState.jumping && ySpeed < 0 && yOffset <= 1.9) {
      // hit the ground while jumping
      ySpeed = 0;
      yOffset = 1.9;
      playerState = PlayerState.running;
      frameNum = 0;
    } else if (playerState == PlayerState.dying && yOffset < 1.7) {
      // hit the ground while dying
      ySpeed = 0;
      yOffset = 1.7;
    } else if (playerState == PlayerState.sliding && timeSinceLastAction > slideDuration) {
      // timer expired for sliding
      playerState = PlayerState.running;
      frameNum = 0;
    }

    // advance to the next frame, if we've waited long enough
    if (timeSinceLastFrame > frameDelay) {
      timeSinceLastFrame = 0;

      // advance to the next animation frame
      frameNum++;

      // check that the frame index is still valid
      // also, update the sprite's image
      if (playerState == PlayerState.jumping) {
        frameNum = frameNum % 10;
        sprite = Sprite(jumpFrames[frameNum]);
      } else if (playerState == PlayerState.running) {
        frameNum = frameNum % 8;
        sprite = Sprite(runFrames[frameNum]);
      } else if (playerState == PlayerState.dying) {
        if (frameNum >= dieFrames.length) {
          // played last frame of death animation - game over
          frameNum = dieFrames.length - 1;
          playerState = PlayerState.gameover;
          gameOverCallback(); // for now, no data
        }
        sprite = Sprite(dieFrames[frameNum]);
      } else { // sliding
        frameNum = frameNum % 5;
        sprite = Sprite(slideFrames[frameNum]);
      }
    }

    // recalculate the drawing rectangle
    rect = Rect.fromLTWH(toScreenX(xOffset), toScreenY(yOffset), xSize, ySize);

    // recalculate the hit box rectangle
    double hitBoxHeight = ySize * 0.75;
    double hitBoxPos = toScreenY(yOffset) + ySize / 8;
    if (playerState == PlayerState.sliding) {
      hitBoxHeight = ySize * 0.5;
      hitBoxPos = toScreenY(yOffset) + ySize / 4;
    }
    hitBox = Rect.fromLTWH(toScreenX(xOffset) + xSize / 4, hitBoxPos, xSize * 0.4, hitBoxHeight);
  }

  bool collidesWith(Rect other) {
    return hitBox.overlaps(other);
  }
}
