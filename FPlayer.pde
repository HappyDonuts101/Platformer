class FPlayer extends FGameObject {

  int frame;
  int direction;
  

  float jStrength = 430;
  float maxSpeed = 200;
  int maxJ = 3;
  
  int jumps = 0;
  boolean onGround = false;

  FPlayer() {
    super();
    frame = 0;
    direction = R;
    setPosition(2930, 900);
    setName("player");
    setRotatable(false);
  }





  void act() {
    onGround = isTouching("wall") || isTouching("dirt") || isTouching("ice") || isTouching("bridge") || isTouching("stone");

    if (onGround && abs(getVelocityY()) < 1) {
      jumps = 0;
    }

    input();
    animate();

    if (isTouching("spike") || isTouching("lava" )) {
      setPosition(350, 900);
      setVelocity(0, 0);
    }
  }

  void input() {
    float vy = getVelocityY();
    float vx = getVelocityX();
    boolean moving = false;

    if (akey) {
      setVelocity(-maxSpeed, vy);
      moving = true;
      direction = L;
    }

    if (dkey) {
      setVelocity(maxSpeed, vy);
      moving = true;
      direction = R;
    }

    if (wkey) {
      if (jumps < maxJ) {
        
        jumpSound.play();
       jumpSound.amp(0.6);

        setVelocity(vx , -jStrength);

        jumps++;
      }
      wkey = false;
    }



    if (abs(vy) > 0.1) action = jump;
    else if (moving==true) action = run;
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
