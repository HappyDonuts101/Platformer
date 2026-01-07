void keyPressed() {
  if (key == 'a') akey = true;
  if (key == 'd') dkey = true;
  if (key == 's') skey = true;
  if (key == 'w') wkey = true;
   if (key == 'p' || key == 'P') {
    if (mode == GAME) mode = PAUSE;  }
}

void keyReleased() {
  if (key == 'a') akey = false;
  if (key == 'd') dkey = false;
  if (key == 's') skey = false;
  if (key == 'w') wkey = false;
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
