boolean keyPress[] = new boolean[256];
void keyreset(){
  for(int i=0;i<256;i++)keyPress[i]=false;
}
void keyPressed(){
  keyPress[keyCode] = true;
  if(keyPress[ENTER]){
    NEWtext.end();
  }
  
  boolean ok = false;
  if(keyCode == 'l'-32) ok=f.login("127.0.0.1",7480,"hans");
  println(ok);
  
}
void keyReleased(){
  keyPress[keyCode] = false;
}
//192.168.43.67
