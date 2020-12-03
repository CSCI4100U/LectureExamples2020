// CSCI 4100U - 12 - Game Development

import 'dart:ui';

import 'tile.dart';

class Obstacle extends Tile {
  Obstacle({Size screenSize,     double tileSize,
            double xOffset,      double yOffset,
            double xSpeed = 4.0, double ySpeed = 0.0,
            image}) : super(
              screenSize: screenSize,
              tileSize: tileSize,
              xOffset: xOffset,
              yOffset: yOffset,
              xSpeed: xSpeed,
              ySpeed: ySpeed,
              image: image,
            );

  bool update(double dt) {
    xOffset -= xSpeed * dt;
    yOffset -= ySpeed * dt;

    // check if this obstacle is off the screen
    if (xOffset < -1) {
      // tell the level class to delete this obstacle
      return true;
    }

    // convert to screen coordinates
    double xPixelOffset = toScreenX(xOffset);
    double yPixelOffset = toScreenY(yOffset);
    rect = Rect.fromLTWH(xPixelOffset, yPixelOffset, xSize, ySize);

    return false;
  }
}
