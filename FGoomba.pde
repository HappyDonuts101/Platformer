
class FGoomba extends FGameObject {
  int direction = L;
  int speed = 50;
  int frame = 0;
  boolean dead = false;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(false);
    setName("goomba");
    setRotatable(false);
    attachImage(goomba[0]);
  }

  void act() {
    animate();
    move();
    collide();
  }

  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(goomba[frame]);
      frame++;
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed * direction, vy);
  }

 void collide() {

  if (isTouching("wall")) {
    direction = direction * -1;
    setPosition(getX()+direction, getY());
  }

  if (isTouching("player")) {
    if(player.getY() < getY() - gridsize/2) {    
    world.remove(this);
    enemies.remove(this);
    }  else {
loselife();      
    }
  }
  }
}
