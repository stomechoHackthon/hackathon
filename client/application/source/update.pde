men f = new men("hans");

void update(){
  f.update();
  check();
  type();
  
}

void render(){
  background(0);
  stroke(0); fill(255);
  f.mice.draw();
  drawOtherm();
  drawTB();
}
