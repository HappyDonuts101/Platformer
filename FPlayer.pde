class FPlayer extends FGameObject {

  PImage[] idleL, jumpL, runL;
  int frame;
  int direction;

  float jStrength = 430;
  float speed = 200;
  int maxJ = 3;

  int jumps = 0;
  boolean onGround = false;

  float climbSpeed = 180;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(0, 2800);
    setName("player");
    setRotatable(false);
  }

  void act() {

    onGround = isTouching("wall") || isTouching("dirt") || isTouching("ice") 
    || isTouching("stone")|| isTouching("treetrunk") || isTouching("treetopw") 
    || isTouching("treetope") || isTouching("treetopintersect") || isTouching("bridge");


    if (onGround && abs(getVelocityY()) < 1) {
      jumps = 0;
    }

    input();
    animate();

    if (isTouching("spike") || isTouching("lava")) {
      loselife();
    }
  }

  void input() {
    boolean moving = false;
    float vx = getVelocityX();
    float vy = getVelocityY();

    if (akey || leftkey) {
      setVelocity(-speed, vy);
      moving = true;
      direction = L;
    }

    if (dkey || rightkey) {
      setVelocity(speed, vy);
      moving = true;
      direction = R;
    }

    if (wkey || upkey) {
      if (jumps < maxJ) {
        setVelocity(vx, -jStrength);
        jumps++;
      }
      wkey = false;
    }

    if (abs(vy) > 0.1) action = jump;
    else if (moving) action = run;
    else action = idle;
  }

  void animate() {
    if (frame >= action.length) frame = 0;

    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      else attachImage(reverseImage(action[frame]));
      frame++;
    }
  }
}
