import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:pengus_basket/pengus.dart';
import 'package:pengus_basket/options.dart';

class Fish extends SpriteComponent with  HasHitboxes, Collidable {
  Fish() : super() {}

  double _fishSpeed = (Random().nextInt(250) + 100).toDouble();

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Pengus) {
      removeFromParent();
      FISH_COUNT--;
    }
    super.onCollision(intersectionPoints, other);
  }
  void onMount(){
    super.onMount();
    final shape = HitboxRectangle();
    addHitbox(shape);
  }
  /*
  @override
  void render(Canvas canvas){
    super.render(canvas);
    renderHitboxes(canvas);
  }
  */
  @override
  void update(double dt){
    super.update(dt);
    this.position += Vector2(0, 1) * _fishSpeed * dt;
    if (this.position.y > SCREEN_H){
      FISH_COUNT--;
      removeFromParent();
    }
  }
}