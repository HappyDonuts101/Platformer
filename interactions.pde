void keyPressed() {
  if (key == 'a') akey = true;
  if (key == 'd') dkey = true;
  if (key == 's') skey = true;
  if (key == 'w') wkey = true;
   if (key == 'p' || key == 'P') {
    if (mode == GAME) mode = PAUSE;
    else if (mode == PAUSE) mode = GAME;
  }
}

void keyReleased() {
  if (key == 'a') akey = false;
  if (key == 'd') dkey = false;
  if (key == 's') skey = false;
  if (key == 'w') wkey = false;
}













PImage reverseImage(PImage image) {
  PImage reverse = createImage(image.width, image.height, ARGB);
  image.loadPixels();
  reverse.loadPixels();

  for (int i = 0; i < image.width; i++) {
    for (int j = 0; j < image.height; j++) {
      int src = j * image.width + i;
      int dst = j * image.width + (image.width - 1 - i);
      reverse.pixels[dst] = image.pixels[src];
    }
  }

  reverse.updatePixels();
  return reverse;
}
