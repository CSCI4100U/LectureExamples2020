// CSCI 4100U - 12 - Game Development

import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flame/sprite.dart';

import 'package:gamedev/ui/image_button.dart';

class CreditsScreen extends ImageButton {
  Function onClose;

  bool isVisible = false;
  List<String> content = [
    'CREDITS',
    '',
    'Programming: ',
    'Randy Fortier',
    '',
    'Graphics:',
    'Zuhria Alfitra (https://www.gameart2d.com), Cethiel,', 
    'DontMind8 (https://dontmind8.blogspot.com), Freepik, ',
    'Kenney (https://www.kenney.nl), cron',
    '',
    'Sound Effects and Music:',
    'mieki256, Brandon Morris, Alexandr Zhelanov (Rise of Spirit) ',
    '(https://soundcloud.com/alexandr-zhelanov), cynicmusic (Awake!) ',
    '(http://cynicmusic.com http://pixelsphere.org)',
  ];

  CreditsScreen({this.onClose, String image, Size screenSize}) : super(
    screenSize: screenSize,
    text: '',
    textSize: 20,
    xPosRatio: 0.5,
    yPosRatio: 0.5,
    xPadding: 350,
    yPadding: 200,
    xTextOffset: -300,
    yTextOffset: -150,
    xOffset: 0,
    yOffset: 0,
    colour: Color(0xff000000),
    shadowColour: Color(0x00000000),
    image: image,
  ) {
    isVisible = false;

    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 20,
    );
    
    String allContent = "";
    for (String line in content) {
      allContent = allContent + line + "\n";
    }

    painter.text = TextSpan(
      text: allContent,
      style: textStyle,
    );

    painter.layout();
  }

  void show() {
    this.isVisible = true;
  }

  void hide() {
    this.isVisible = false;
  }

  void render(Canvas c) {
    if (this.isVisible) {
      sprite.renderRect(c, rect);
      painter.paint(c, position);
    }
  }

  void update(double t) {}

  void onTapDown() {
    this.hide();
    this.onClose();
  }
}