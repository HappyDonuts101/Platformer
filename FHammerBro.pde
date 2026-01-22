class FHammerBro extends FGameObject {

  int direction = R;
  int speed = 40;

  int timer = 0;
  int delay = 120;
  int frame;
  int turnTimer = 0;
  
  boolean touchingBro = false;


  FBox hammers;


  FHammerBro(float x, float y) {
    super();
    setPosition(x, y);
    setName("hammerbro");
    setRotatable(false);
    attachImage(hammerbro[0]);
    setStatic(false);
  }
  void act() {
    walk();
    turn();
    throwHammer();
    damagePlayer();
    Reset();
    
    if (freeze) {
  setVelocity(0, 0);
  return;
}

    
    if (isTouching("shell_active")) {
  world.remove(this);
  enemies.remove(this);
  return;
}

  }
  void walk() {
    setVelocity(speed * direction, getVelocityY());
  }

  void turn() {
  if (isTouching("wall") || isTouching("hammerbro") || isTouching("shell") || isTouching("goomba")) {
  direction *= -1;
      setPosition(getX() + direction, getY());
    }

    if (direction==R) {
      attachImage(hammerbro[0]);
    }

    if (direction == L) {
      attachImage(reverseImage(hammerbro[0]));
    }
  }

  void throwHammer() {
    timer++;

    if (timer >= delay) {
      timer = 0;

      hammers = new FBox(gridsize/2, gridsize/2);
      hammers.setPosition(getX(), getY()-gridsize/2);
      hammers .setName("hammer");
      hammers .setSensor(true);
      hammers .attachImage(hammer);
      hammers.setVelocity(250*direction, -350);
      hammers.setAngularVelocity(10 * direction);


      world.add(hammers);
    }
  }

  void Reset() {


    if (isTouching("player")) {
      if (player.getY() < getY() - gridsize/2) {


        world.remove(this);
        enemies.remove(this);
      } else {
        loselife();
      }
    }
  }

  void damagePlayer() {
    if (player.isTouching("hammer")) {
      player.setPosition(350, 900);
      world.remove(hammers);
    }
  }
}
