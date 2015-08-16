boolean[] keyPress = new boolean[256];
void keyPressed(){
  keyPress[keyCode] = true;
}

void keyReleased(){
  keyPress[keyCode] = false;
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(keyPress[CONTROL]){
    e*=0.1;
    if(0<nkk+e&&nkk+e<=1)nkk+=e;
    println(nkk);
  }else{
    e*=3;
    if(0<csize+e&&csize+e<100)csize+=e;
  }
}
