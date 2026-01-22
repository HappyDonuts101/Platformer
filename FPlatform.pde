class FBridgeSwitch extends FGameObject {

  FGameObject[] bridge = new FGameObject[6];

  boolean on = false;
  boolean wasTouching = false;

  int endTime = 0;             
  int duration = 4000;

  FBridgeSwitch(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(true);
    setSensor(true);
    setRotatable(false);
    setName("bridgeswitch");
    attachImage(offSwitch);

    for (int i = 0; i < 6; i++) {
      FGameObject b = new FGameObject();
      b.setPosition(x + i * gridsize, y - 5 * gridsize);
      b.setStatic(true);
      b.setRotatable(false);
      b.setName("bridge");
      b.attachImage(bridgeImg);
      bridge[i] = b;
    }
  }

  void act() {

    boolean touching = isTouching("player");

    if (touching && !wasTouching) {
      if (on==true) {
        setOn(false);
      } else {
        setOn(true);
        endTime = millis() + duration;
      }
    }
    wasTouching = touching;

    if (on && millis() >= endTime) {
      setOn(false);
    }

    if (on) attachImage(onSwitch);
    else attachImage(offSwitch);
  }

  void setOn(boolean state) {
    on = state;

    if (on==true) {
      for (int i = 0; i < bridge.length; i++) world.add(bridge[i]);
    } else {
      for (int i = 0; i < bridge.length; i++) world.remove(bridge[i]);
    }
  }
}
