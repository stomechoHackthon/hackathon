car c = new car();
boolean stop = false;
int gt = 0;
int subt = 5;
void setup() {
  size(1000, 600);
  mapstart();
  
  c.addw(new v2(100,100),50,10);
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
  dragfrom = -1;
  dragto = -1;
  stop = false;
}


void draw() {
  
  background(0);
  if(!stop&&gt%subt==0)genMap();
  mapdraw();
  c.run();
  c.draw();
   if(dragfrom!=-1){
     line(c.ws.get(dragfrom).pos.x,c.ws.get(dragfrom).pos.y,mouseX,mouseY);
   }
  if(!stop)gt++;
}

