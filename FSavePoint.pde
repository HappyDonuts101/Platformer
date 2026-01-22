class FSavePoint extends FGameObject {

  boolean active = false;

  FSavePoint(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(true);
    setSensor(true);    
    setName("savepoint");

    if (saveOff != null) attachImage(saveOff);
  }

  void act() {
    if (isTouching("player")) {
      activate();
    }
  }

  void activate() {

    for (int i = 0; i < savepoints.size(); i++) {
      savepoints.get(i).active = false;
      if (saveOff != null) savepoints.get(i).attachImage(saveOff);
    }

    active = true;
    if (saveOn != null) attachImage(saveOn);

    respawnX = getX();
    respawnY = getY() - gridsize;
  }
}
