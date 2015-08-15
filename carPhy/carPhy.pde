car c = new car();
boolean stop = false;
void setup() {
  size(1000, 600);
  c.addw(new v2(100,100),50,10);
   c.addw(new v2(100,100),80,3);
   c.addw(new v2(100,100),80,3);
   c.addw(new v2(100,100),10,3);
   c.addw(new v2(100,100),10,3);
    c.addc(1,2,150,0.999);
    c.addc(1,3,150,0.999);
    c.addc(1,2,150,0.999);
}

int dragfrom = -1;
int dragto = -1;
void mousePressed(){
  dragfrom = -1;
  for(int i=0;i<c.ws.size();i++) if(lenOf(sub(new v2(mouseX,mouseY),c.ws.get(i).pos))<c.ws.get(i).r){ dragfrom = i;stop = true;break;}
}
void mouseReleased(){
  dragto = -1;
  if(dragfrom!=-1){
    for(int i=0;i<c.ws.size();i++) if(lenOf(sub(new v2(mouseX,mouseY),c.ws.get(i).pos))<c.ws.get(i).r){ dragto = i;break;}
    if(dragto!=-1){
      c.addc(dragfrom,dragto,lenOf(sub(c.ws.get(dragfrom).pos,c.ws.get(dragto).pos)),0.9);
    }else{
      c.addw(new v2(mouseX,mouseY),30,20);
      c.addc(dragfrom,c.ws.size()-1,lenOf(sub(c.ws.get(dragfrom).pos,c.ws.get(c.ws.size()-1).pos)),0.9);
    }
  }
  stop = false;
}


void draw() {
  background(0);
  c.run();
  c.draw();
}

