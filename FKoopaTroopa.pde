class FkoopaTroopa extends FGameObject {

  int direction = L;   
  int speed = 50;

  FkoopaTroopa(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(false);
    setName("koopatroopa");
    setRotatable(false);
    attachImage(koopaTroopa);
  }

  void act() {
    if (stopIfPressed(this)) return;


    
if (direction == R) {
  attachImage(koopaTroopa);
} else {
  attachImage(reverseImage(koopaTroopa));
}
    move();
    collide();
  }

  void move() {
    setVelocity(speed * direction, getVelocityY());
  }

void collide() {

  if (isTouching("shell_active")) {
       removeEnemy(this);

    return;
  }

  if (isTouching("wall") || isTouching("shell") || isTouching("hammerbro") || isTouching("goomba")) {
    direction *= -1;
    setPosition(getX() + direction, getY());
  }

  if (isTouching("player")) {
    boolean stomp = (player.getY() < getY() - gridsize/2) && (player.getVelocityY() > 0);

    if (stomp==true) {
  

      FShell shell = new FShell(getX(), getY() - gridsize*0.45);
      shell.setVelocity(0, 0);

      world.add(shell);
      enemies.add(shell);

          removeEnemy(this);


      player.setVelocity(player.getVelocityX(), -300);
    } else {
      loselife();
    }
  }
}


}
