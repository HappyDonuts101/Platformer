class FBoo extends FGameObject {


  int speed = 2;

  FBoo(float x, float y) {
    super();
    setPosition(x, y);
    setName("boo");
    setStatic(true);     
    setRotatable(false);
    attachImage(boo);
  }

  void act() {
    if (freeze) return;

    
if (player.getX() < getX()) {
  attachImage(reverseImage(boo));
} else {
  attachImage(boo);
}


    if (player.direction == R && getX() > player.getX()) return;
    if (player.direction == L && getX() < player.getX()) return;

    if (player.getX() > getX()) setPosition(getX() + speed, getY());
    if (player.getX() < getX()) setPosition(getX() - speed, getY());

    if (player.getY() > getY()) setPosition(getX(), getY() + speed);
    if (player.getY() < getY()) setPosition(getX(), getY() - speed);

    if (isTouching("player")) {
      if (player.getY() < getY() - gridsize/2) {
        world.remove(this);
        enemies.remove(this);
      } else {
        loselife();
      }
    }
    
    
if(isTouching ("shell_active")) {
     world.remove(this);
     enemies.remove(this);
    }
  }
}
