boolean[] keyPress = new boolean[256];
void keyPressed(){
  keyPress[keyCode] = true;
}

void keyReleased(){
  keyPress[keyCode] = false;
}
