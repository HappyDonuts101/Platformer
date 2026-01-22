void keyPressed() {
  if (key == 'a' || key == 'A') akey = true;
  if (key == 'd' || key == 'D') dkey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'w' || key == 'W') wkey = true;

  if (key == 'e' || key == 'E') ekey = true;   

  if (keyCode == UP) upkey = true;
  if (keyCode == DOWN) downkey = true;
  if (keyCode == LEFT) leftkey = true;
  if (keyCode == RIGHT) rightkey = true;

  if (key == 'p' || key == 'P') {
    if (mode == GAME) mode = PAUSE;
  }
}

void keyReleased() {
  if (key == 'a') akey = false;
  if (key == 'A') akey = false;

  if (key == 'd') dkey = false;
  if (key == 'D') dkey = false;

  if (key == 's') skey = false;
  if (key == 'S') skey = false;

if(key=='e' || key=='E') ekey = false;

  if (key == 'w') wkey = false;
  if (key == 'W') wkey = false;
  
   if(keyCode == UP) upkey = false;
  if(keyCode ==DOWN) downkey = false;
  if(keyCode == LEFT) leftkey=false;
  if(keyCode==RIGHT) rightkey= false;
}
PImage reverseImage(PImage image) {
  PImage reverse = createImage(image.width, image.height, ARGB);

  for (int y = 0; y < image.height; y++) {
    for (int x = 0; x < image.width; x++) {
      int oP = image.get(x, y);

      int flippedX = image.width - 1 - x;

      reverse.set(flippedX, y, oP);
    }
  }
  return reverse;
}
