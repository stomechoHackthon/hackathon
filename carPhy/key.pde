boolean[] keyPress = new boolean[256];
void keyPressed(){
  keyPress[keyCode] = true;
}

void keyReleased(){
  keyPress[keyCode] = false;
  switch(keyCode){
    case 'c'-32: c.cons.clear();break;
    case 'l'-32: c.cons.clear(); c.ws.clear(); c.addw(new v2(20,20),50,20); break;
    case 'q'-32: c.addw(new v2(mouseX,mouseY),50,20); break;
    case 'e'-32: export();break;
    case 'i'-32: imp();break;
    case 'v'-32: view = !view;break;
    case 49: mapstatus=1;lasty=330;break;
    case 50: mapstatus=2;lasty=330;break;
    case 51: mapstatus=3;lasty=330;break;
    case 52: mapstatus=4;lasty=330;break;  
    case 53: mapstatus=5;lasty=330;break;  
    case 54: mapstatus=0;dx=50;break;  
  }
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

void export(){
  String s[] = new String[c.ws.size()+c.cons.size()];
  int line=0;
  for(int i=0;i<c.ws.size();i++){
    s[line]="w,"+c.ws.get(i).pos.x+","+c.ws.get(i).pos.y+","+c.ws.get(i).r+","+c.ws.get(i).m;
    line++;
  }
  for(int i=0;i<c.cons.size();i++){
    s[line]="c,"+c.cons.get(i).a+","+c.cons.get(i).b+","+c.cons.get(i).l+","+c.cons.get(i).k;
    line++;
  }
  saveStrings("data/save/car.txt",s);
}

void imp(){
  c.cons.clear(); c.ws.clear();
  String s[] = loadStrings("save/car.txt");
  for(int i=0;i<s.length;i++){
    String line[] = split(s[i],',');
    if(line[0].charAt(0)=='w') c.addw(new v2(parseFloat(line[1]),parseFloat(line[2])),parseFloat(line[3]),parseFloat(line[4]));
    else c.addc(parseInt(line[1]),parseInt(line[2]),parseFloat(line[3]),parseFloat(line[4]));
  }
}
