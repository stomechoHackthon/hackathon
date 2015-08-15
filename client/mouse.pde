class mouse{
  int tx,ty;
  int px,py;
  int x,y;
  int st,dt=10;
  int avadt = 10;
  String name;
  mouse(int x,int y){
    tx=x;
    ty=y;
    px=x;
    py=y;
    st=gt;
    dt=10;
  }
  void set(int x,int y){
    px=this.x;
    py=this.y;
    tx=x;
    ty=y;
    avadt += (gt-st-avadt)*0.01;
    dt = avadt;
    st = gt;
  }
  
  int x(){
    return vspeed(px,tx,st,dt,gt);
  }
  int y(){
    return vspeed(py,ty,st,dt,gt);
  }
}
