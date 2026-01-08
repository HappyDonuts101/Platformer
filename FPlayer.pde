class FPlayer extends FGameObject {

  
  
  PImage[] idleL, jumpL, runL;
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
    setPosition(250, 900);
    setName("player");
    setRotatable(false);
  }
  void act() {
    onGround = isTouching("wall") || isTouching("dirt") || isTouching("ice") || isTouching("bridge") || isTouching("stone") 
    || isTouching("treetrunk") || isTouching("treetopw") || isTouching ("treetope") || isTouching ("treetopintersect");

       

    if (onGround && abs(getVelocityY()) < 1) {
      jumps = 0;
    }

    input();
    animate();

    if (isTouching("spike") || isTouching("lava" )) {
  loselife();
    }
    
   
  }

  void input() {
    boolean moving = false;
    float vx = getVelocityX();
    float vy = getVelocityY();

    if (akey==true) {
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
        
       // jumpSound.play();
       //jumpSound.amp(0.367);
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
