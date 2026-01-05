import gifAnimation.*;
Gif introGif;

import processing.sound.*;

SoundFile jumpSound;
SoundFile bopSound;

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

float btnX;
float btnY;
int btnH = 60;
int btnW=200;

PFont marioFont;




PImage map, ice, stone, treeTrunk, treetop_center;
PImage treetop_w, treetop_e, treetop_intersect, eric, lemon, agoost, dirtN;
PImage spike, bridgeImg, trampoline, hammer, shells;

PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;
PImage[] goomba;
PImage[] lava;
PImage[] thwomp;
PImage[] hammerbro;

ArrayList<FGameObject> terrain;
ArrayList<FGameObject> enemies;

int gridsize = 32;
float zoom = 1.5;

boolean akey, dkey, skey, wkey;

FPlayer player;
FWorld world;

final int INTRO = 0;
final int GAME = 1; 
final int PAUSE = 2;
final int GAMEOVER = 3; 

int mode = 0;



void setup() {
  size(1200, 800);
  Fisica.init(this);
  
  introGif = new Gif(this, "mari.gif");
  introGif.loop();
  
  jumpSound = new SoundFile(this, "jump.mp3");
 bopSound  = new SoundFile(this, "bop.mp3");

  terrain = new ArrayList<FGameObject>();
  enemies = new ArrayList<FGameObject>();

  loadImages();
  map = loadImage("pod.png");
  
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
  }
}

void intro() {
image(introGif, 0,0, width, height);

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
  text("START", width/2, btnY + btnH/2);
}

void gameover() {
  background(255, 0, 0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(60);
  text("YOU DIED", width/2, height/2);
}



void pause() {
  fill(0, 150);
  rect(0, 0, width, height);

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(60);
  text("PAUSED", width/2, height/2);

  textSize(20);
  text("Press P to resume", width/2, height/2 + 60);
}

void mousePressed() {
  if (mode == INTRO) {
    if (mouseX > btnX && mouseX < btnX + btnW &&  mouseY > btnY && mouseY < btnY + btnH) {
      mode = GAME;
    }
  }
}
void actWorld() {
  player.act();

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

  //ArrayList bodies = world.getBodies();
  for (int i = 0; i < terrain.size(); i++) {
    FBody b =  terrain.get(i);
    if (b instanceof FLava) {
      ((FLava)b).act();
    }
  }
}

void loadImages() {
  stone = loadImage("brick.png"); //has a color of 
  ice = loadImage("blueBlock.png");
  treeTrunk = loadImage("tree_trunk.png");
  treetop_w = loadImage("treetop_w.png");
  treetop_e = loadImage("treetop_e.png");
  treetop_center = loadImage("treetop_center.png");
  treetop_intersect = loadImage("tree_intersect.png");
  spike = loadImage("spike.png");
  bridgeImg = loadImage("bridge_center.png");
  eric = loadImage("eric.png");
  lemon = loadImage("lemon.png");
  agoost = loadImage("agoost.png");
  dirtN = loadImage("dirt_n.png");
  trampoline = loadImage("trampoline.png");
  hammer = loadImage("hammer.png");
  shells = loadImage("greenshell.png");
  
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



  thwomp[0].resize(gridsize, gridsize);
  thwomp[1].resize(gridsize, gridsize);
  
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
  eric.resize(gridsize, gridsize);
  lemon.resize(gridsize, gridsize);
  agoost.resize(gridsize, gridsize);
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
       
      }  else if(c==dpink) {
       FBox j = new FBox(gridsize, gridsize);
       j.setPosition(x*gridsize, y*gridsize);
       j.attachImage(stone);
       j.setStatic(true);
       j.setName("wall");
       j.setFriction(0.8);
        
        world.add(j);
        
      }
      
      
      else if (c == cyan) {
        FBox i = new FBox(gridsize, gridsize);
        i.setPosition(x*gridsize, y*gridsize);
        i.attachImage(ice);
        i.setStatic(true);
        i.setName("ice");
        i.setFriction(0.1);
        world.add(i);
      } else if (c == treeTrunkBrown) {
        block(x, y, treeTrunk);
      } else if (c == westgreen) {
        block(x, y, treetop_w);
      } else if (c == eastgreen) {
        block(x, y, treetop_e);
      } else if (c == intersectgreen) {
        block(x, y, treetop_intersect);
      } else if (c == purple) {
        FBox s = new FBox(gridsize, gridsize);
        s.setPosition(x * gridsize, y * gridsize);
        s.attachImage(spike);
        s.setStatic(true);
        s.setName("spike");
        world.add(s);
      } else if (c == pink) {
        FBridge br = new FBridge(x * gridsize, y * gridsize);
        world.add(br);  FThwomp th = new FThwomp(x * gridsize, y * gridsize);
  enemies.add(th);
  world.add(th);
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
      }  else if (c == dblue) {
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
  
}


    }
  }
}

void block(int x, int y, PImage img) {
  FBox b = new FBox(gridsize, gridsize);
  b.setPosition(x * gridsize, y * gridsize);
  b.attachImage(img);
  b.setStatic(true);
  world.add(b);
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







class FHammer extends FGameObject {

  FHammer(float x, float y, float vx) {
    super();
    setPosition(x, y);
    setName("hammer");
    setSensor(true);
    attachImage(hammer);

    setVelocity(vx, -350);   
    setAngularVelocity(10);
  }

  void act() {
    if (isTouching("player")) {
      player.setPosition(350, 900);
      player.setVelocity(0, 0);
      world.remove(this);
    }

    if (getY() > 20000) {
      world.remove(this);
    }
  }
}



class FHammerBro extends FGameObject {

  int direction = R;
  int speed = 40;



  int timer = 0;
  int delay = 120;

  FHammerBro(float x, float y) {
    super();
    setPosition(x, y);
    setName("hammerbro");
    setRotatable(false);
    attachImage(hammerbro[0]);
  }

  void act() {
    walk();
    turn();
    throwHammer();
    Reset();
  }

  void walk() {
    setVelocity(speed * direction, getVelocityY());
  }

  void turn() {
    if (isTouching("wall")) {
      direction *= -1;
      setPosition(getX() + direction, getY());
    }
  }

  void throwHammer() {
    timer++;

    if (timer >= delay) {
      timer = 0;

      float vx = 250 * direction; 
    FHammer h = new FHammer(getX(), getY() - gridsize/2, vx);

    world.add(h);
    enemies.add(h); 
    }
  }

  void Reset() {
    if (isTouching("player")) {
      player.setPosition(350, 900);
      player.setVelocity(0, -300);
    }
  }
}
