import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:pengus_basket/options.dart';
import 'package:pengus_basket/pengus.dart';

class Gulls extends SpriteComponent with  HasHitboxes, Collidable {
  Gulls() : super() {}

  double _gullSpeed = (Random().nextInt(200) + 100).toDouble();

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Pengus) {
      removeFromParent();
      SCORE--;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
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
  */ // hit box render

  @override
  void update(double dt){
    super.update(dt);

    this.position += Vector2(0, 1) * _gullSpeed * dt;

    if (this.position.y > SCREEN_H){
      removeFromParent();
    }
  }
}