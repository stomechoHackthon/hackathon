class car{
  ArrayList<p2> ws= new ArrayList<p2>();
  ArrayList<condata> cons = new ArrayList<condata>();
  car(){
  }
  
  void run(){
    if(!stop){
      if(keyPress[LEFT]){
        for(int i=0;i<ws.size();i++){
          ws.get(i).w+=0.001;
        }
      }
      if(keyPress[RIGHT]){
        for(int i=0;i<ws.size();i++){
          ws.get(i).w-=0.001;
        }
      }
      for(int i=0;i<ws.size()-1;i++){
        for(int j=i+1;j<ws.size();j++){
          ws.get(i).col(ws.get(j));
        }
      }
      
      for(int i=0;i<cons.size();i++){
        ws.get(cons.get(i).a).con(ws.get(cons.get(i).b),cons.get(i).l,cons.get(i).k);
      }
      for(int i=0;i<ws.size();i++){
        ws.get(i).colm();
        ws.get(i).col(new l2(new v2(0,0),new v2(0,600)));
        ws.get(i).col(new l2(new v2(0,600),new v2(1000,600)));
        ws.get(i).col(new l2(new v2(1000,600),new v2(1000,0)));
      }
      
      for(int i=0;i<ws.size();i++){
        ws.get(i).run();
      }
    }
  }
  void draw(){
    stroke(255);
    for(int i=0;i<ws.size();i++){
      ellipse(ws.get(i).pos.x,ws.get(i).pos.y,ws.get(i).r,ws.get(i).r);
    }
    for(int i=0;i<cons.size();i++){
      line(ws.get(cons.get(i).a).pos.x,ws.get(cons.get(i).a).pos.y,ws.get(cons.get(i).b).pos.x,ws.get(cons.get(i).b).pos.y);
    }
  }
  void addw(v2 pos,float r,float m){
    ws.add(new p2(pos,r,m));
  }
  void addc(int a,int b,float l,float k){
    cons.add(new condata(a,b,l,k));
  }
}


class condata{
  int a;
  int b;
  float l;
  float k;
  condata(int a,int b,float l,float k){
    this.a=a;
    this.b=b;
    this.l=l;
    this.k=k;
  }
}
