boolean keyPress[] = new boolean[256];
void keyreset(){
  for(int i=0;i<256;i++)keyPress[i]=false;
}
void keyPressed(){
  pqa(keyCode);
    if(IPtext.state)
  IPtext.s+=char(keyCode+32);
  else if(nametext.state)
  nametext.s+=char(keyCode+32);
  else
  NEWtext.s+=char(keyCode+32);
  keyPress[keyCode] = true;
  if(keyPress[ENTER]){
      if(IPtext.state);
      else if(nametext.state);
      else
        NEWtext.end();
  }
//  else if(keyPress[BACKSPACE]){
//      if(IPtext.state){
//        if(IPtext.s.equals(""))
//        IPtext.s=IPtext.s.substring(0,IPtext.s.length()-2);
//      }
//      else if(nametext.state){
//        if(nametext.s.equals(""))
//        nametext.s=nametext.s.substring(0,nametext.s.length()-2);
//      }
//      else
//      if(NEWtext.s.equals(""))
//        NEWtext.s=NEWtext.s.substring(0,NEWtext.s.length()-2);
//  }
  
  boolean ok = false;
  if(keyCode == 'l'-32) ok=f.login("192.168.43.16",7480,tbs.get(1).text+(int)random(20));
  println(ok);
  
}
void keyReleased(){
  keyPress[keyCode] = false;
}
//192.168.43.67
