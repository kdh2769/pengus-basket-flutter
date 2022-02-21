import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'in_game.dart';

class Controller extends StatelessWidget{
  const Controller ({
    Key? key,
    required this.game,
  }) : super(key: key);

  final InGame game;
  static const double iconSize = 200;

  @override
  Widget build(BuildContext context){
    return Container(
        alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: (){
                game.direction = 'left';
              },
              icon: Icon(Icons.arrow_left_rounded),
              color: Colors.black26,
              iconSize: iconSize,

          ),
          IconButton(
              onPressed: (){
                game.direction = 'right';
              },
              icon: Icon(Icons.arrow_right_rounded),
              color: Colors.black26,
              iconSize: iconSize,

          ),
          Opacity(opacity: 0.3),
        ],
      )
    );
  }

}