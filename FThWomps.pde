

class FThwomp extends FGameObject {
 boolean awake = false;
 boolean rising = false;
 float startY;
 

FThwomp(float x, float y) {
  super(gridsize*2, gridsize*2);
  setPosition(x,y);
  setStatic(true);
  startY = y;
  setRotatable(false);
  setDamping(3); 
  setName("thwomp");
  attachImage(thwomp[0]);

  
}

void act() {
 if(awake==false) {
  wakeup(); 
   
 } else {
   if(getVelocityY()==0) {
    rise(); 
   }
   
 }
 
 if(awake && isTouching("player")) {
  damagePlayer(); 
 }
  
  
}
void wakeup () {
 if(abs(player.getX()-getX())< 46 && player.getY() > getY()) {
  awake = true;
  setStatic(false);
  attachImage(thwomp[1]);
   
 }
  
}
void rise() {
 setStatic(true);
 if(getY() > startY) {
   
   setPosition(getX(), getY()-1); 
 } else {
  setPosition(getX(), startY);
  awake = false; 
  rising = false;
   attachImage(thwomp[0]);
   
 }
  
}

void damagePlayer() {
  loselife();
}
}
