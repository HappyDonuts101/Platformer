class FreezeSwitch extends FGameObject {
  
  FreezeSwitch(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(true);
    setSensor(true);
    setName("freezeswitch");
    attachImage(freezeSwitch);
  }

  void act() {
    if (isTouching("player") && ekey == true) {
      if (freeze == false) { 
        freeze = true;
        freezeTime = millis() + 4000;
      }
    }
  }
}
