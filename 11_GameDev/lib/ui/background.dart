// CSCI 4100U - 12 - Game Development

import 'dart:ui';

import 'package:flame/sprite.dart';

import 'package:gamedev/treasure_dash_game.dart';

class Background {
  final TreasureDashGame game;
  Sprite bgSprite;
  Rect bgRect;

  Background(this.game) {
    bgSprite = Sprite('background.png');

    bgRect = Rect.fromLTWH(
      0,
      0,
      game.tileSize * 16,
      game.tileSize * 9,
    );
  }

  void render(Canvas c) {
    bgSprite.renderRect(c, bgRect);
  }

  void update(double t) {}
}