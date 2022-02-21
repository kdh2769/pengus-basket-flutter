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

  Pengus pengus = Pengus();

  String direction = 'default';

  List<String> fishList = ['fish1.png', 'fish2.png','fish3.png','fish4.png','fish5.png','fish6.png' ];
  List<String> gullList = ['gull1.png', 'gull2.png'];

  Timer gullsSpawn = Timer(1.5, repeat: true);
  Timer fishSpawn = Timer (1.6, repeat: true);

  @override
  Future<void> onLoad() async{
    super.onLoad();

    SCREEN_W = size[0];
    SCREEN_H = size[1];
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
    gullsSpawn.onTick = () async {
      Gulls gulls = Gulls();
      int gullIndex = Random().nextInt(gullList.length);
      Random randomGull_x = Random();
      gulls
        ..sprite = await loadSprite(gullList[gullIndex])
        ..size = Vector2(FISH_W, FISH_H)
        ..position = Vector2(randomGull_x.nextDouble() * size[0] , 0);
      add(gulls);
    };
    gullsSpawn.start();

    fishSpawn.onTick = () async{
      Fish fish = Fish();
      int fishIndex = Random().nextInt(fishList.length);
      Random randomFish_x = Random();
      FISH_COUNT++;
      print('fish 생성 ${FISH_COUNT}');
      fish
        ..sprite = await loadSprite(fishList[fishIndex])
        ..size = Vector2(50, 50)
        ..position = Vector2(randomFish_x.nextDouble() * size[0] , 0);
      add(fish);
    };
    fishSpawn.start();

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

    // fish 수급
    if (FISH_COUNT <= FISH_MAX) {
      fishSpawn.update(dt);
    }

    gullsSpawn.update(dt);

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
    // gulls.position.clamp(Vector2.zero(), size - gulls.size);
    //fish.position.clamp(Vector2.zero(), size - fish.size);
    pengus.position.clamp(Vector2.zero(), size - pengus.size);

    // pengus 움직이기
    double pengusSpeed = 280;
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



