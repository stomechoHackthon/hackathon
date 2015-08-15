int[] pressQuene = new int[10];
int pqs=0;
int pqe=0;
boolean over;
boolean gotover;
void pqi(){
  for(int i=0;i<10;i++)pressQuene[i]=-1;
}

void pqa(int x){
  if('a'-32<=x&&x<='z'-32){
    pressQuene[pqs]=x+32;
    pqe=(pqe+1)%10;
  }
}

int pqo(){
  int out=pressQuene[pqs];
  if(out!=-1){
    pressQuene[pqs]=-1;
    pqs=(pqs+1)%10;
  }
  return out;
}

ArrayList<textbox> tbs = new ArrayList<textbox>();

class textbox{
  int x;int y;
  int w;int h;
  String name;
  String text="";
  boolean over = false;
  boolean focus = false;
  textbox(String name,int x,int y,int w,int h){
    this.name = name;
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h;
  }
  void check(){
    if(!gotover&&x<mouseX&&mouseX<x+w&&y<mouseY&&mouseY<y+h) {over = true;gotover = true;}
    else over = false;
    if(over&&mousePressed){
      for(int i=0;i<tbs.size();i++) tbs.get(i).focus = false;
      focus = true;
    }
  }
  void type(int x){
    if(focus) text+=char(x);
  }
  void draw(){
    noFill();stroke(255);strokeWeight(1);
    rect(x,y,w,h);
    fill(255);
    text(name+" "+text+((gt%20<10)?"|":" "),x+5,y+15);
  }
}

void check(){
  gotover = false;
  for(int i=0;i<tbs.size();i++) tbs.get(i).check();
}

void type(){
  int in = pqo();
  while(in!=-1){
    for(int i=0;i<tbs.size();i++) tbs.get(i).type(in);
    in = pqo();
  }
}

void drawTB(){
  for(int i=0;i<tbs.size();i++) tbs.get(i).draw();
}
