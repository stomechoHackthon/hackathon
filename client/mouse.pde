mouse[] otherm = new mouse[99];
int mouseCount=0;
class mouse{
  int tx,ty;
  int px,py;
  int x,y;
  int st,dt=10;
  int avadt = 10;
  String name="default";
  mouse(String name,int x,int y){
    tx=x;
    ty=y;
    px=x;
    py=y;
    st=gt;
    dt=10;
  }
  void set(int x,int y){
    px=tx;
    py=ty;
    tx=x;
    ty=y;
    avadt += (gt-st-avadt)*0.01;
    dt = avadt;
    st = gt;
  }
  void draw(){
    ellipse(x(),y(),5,5);
    text(name,x()+10,y()+2);
  }
  int x(){
    return vspeed(px,tx,st,dt,gt);
  }
  int y(){
    return vspeed(py,ty,st,dt,gt);
  }
}

void mdata(String name,int x,int y){
  int i=0;
  for(i=0;i<mouseCount;i++) if(otherm[i].name==name)break;
  if(i==mouseCount) {
    otherm[i] = new mouse(name,x,y);
    mouseCount++;
  }
  otherm[i].set(x,y);
}

void drawOtherm(){
  for(int i=0;i<mouseCount;i++){
    fill(0,255,0);
    otherm[i].draw();
  }
}
