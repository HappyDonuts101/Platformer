class FShell extends FGameObject {

  final int still = 0;
  final int sliding = 1;
  final int DEAD = 2;
  int cooldown = 0;


  int state = still;
  int direction = R;
  int speed = 450;

 
  FShell(float x, float y) {
    super();
    setPosition(x, y);
    setName("shell");
    setStatic(true);
    setRotatable(false);
    setFriction(0.2);
    attachImage(shells);
  }

  void act() {

    if (state == DEAD) {
      enemies.remove(this);
      world.remove(this);
      return;
    }

    interaction();

    if (state == sliding) {
      move();
      bounce();
      killenemies();
    }
    
 if (cooldown > 0) cooldown= cooldown - 1 ;


  }

  void interaction() {

    

  }

  void move() {
    setVelocity(speed * direction, 0);
  }

  void bounce() {
    
  }

  void killenemies() {
    for (int i = enemies.size()-1; i >= 0; i--) {
      FGameObject e = enemies.get(i);

      if (e instanceof FGoomba && isTouching("goomba")) {
        world.remove(e);
        enemies.remove(i);
      }

      if (e instanceof FHammerBro && isTouching("hammerbro")) {
        world.remove(e);
        enemies.remove(i);
      }
    }
  }
}
