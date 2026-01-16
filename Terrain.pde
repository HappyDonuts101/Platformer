//Ethan Song
//Mario Platformer Game

/* **/
//import gifAnimation.*;
//Gif introGif;
//Gif gameOverGif;

//import processing.sound.*;

//SoundFile jumpSound;
//SoundFile bopSound;

import fisica.*;
//Color Pallete
color white = #FFFFFF;
color black = #000000;
color cyan  = #00FFFF;
color treeTrunkBrown = #FF9500;
color red   = #FF0000;
color westgreen  = #009F00;
color eastgreen = #006F00;
color intersectgreen  = #003F00;
color purple = #C08497;
color pink   = #FFC8DD;
color yellow = #ffb703;
color grey = #1b263b;
color fire = #d00000;
color lavac = #ff6a00;
color dblue = #023e8a;
color beige = #fdf0d5;
color dgreen = #283618;
color dpink = #dd2d4a;
color maroon = #780000;
color center = #bc6c25;
color edge = #dda15e;
color coins = #d90429;
color booo = #283618;
color kTroopa = #fb5607;
color portalRed  = #FF00FF;
color portalBlue = #00FFAA;
color saveC = #00FF00;   

ArrayList<FSavePoint> savepoints = new ArrayList<FSavePoint>();

float respawnX = 3800;  
float respawnY = 2200;



float btnX;
float btnY;
int btnH = 60;
int btnW=200;

PFont marioFont;

int lives = 3;
boolean gameOver = false;


PImage map, ice, stone, treeTrunk, treetop_center;
PImage treetop_w, treetop_e, treetop_intersect, eric, lemon, agoost, dirtN;
PImage spike, bridgeImg, trampoline, hammer, shells, coin, boo, koopaTroopa, bportal, rportal, saveOff, saveOn;

PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;
PImage[] lava;
PImage[] thwomp;
PImage[] hammerbro;

String[] maps = {"mlm.png", "level2.png"};
int level = 0;

ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;
ArrayList<FPortal> portals = new ArrayList<FPortal>();

int gridsize = 32;
float zoom = 1.5;

boolean akey, dkey, skey, wkey, upkey, leftkey, rightkey, downkey;

FPlayer player;
FWorld world;

final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
final int WIN = 4;

int mode ;

void setup() {
  size(1200, 800);
  Fisica.init(this);
  //  introGif = new Gif(this, "mari.gif");
  //  introGif.loop();
  //  gameOverGif = new Gif(this, "mario.gif");
  //  gameOverGif.loop();
  //jumpSound = new SoundFile(this, "jump.mp3");
  //bopSound  = new SoundFile(this, "bop.mp3");

  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();

  loadImages();
  map = loadImage("mlm.png");

  marioFont = loadFont("FranklinGothic-Heavy-48.vlw");
  textFont(marioFont);

  loadWorld(map);
  loadPlayer();

  world.setGravity(0, 800);
}

void draw() {

  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    background(dblue);
    drawWorld();
    actWorld();
  } else if (mode == PAUSE) {
    background(white);
    drawWorld();
    pause();
  } else if (mode == GAMEOVER) {
    gameover();
  } else if (mode == WIN) {
    gamewin();
  }
}

void intro() {
  //image(introGif, 0,0, width, height);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(100);
  fill(red);
  text("Super Mario", width/2, height/2);

  btnX = width/2 - btnW/2;
  btnY = height/2 + 300;

  fill(100);
  rect(btnX, btnY, btnW, btnH);

  fill(255);
  textSize(24);
  text("START", width/2, 730);
}

void gamewin() {
  background(0);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(60);
  text("YOU WIN", width/2, height/2);
  fill(100);
  btnX = width/2 - btnW/2;
  btnY = height/2 + 200;

  fill(100);
  rect(btnX, btnY, btnW, btnH);

  fill(255);
  textSize(24);
  text("PLAY AGAIN", width/2, btnY + btnH/2);
}

void gameover() {
  background(0);

  //image(gameOverGif, 0, 0, width, height);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(60);
  text("YOU DIED!", width/2, height/2);

  btnX = width/2 - btnW/2;
  btnY = height/2 + 200;
  fill(100);
  rect(btnX, btnY, btnW, btnH);
  fill(255);
  textSize(24);
  text("RESTART", width/2, btnY + btnH/2);
}


void pause() {
  fill(0, 150);
  rect(0, 0, width, height);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(60);
  text("PAUSED!", width/2, height/2);

  textSize(20);
  text("Press P to resume", width/2, height/2 + 60);
}

void mousePressed() {
  if (mode == INTRO) {
    if (mouseX > btnX && mouseX < btnX + btnW && mouseY > btnY && mouseY < btnY + btnH) {
      mode = GAME;
    }
  } else if (mode == GAMEOVER) {
    level = 0;
    map = loadImage(maps[level]);
    if (mouseX > btnX && mouseX < btnX + btnW && mouseY > btnY && mouseY < btnY + btnH) {
      resetGame();
      mode = GAME;
    }
  } else if (mode == WIN) {
    level = 0;
    map = loadImage(maps[level]);
    if (mouseX > btnX && mouseX < btnX + btnW && mouseY > btnY && mouseY < btnY + btnH) {
      resetGame();
      mode = GAME;
    }
  }
}

void resetGame() {

  lives = 3;
  enemies.clear();
  terrain.clear();

  world = new FWorld(-20000, -20000, 20000, 20000);

  loadWorld(map);
  loadPlayer();

  player.setRotatable(false);
  world.setGravity(0, 800);
}


void actWorld() {
  player.act();

  if (player.isTouching("coin")) {
    level();
  }

  for (int i = enemies.size() - 1; i >= 0; i--) {
    FGameObject e = enemies.get(i);
    e.act();

    if (e instanceof FGoomba) {
      FGoomba g = (FGoomba) e;
      if (g.dead) {
        world.remove(g);
        enemies.remove(i);
      }
    }
  }

  for (int i = 0; i < terrain.size(); i++) {
    FGameObject t = terrain.get(i);
    t.act();
  }
}
void loselife() {
  lives--;
  if (lives <= 0) {
    mode = GAMEOVER;
  } else {
    player.setPosition(respawnX, respawnY);
    player.setVelocity(0, 0);
  }
}


void loadImages() {
  savepoints.clear();



  stone = loadImage("brick.png");
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  treetop_w = loadImage("treetop_w.png");
  treetop_e = loadImage("treetop_e.png");
  treetop_center = loadImage("treetop_center.png");
  treetop_intersect = loadImage("tree_intersect.png");
  spike = loadImage("spike.png");
  bridgeImg = loadImage("bridge_center.png");
  dirtN = loadImage("dirt_n.png");
  trampoline = loadImage("trampoline.png");
  hammer = loadImage("hammer.png");
  shells = loadImage("greenshell.png");
  coin = loadImage("coin.png");
  boo = loadImage("boom.png");
  koopaTroopa = loadImage("koopa.png");
  bportal  = loadImage("bportal.png");
  bportal.resize(gridsize, gridsize);
  
  rportal=loadImage("rportal.png");
  rportal.resize(gridsize,gridsize);
  
  koopaTroopa.resize(gridsize, gridsize);
  
  boo.resize(gridsize, gridsize);
  saveOff = loadImage("ssq.png");
saveOn  = loadImage("ssq.png");
saveOff.resize(gridsize, gridsize);
saveOn.resize(gridsize, gridsize);


  coin.resize(gridsize, gridsize);

  shells.resize(gridsize, gridsize);

  hammer.resize(gridsize, gridsize);

  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");

  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");

  lava = new PImage[3];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");

  lava[0].resize(gridsize, gridsize);
  lava[1].resize(gridsize, gridsize);
  lava[2].resize(gridsize, gridsize);

  run = new PImage[3];
  run[0] = loadImage("runright0.png");
  run[1] = loadImage("runright1.png");
  run[2] = loadImage("runright2.png");

  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[1] = loadImage("goomba1.png");



  goomba[0].resize(gridsize, gridsize);
  goomba[1].resize(gridsize, gridsize);

  thwomp = new PImage[2];
  thwomp[0] = loadImage("thwomp0.png");
  thwomp[1] = loadImage("thwomp1.png");



  thwomp[0].resize(gridsize*2, gridsize*2);
  thwomp[1].resize(gridsize*2, gridsize*2);

  hammerbro = new PImage[2];
  hammerbro[0] = loadImage("hammerbro0.png");
  hammerbro[1] = loadImage("hammerbro1.png");

  hammerbro[0].resize(gridsize, gridsize);
  hammerbro[1].resize(gridsize, gridsize);

  stone.resize(gridsize, gridsize);
  ice.resize(gridsize, gridsize);
  treeTrunk.resize(gridsize, gridsize);
  treetop_w.resize(gridsize, gridsize);
  treetop_e.resize(gridsize, gridsize);
  treetop_center.resize(gridsize, gridsize);
  treetop_intersect.resize(gridsize, gridsize);
  spike.resize(gridsize, gridsize);
  bridgeImg.resize(gridsize, gridsize);
  dirtN.resize(gridsize, gridsize);
  trampoline.resize(gridsize, gridsize);

  action = idle;
}

void loadWorld(PImage img) {
  world = new FWorld(-20000, -20000, 20000, 20000);

  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {

      color c = img.get(x, y);

      if (c == black) {
        FBox w = new FBox(gridsize, gridsize);
        w.setPosition(x*gridsize, y*gridsize);
        w.attachImage(stone);
        w.setStatic(true);
        w.setName("stone");
        w.setFriction(0.8);

        world.add(w);
      } else if (c==dpink) {
        FBox j = new FBox(gridsize, gridsize);
        j.setPosition(x*gridsize, y*gridsize);
        j.attachImage(stone);
        j.setStatic(true);
        j.setName("wall");
        j.setFriction(0.8);

        world.add(j);
      } else if (c == cyan) {
        FBox i = new FBox(gridsize, gridsize);
        i.setPosition(x*gridsize, y*gridsize);
        i.attachImage(ice);
        i.setStatic(true);
        i.setName("ice");
        i.setFriction(0.1);
        world.add(i);
      } else if (c == treeTrunkBrown) {
        FBox ni = new FBox(gridsize, gridsize);
        ni.setPosition(x*gridsize, y*gridsize);
        ni.attachImage(treeTrunk);
        ni.setStatic(true);
        ni.setName("treetrunk");
        world.add(ni);
      } else if (c == westgreen) {
        FBox si = new FBox(gridsize, gridsize);
        si.setPosition(x*gridsize, y*gridsize);
        si.attachImage(treetop_w);
        si.setStatic(true);
        si.setName("treetopw");
        world.add(si);
      } else if (c == eastgreen) {
        FBox di = new FBox(gridsize, gridsize);
        di.setPosition(x*gridsize, y*gridsize);
        di.attachImage(treetop_e);
        di.setStatic(true);
        di.setName("treetope");
        world.add(di);
      } else if (c == intersectgreen) {
        FBox pi = new FBox(gridsize, gridsize);

        pi.setPosition(x*gridsize, y*gridsize);
        pi.attachImage(treetop_intersect);
        pi.setStatic(true);
        pi.setName("treetopintersect");
        world.add(pi);
      } else if (c == purple) {
        FBox s = new FBox(gridsize, gridsize);
        s.setPosition(x * gridsize, y * gridsize);
        s.attachImage(spike);
        s.setStatic(true);
        s.setName("spike");
        world.add(s);
      } else if (c == pink) {
        FBridge br = new FBridge(x * gridsize, y * gridsize);
        world.add(br);

        terrain.add(br);
      } else if (c == yellow) {
        FBox d = new FBox(gridsize, gridsize);
        d.setPosition(x*gridsize, y*gridsize);
        d.attachImage(dirtN);
        d.setStatic(true);
        d.setName("dirt");
        world.add(d);
      } else if (c == grey) {
        FGoomba gmb = new FGoomba(x*gridsize, y*gridsize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == fire) {
        FBox t = new FBox(gridsize, gridsize);
        t.setPosition(x*gridsize, y*gridsize);
        t.attachImage(trampoline);
        t.setStatic(true);
        t.setName("trampoline");
        t.setRestitution(1.5);
        world.add(t);
      } else if (c == lavac) {
        FLava lv = new FLava(x*gridsize, y*gridsize);
        lv.setName("lava");
        world.add(lv);
        terrain.add(lv);
      } else if (c == center) {
        FThwomp th = new FThwomp(x * gridsize, y * gridsize);
        enemies.add(th);
        world.add(th);
      } else if (c==beige) {
        FHammerBro hb = new FHammerBro(x * gridsize, y * gridsize);
        enemies.add(hb);
        world.add(hb);
      } else if (c==maroon) {
        FShell sh = new FShell (x*gridsize, y*gridsize);
        enemies.add(sh);
        world.add(sh);
      } else if (c==edge) {
      } else if (c==coins) {
        FBox coo = new FBox(gridsize, gridsize);
        coo.setPosition(x*gridsize, y*gridsize);
        coo.attachImage(coin);
        coo.setStatic(true);
        coo.setSensor(true);
        coo.setName("coin");
        world.add(coo);
      }
      
      else if(c==booo) {
        FBoo bo = new FBoo(x*gridsize, y*gridsize);
        enemies.add(bo);
        world.add(bo);
        
      }
      else if(c==kTroopa) {
       FkoopaTroopa to = new FkoopaTroopa(x*gridsize, y*gridsize); 
       enemies.add(to);
       world.add(to);
      }
      
      else if (c == portalRed) {
  FPortal p = new FPortal(x*gridsize, y*gridsize, 0);
  portals.add(p);
  terrain.add(p);  
  world.add(p);
}
else if (c == portalBlue) {
  FPortal p = new FPortal(x*gridsize, y*gridsize, 1);
  portals.add(p);
  terrain.add(p);  
  world.add(p);
} else if (c == saveC) {
  FSavePoint sp = new FSavePoint(x*gridsize, y*gridsize);
  savepoints.add(sp);
  terrain.add(sp);     
  world.add(sp);
}



    }
  }
  
  linkPortals();

}
void drawWorld() {
  pushMatrix();
  translate(-player.getX()*zoom + width/2, -player.getY()*zoom + height/2);
  scale(zoom);

  world.step();
  world.draw();
  popMatrix();
}

void loadPlayer() {
  player = new FPlayer();
  world.add(player);
}

void linkPortals() {
  for (int i = 0; i < portals.size(); i++) {
    portals.get(i).target = portals.get((i + 1) % portals.size());
  }
}


void level() {




  level = level + 1;

  if (level < maps.length) {
    world.clear();


    enemies.clear();
    terrain.clear();

    map = loadImage(maps[level]);
    loadWorld(map);
    loadPlayer();

    world.setGravity(0, 800);
    player.setVelocity(0, 0);
    player.setRotatable(false);
  } else {
    mode = WIN;
  }
}

class FPortal extends FGameObject {
  int group;
  FPortal target;

  FPortal(float x, float y, int groupId) {
    super();
    setPosition(x, y);
    setStatic(true);
    setSensor(true);
    setName("portal");
    group = groupId;

    if (group == 0) attachImage(rportal);
    else attachImage(bportal);
  }

  void act() {
    if (target != null && isTouching("player")) {
      player.setPosition(target.getX(), target.getY()-200);
      player.setVelocity(0, 0);
    }
  }
}




class FHammerBro extends FGameObject {

  int direction = R;
  int speed = 40;

  int timer = 0;
  int delay = 120;
  int frame;

  FBox hammers;


  FHammerBro(float x, float y) {
    super();
    setPosition(x, y);
    setName("hammerbro");
    setRotatable(false);
    attachImage(hammerbro[0]);
    setStatic(false);
  }
  void act() {
    walk();
    turn();
    throwHammer();
    damagePlayer();
    Reset();
    
    
    if (isTouching("shell_active")) {
  world.remove(this);
  enemies.remove(this);
  return;
}

  }
  void walk() {
    setVelocity(speed * direction, getVelocityY());
  }

  void turn() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX() + direction, getY());
    }

    if (direction==R) {
      attachImage(hammerbro[0]);
    }

    if (direction == L) {
      attachImage(reverseImage(hammerbro[0]));
    }
  }

  void throwHammer() {
    timer++;

    if (timer >= delay) {
      timer = 0;

      hammers = new FBox(gridsize/2, gridsize/2);
      hammers.setPosition(getX(), getY()-gridsize/2);
      hammers .setName("hammer");
      hammers .setSensor(true);
      hammers .attachImage(hammer);
      hammers.setVelocity(250*direction, -350);
      hammers.setAngularVelocity(10 * direction);


      world.add(hammers);
    }
  }

  void Reset() {


    if (isTouching("player")) {
      if (player.getY() < getY() - gridsize/2) {


        world.remove(this);
        enemies.remove(this);
      } else {
        loselife();
      }
    }
  }

  void damagePlayer() {
    if (player.isTouching("hammer")) {
      player.setPosition(350, 900);
      world.remove(hammers);
    }
  }
}


class FBridge extends FGameObject {

  FBridge(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(true);
    setName("bridge");
    attachImage(bridgeImg);
  }

  void act() {
    if (isTouching("player") && player.getY() < getY() - gridsize/2) {
       setStatic(false);
      setSensor(true);
    }
  }
}

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


class FGameObject extends FBox



{
  final int L = -1;
  final int R = 1;
  FGameObject()


  {
    super(gridsize, gridsize);
  }
  boolean isTouching(String name) {
    ArrayList<FContact> contacts = getContacts();
    for (int i = 0; i < contacts.size(); i++) {
      FContact fc = contacts.get(i);
      if (fc.contains(name)) return true;
    }
    return false;
  }
  void act() {
  }

  FGameObject(float w, float h) {
    super(w, h);
  }
}
class FGoomba extends FGameObject {
  int direction = L;
  int speed = 50;
  int frame = 0;
  boolean dead = false;

  FGoomba(float x, float y) {
    super();
    setPosition(x, y);
    setStatic(false);
    setName("goomba");
    setRotatable(false);
    attachImage(goomba[0]);
  }

  void act() {
    animate();
    move();
    collide();
  }

  void animate() {
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0) {
      attachImage(goomba[frame]);
      frame++;
    }
  }

  void move() {
    float vy = getVelocityY();
    setVelocity(speed * direction, vy);
  }

  void collide() {
    
if (isTouching("shell_active")) {
  world.remove(this);
  enemies.remove(this);
  return;
}


  if (isTouching("wall") || isTouching("hammer") || isTouching("hammerbro") || isTouching("shell") || isTouching("koopatroopa") ) {
  direction *= -1;
  setPosition(getX() + direction, getY());
}



    if (isTouching("player")) {
      if (player.getY() < getY() - gridsize/2) {
        world.remove(this);
        enemies.remove(this);
      } else {
        loselife();
      }
     
    }
    
    //if(isTouching ("shell")) {
    // world.remove(this);
    // enemies.remove(this);
    //}
  }
}




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
    move();
    collide();
  }

  void move() {
    setVelocity(speed * direction, getVelocityY());
  }

 void collide() {

  if (isTouching("shell_active")) {
    world.remove(this);
    enemies.remove(this);
    return;
  }

  if (isTouching("wall") || isTouching("shell") || isTouching("hammerbro") || isTouching("goomba")) {
    direction *= -1;
    setPosition(getX() + direction, getY());
  }

  if (isTouching("player")) {
    if (player.getY() < getY() - gridsize/2) {

      FShell shell = new FShell(getX(), getY());
      world.add(shell);
      enemies.add(shell);

      world.remove(this);
      enemies.remove(this);

      player.setVelocity(player.getVelocityX(), -300);
    } else {
      loselife();
    }
  }
}

}






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
    setVelocity(direction * speed, getVelocityY());
    collide();
  }

  void collide() {

  if (direction != 0 && isTouching("wall")) {
  direction *= -1;
  setPosition(getX() + direction, getY());
}


    if (isTouching("player")) {
      if (player.getY() < getY() - gridsize/2) {
        direction = 0;
        setName("shell");
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        if (direction == 0) {
          direction = (player.getX() < getX()) ? R : L;
          setName("shell_active"); 
          setPosition(getX() + direction * 5, getY());
        } else {
          loselife();
        }
      }
    }
  }
}




class FBoo extends FGameObject {

  int speed = 2;

  FBoo(float x, float y) {
    super();
    setPosition(x, y);
    setName("boo");
    setStatic(true);     
    setRotatable(false);
    attachImage(boo);
  }

  void act() {

    if (player.direction == R && getX() > player.getX()) return;
    if (player.direction == L && getX() < player.getX()) return;

    if (player.getX() > getX()) setPosition(getX() + speed, getY());
    if (player.getX() < getX()) setPosition(getX() - speed, getY());

    if (player.getY() > getY()) setPosition(getX(), getY() + speed);
    if (player.getY() < getY()) setPosition(getX(), getY() - speed);

    if (isTouching("player")) {
      if (player.getY() < getY() - gridsize/2) {
        world.remove(this);
        enemies.remove(this);
      } else {
        loselife();
      }
    }
    
    
if(isTouching ("shell_active")) {
     world.remove(this);
     enemies.remove(this);
    }
  }
}


 
  


class FThwomp extends FGameObject {
  boolean awake = false;
  boolean rising = false;
  float startY;


  FThwomp(float x, float y) {
    super(gridsize*2, gridsize*2);
    setPosition(x, y);
    setStatic(true);
    startY = y;
    setRotatable(false);
    setDamping(3);
    setName("thwomp");
    attachImage(thwomp[0]);
  }

  void act() {
    if (awake==false) {
      wakeup();
    } else {
      if (getVelocityY()==0) {
        rise();
      }
    }

    if (awake && isTouching("player")) {
      damagePlayer();
    }
  }
  void wakeup () {
    if (abs(player.getX()-getX())< 46 && player.getY() > getY()) {
      awake = true;
      setStatic(false);
      attachImage(thwomp[1]);
    }
  }
  void rise() {
    setStatic(true);
    if (getY() > startY) {

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
