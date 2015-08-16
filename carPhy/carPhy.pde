car c = new car();
boolean stop = false;
int gt = 0;
int subt = 3;
int csize = 20;
float nkk = 1;

void setup() {
  size(1000, 600);
  mapstart();
  
  c.addw(new v2(100,100),50,10);
}

int dragfrom = -1;
int dragto = -1;
void mousePressed(){
  if(mouseButton == RIGHT){
    stop = !stop;
  }else{
    dragfrom = -1;
    for(int i=0;i<c.ws.size();i++) if(lenOf(sub(new v2(mouseX,mouseY),c.ws.get(i).pos))<c.ws.get(i).r*0.5){ dragfrom = i;break;}
  }
}
void mouseReleased(){
  dragto = -1;
  if(dragfrom!=-1){
    for(int i=0;i<c.ws.size();i++) if(lenOf(sub(new v2(mouseX,mouseY),c.ws.get(i).pos))<c.ws.get(i).r*0.5){ dragto = i;break;}
    if(dragto!=-1){
      c.addc(dragfrom,dragto,lenOf(sub(c.ws.get(dragfrom).pos,c.ws.get(dragto).pos)),nkk);
    }else{
      c.addw(new v2(mouseX,mouseY),csize,20);
      c.addc(dragfrom,c.ws.size()-1,lenOf(sub(c.ws.get(dragfrom).pos,c.ws.get(c.ws.size()-1).pos)),nkk);
    }
  }
  dragfrom = -1;
  dragto = -1;
}


void draw() {
  
  background(0);
  if(!stop&&gt%subt==0)genMap();
  mapdraw();
  c.run();
  c.draw();
   if(dragfrom!=-1){
     strokeWeight(nkk*5);
     line(c.ws.get(dragfrom).pos.x,c.ws.get(dragfrom).pos.y,mouseX,mouseY);
     noFill();
     strokeWeight(1);
     ellipse(mouseX,mouseY,csize,csize);
     fill(255);
   }
  if(!stop)gt++;
}

