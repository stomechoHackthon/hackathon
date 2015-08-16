class Point{
  int x;
  int y;
  int kind;
}

ArrayList<Point> maplist=new ArrayList<Point>();
int drawpoint=0;
int mapstatus=3;
int lasty=330;
int hy=550;
int ly=300;
int dx = 10;
boolean path = true;




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
    //println(tx+","+tpoint.y);
    i++;
    maplist.add(mapadd());
  }

  drawpoint=drawpoint+1;
}
void mapstart(){
  for(int i=0;i<20;i++){
    maplist.add(mapadd());
  }
}

Point mapadd(){
  int rx=0,ry=0;
  rx = int(random(1+mapstatus*2, 2+mapstatus*2))*dx;
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
  
  if(lasty+10*mapstatus>(hy+(10*mapstatus))){
    path=false;
  }else if ((lasty-10*mapstatus)<(ly-(mapstatus*2))) {
    path=true;
  }
  
  lasty=ry;
  Point rpoint=new Point();
  rpoint.x=rx;
  rpoint.y=ry;
  return rpoint;
}
