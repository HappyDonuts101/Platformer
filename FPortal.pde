class FPortal extends FGameObject {
  int g;
  FPortal target;

  FPortal(float x, float y, int Id) {
    super();
    setPosition(x, y);
    setStatic(true);
    setSensor(true);
    setName("portal");
    g = Id;

    if (g == 0) attachImage(rportal);
    else attachImage(bportal);
  }

  void act() {
    if (target != null && isTouching("player")) {
      player.setPosition(target.getX(), target.getY()-200);
      player.setVelocity(0, 0);
    }
  }
}
