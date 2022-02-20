
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/geometry.dart';
import 'package:pengus_basket/options.dart';
import 'package:pengus_basket/pengus.dart';

class Gulls extends SpriteComponent with  HasHitboxes, Collidable {
  Gulls() : super() {}
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Pengus) {
      removeFromParent();
      SCORE++;
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onMount(){
    super.onMount();
    final shape = HitboxRectangle();
    addHitbox(shape);
  }
  @override
  void render(Canvas canvas){
    super.render(canvas);
    renderHitboxes(canvas);
  }
}