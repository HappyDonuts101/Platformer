class FShell extends FGameObject {

  int direction = 0; 
  int speed = 350;


  FShell(float x, float y) {
    
    

    super();
    setPosition(x, y);
    setStatic(false);
    setName("shell");  
    setRotatable(false);
    attachImage(shells);
  }

  void act() {
    
    if (freeze) {
  setVelocity(0, 0);
  return;
}
    setVelocity(direction * speed, getVelocityY());
    collide();
  }

  void collide() {
    
    
    

    if (direction != 0 && isTouching("wall") || isTouching("shell")) {
      direction *= -1;
      setPosition(getX() + direction, getY());
    }

   
    if (isTouching("player")) {

  if (player.getY() < getY() - gridsize/2) {
    direction = 0;
    setName("shell");
    player.setVelocity(player.getVelocityX(), -300);
    return;
  }

  if (direction != 0) {
    loselife();
    return;
  }

if (player.getX() < getX()) {
  direction = R;
} else {
  direction = L;
}
  setName("shell_active");
  setPosition(getX() + direction * 10, getY());
}

  }
}
