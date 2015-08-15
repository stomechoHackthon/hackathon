boolean keyPress[] = new boolean[256];
void keyreset(){
  for(int i=0;i<256;i++)keyPress[i]=false;
}
void keyPressed(){
  if(IPtext.state);
  else if(nametext.state);
  else
  NEWtext.s+=char(keyCode+32);
  keyPress[keyCode] = true;
  if(keyPress[ENTER]){
    NEWtext.end();
  }
  
  boolean ok = false;
  if(keyCode == 'l'-32) ok=f.login("192.168.43.67",7480,"hans");
  println(ok);
  
}
void keyReleased(){
  keyPress[keyCode] = false;
}
//192.168.43.67
