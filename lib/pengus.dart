import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:pengus_basket/fish.dart';
import 'package:pengus_basket/options.dart';
import 'package:pengus_basket/gulls.dart';

class Pengus extends SpriteComponent with HasHitboxes, Collidable {
  Pengus() : super(){
    final shape = HitboxRectangle(relation: Vector2.all(0.6));
    addHitbox(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other){
    super.onCollision(intersectionPoints, other);
    if (other is Gulls){
      HIT_GULL = true;
      LIFE--;
    }
    else if(other is Fish){
      EAT_FISH = true;
      SCORE++;
    }
  }
  /*
  @override
  void render(Canvas canvas){
    super.render(canvas);
    renderHitboxes(canvas);
  }
   */ // hitbox render
}