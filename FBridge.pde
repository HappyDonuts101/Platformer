class FBridge extends FGameObject {
 FBridge(float x, float y) {
  super();
  setPosition(x,y);
  setStatic(true);
  setName("bridge");
  attachImage(bridgeImg);
 }
  
  void act() {
   if(isTouching("player")) {
    setStatic(false);
    setSensor(true);
     
   }
    
  }
  
}
