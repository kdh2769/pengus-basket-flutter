import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:pengus_basket/fish.dart';
import 'package:pengus_basket/gulls.dart';
import 'package:pengus_basket/pengus.dart';
import 'package:pengus_basket/options.dart';
import 'dart:async';

class InGame extends FlameGame with  HasCollidables{
  SpriteComponent background = SpriteComponent();
  SpriteComponent bad = SpriteComponent();
  SpriteComponent good = SpriteComponent();
  Gulls gulls = Gulls();
  Fish fish = Fish();
  Pengus pengus = Pengus();

  String direction = 'default';

  List<String> fishList = ['fish1.png', 'fish2.png','fish3.png','fish4.png','fish5.png','fish6.png' ];
  List<String> gullList = ['gull1.png', 'gull2.png'];

  @override
  Future<void> onLoad() async{
    super.onLoad();
    // background 생성
    add(
      background
      ..sprite = await loadSprite('background.png')
      ..size = size
    );

    // pengus 생성
    pengus
      ..sprite = await loadSprite('penguin.png')
      ..size = Vector2(PENGUS_W, PENGUS_H)
      ..position = Vector2(size[0]/2 - PENGUS_W/2, size[1]- PENGUS_H);
    add(pengus);


    // gull 생성
    int gullIndex = Random().nextInt(gullList.length);
    Random randomGull_x = Random();
    gulls
      ..sprite = await loadSprite(gullList[gullIndex])
      ..size = Vector2(FISH_W, FISH_H)
      ..position = Vector2(randomGull_x.nextDouble() * size[0], 0);
    add(gulls);

    // fish 생성
    int fishIndex = Random().nextInt(fishList.length);
    Random randomFish_x = Random();
    fish
      ..sprite = await loadSprite(fishList[fishIndex])
      ..size = Vector2(50, 50)
      ..position = Vector2(randomFish_x.nextDouble() * size[0], 0);
    add(fish);

    // effect 생성
    good
      ..sprite = await loadSprite('good.png')
      ..size = Vector2(EFFECT_SIZE, EFFECT_SIZE)
      ..position = Vector2(size[0]/2 - EFFECT_SIZE /2, size[1]/2- EFFECT_SIZE /2)
      ..setOpacity(0.5);

    bad
      ..sprite = await loadSprite('bad.png')
      ..size = Vector2(EFFECT_SIZE, EFFECT_SIZE)
      ..position = Vector2(size[0]/2 - EFFECT_SIZE /2, size[1]/2- EFFECT_SIZE /2)
      ..setOpacity(0.5);
  }

  @override
  void update(double dt){
    super.update(dt);
    //
    if (HIT_GULL){
      add(bad);
      Future.delayed(Duration(seconds: 1),(){
        remove(bad);
        HIT_GULL = false;
      });
    }

    if (EAT_FISH){
      add(good);

      Future.delayed(Duration(seconds: 1),(){
        remove(good);
        EAT_FISH = false;
      });
    }

    // sprite 경계
    gulls.position.clamp(Vector2.zero(), size - gulls.size);
    fish.position.clamp(Vector2.zero(), size - fish.size);
    pengus.position.clamp(Vector2.zero(), size - pengus.size);

    double gullSpeed = 450;
    gulls.position += Vector2(0, 1) * gullSpeed * dt;

    double fishSpeed = 250;
    fish.position += Vector2(0, 1) * fishSpeed * dt;

    // pengus 움직이기
    double pengusSpeed = 200;
    switch (direction){
      case 'right':
        pengus.position += Vector2(1, 0) * pengusSpeed * dt;
        break;
      case 'left':
        pengus.position -= Vector2(1, 0) * pengusSpeed * dt;
        break;
    }
  }
}



