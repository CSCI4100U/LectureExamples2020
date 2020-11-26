import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';

class TreasureDashGame extends Game {
  Size screenSize;
  double tileSize;
  double fps = 20;
  double frameDelay;

  Screen currentScreen;
  Level level;
  Player player;
  ImageButton jumpButton;
  ImageButton slideButton;
  Text currentScoreText;
  Text highScoreText;
  Text gameOverText;
}
