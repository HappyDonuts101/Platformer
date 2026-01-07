class FThwomp extends FGameObject {

  boolean awake = false;
  boolean rising = false;
  float startY; 
  

  FThwomp(float x, float y) {
    super();
    setPosition(x, y);
    startY = y;
    setStatic(true);
    setRotatable(false);
    setName("thwomp");
    attachImage(thwomp[0]);
  }

  void act() {
    if (awake==false) {
      wakeup();
    } else {
     if(getVelocityY() ==0) {
      rise(); 
       
     }
    }
    
    
    
    if (awake && isTouching("player")) {
      damagePlayer();
    } 
   
  }
  void wakeup() {
    if (abs(player.getX() - getX()) < 32 &&   player.getY() > getY()) {

      awake = true;
      setStatic(false);       
      attachImage(thwomp[1]);
    }
  }

  void damagePlayer() {
    loselife();
  }
  
  
  void rise() {
    setStatic(true);
   if(getY()>startY) {
   setPosition(getX(), getY() - 2); 
    
     
   } else {    
     setPosition(getX(), startY);

     awake = false;
     rising = false; 
    attachImage(thwomp[0]); 
     
   }
    
    
  }
}
