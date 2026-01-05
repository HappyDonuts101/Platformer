class FThwomp extends FGameObject {

  boolean awake = false;

  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(true);
    setRotatable(false);
    setName("thwomp");
    attachImage(thwomp[0]);
  }

  void act() {
    if (awake==false) {
      wakeup();
    }
    if (awake && isTouching("player")) {
      damagePlayer();
    }
  }
  void wakeup() {
    if (abs(player.getX() - getX()) < gridsize / 2 &&   player.getY() > getY()) {

      awake = true;
      setStatic(false);       
      attachImage(thwomp[1]);
    }
  }

  void damagePlayer() {
    player.setPosition(350, 900); 
    player.setVelocity(0, 0);
  }
}
