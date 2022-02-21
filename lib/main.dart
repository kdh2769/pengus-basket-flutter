import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pengus_basket/controller.dart';

import 'in_game.dart';

void main() {
  var game = InGame();

  runApp(
    MaterialApp(
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            GameWidget(game: game),
            Controller(game: game),
          ],
        )

      ),

    )
  );

}

