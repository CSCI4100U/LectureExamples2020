// CSCI 4100U - 12 - Game Development

import 'dart:math';
import 'dart:ui';

import 'package:gamedev/ui/obstacle.dart';
import 'package:gamedev/ui/player.dart';
import 'package:gamedev/ui/tile.dart';
import 'package:gamedev/ui/coin.dart';

class Level {
  Random random;
  Size screenSize;
  double tileSize;
  List<Tile> floorTiles;
  List<Tile> obstacleTiles;
  List<Coin> coins;
  double numTilesLength;

  Level({this.screenSize, this.tileSize}) {
    initialize();
  }

  void initialize() {
    random = Random(DateTime.now().millisecondsSinceEpoch);

    floorTiles = [];
    obstacleTiles = [];
    coins = [];

    // floor tiles
    numTilesLength = 100;
    for (double xPos = 0; xPos < numTilesLength; xPos += 1) {
      floorTiles.add(Tile(
        screenSize: screenSize,
        tileSize: tileSize,
        image: 'objects/stone_block.png',
        xOffset: xPos,
        yOffset: 0,
      ));
    }

    // first two obstacles
    createObstacle(Tile.MAX_X_OFFSET);
    createObstacle(Tile.MAX_X_OFFSET + 10);
  }

  void createObstacle(double xOffset) {
    double rand = random.nextDouble();
    if (rand < 0.5) {
      createJump(xOffset);
    } else {
      createSlide(xOffset);
    }
  }

  void createJump(double xOffset) {
    obstacleTiles.add(Obstacle(
      screenSize: screenSize,
      tileSize: tileSize,
      image: 'objects/crate.png',
      xOffset: xOffset,
      yOffset: 1,
    ));
    obstacleTiles.add(Obstacle(
      screenSize: screenSize,
      tileSize: tileSize,
      image: 'objects/crate.png',
      xOffset: xOffset,
      yOffset: 2,
    ));
    coins.add(Coin(
      screenSize: screenSize,
      tileSize: tileSize,
      xOffset: xOffset,
      yOffset: 4,
    ));
  }

  void createSlide(double xOffset) {
    obstacleTiles.add(Obstacle(
      screenSize: screenSize,
      tileSize: tileSize,
      image: 'objects/crate.png',
      xOffset: xOffset,
      yOffset: 2.6,
    ));
    coins.add(Coin(
      screenSize: screenSize,
      tileSize: tileSize,
      xOffset: xOffset,
      yOffset: 1,
    ));
  }

  void render(Canvas canvas) {
    for (Tile tile in floorTiles) {
      tile.render(canvas);
    }
    for (Obstacle tile in obstacleTiles) {
      tile.render(canvas);
    }
    for (Coin coin in coins) {
      coin.render(canvas);
    }
  }

  void update(double dt) {
    // slide the floor tiles
    for (Tile tile in floorTiles) {
      tile.update(dt);
    }

    // update the obstacles, deleting any that are off screen
    bool obstaclesDeleted = false;
    for (int i = obstacleTiles.length - 1; i >= 0 ; i--) {
      if (obstacleTiles[i].update(dt)) {
        obstacleTiles.removeAt(i);
        obstaclesDeleted = true;
      }
    }

    // create a new obstacle to replace the one deleted
    if (obstaclesDeleted) {
      createObstacle(Tile.MAX_X_OFFSET + 2);
    }

    // update the coins
    for (Coin coin in coins) {
      coin.update(dt);
    }
  }

  int checkPlayerCollisions(Player player) {
    for (Tile tile in obstacleTiles) {
      if (player.collidesWith(tile.rect)) {
        player.die();
      }
    }

    int scoreIncrease = 0;
    for (Coin coin in coins) {
      if (!coin.isCollected && player.collidesWith(coin.rect)) {
        scoreIncrease += coin.value;
        coin.collect();
      }
    }
    return scoreIncrease;
  }
}