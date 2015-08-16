class Point{
  int x;
  int y;
  int kind;
}

ArrayList<Point> maplist=new ArrayList<Point>();
int drawpoint=0;
int lastpoint=0;
int mapstatus=5;
int lasty=330;
int hy=550;
int ly=450;
int dx = 1;
boolean path = true;
boolean ran = false;
int ryv=0;


void mapdraw(){
  int tx=-gt%subt*maplist.get(maplist.size()-1).x/subt;
  int i=drawpoint+1;
  beginShape();

  Point tpoint=maplist.get(drawpoint);
  //println(tx+","+tpoint.y);
  vertex(tx, tpoint.y);
  while (tx<width) {
    tpoint=maplist.get(i);
    tx+=tpoint.x;
    //println(tx+","+tpoint.y);
    vertex(tx, tpoint.y);
    i++;
  }
  
  vertex(1000,600);
  vertex(0, 600);
  endShape(CLOSE);
}
void genMap(){
  int tx=0;
  int i=drawpoint+1;
  Point tpoint=maplist.get(drawpoint);
  while (tx<width) {
    tpoint=maplist.get(i);
    tx+=tpoint.x;
    println(tx+","+tpoint.y);
    i++;
    maplist.add(mapadd());
  }
    lastpoint=drawpoint+i;
  drawpoint=drawpoint+1;

}
void mapstart(){
  for(int i=0;i<5;i++){
    maplist.add(mapadd());
  }
}

Point mapadd(){
  //println(mapstatus);
   int rx=0,ry=0;
  if(!ran){
    rx = int(random(8+mapstatus*2, 16+mapstatus*2))*dx;
    if(int(random(10))%10>=(9-mapstatus)){
      ry=lasty+int(random(-4-mapstatus*1, 4+mapstatus*1));
    }else {
      if(!path){
        ry=lasty+int(random(-4-mapstatus, 0));
      }
      else if (path){
        ry=lasty+int(random(0, 4+mapstatus));
      }    
    }
    
    if(lasty+8*mapstatus>(hy+(8*mapstatus))){
      path=false;
    }else if ((lasty-8*mapstatus)<(ly-(mapstatus*8))) {
      path=true;
    }
  }else {
      rx = int(random(8+mapstatus*2, 16+mapstatus*2));
      ry=lasty+int(random(-30-mapstatus*1, 30+mapstatus*1));
      if(lasty+10*mapstatus>hy)
        ry=lasty+int(random(-30-mapstatus, 0));
      else if ((lasty-10*mapstatus)<ly)
        ry=lasty+int(random(0, 30+mapstatus));
      //println("random");
  }

  ryv+=(ry-lasty)*0.2;
  ry=lasty+ryv;

  lasty=ry;
  Point rpoint=new Point();
  rpoint.x=rx;
  rpoint.y=ry;
  return rpoint;
}

void mapremove(int lo){
  int temp=maplist.size()-lo;
  for(int i=maplist.size()-1;i>=lo;i--){
    maplist.remove(i);
  }
  for(int i=0;i<temp;i++){
    maplist.add(mapadd());
  }
  ryv=0;
}
