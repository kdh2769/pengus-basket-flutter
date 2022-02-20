import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:pengus_basket/pengus.dart';
import 'package:pengus_basket/options.dart';

class Fish extends SpriteComponent with  HasHitboxes, Collidable {
  Fish() : super() {}
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Pengus) {
      removeFromParent();
      SCORE--;
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
}