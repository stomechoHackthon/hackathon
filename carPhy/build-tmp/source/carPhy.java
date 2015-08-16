import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class carPhy extends PApplet {

car c = new car();
boolean stop = false;
int gt = 0;
int subt = 1;
int csize = 20;
float nkk = 1;
boolean view = false;
logger logs[] = new logger[1];

public void setup() {
  size(1000, 600);
  mapstart();
  c.addw(new v2(100,100),50,50);
  
  logs[0] = new logger(20, 100, 150, 80, "game FPS", 30);
}

int dragfrom = -1;
int dragto = -1;
public void mousePressed(){
  if(mouseButton == RIGHT){
    stop = !stop;
  }else{
    dragfrom = -1;
    for(int i=0;i<c.ws.size();i++) if(lenOf(sub(new v2(mouseX,mouseY),c.ws.get(i).pos))<c.ws.get(i).r*0.5f){ dragfrom = i;break;}
  }
}

int pmillis = 0;
public void mouseReleased(){
  dragto = -1;
  if(dragfrom!=-1){
    for(int i=0;i<c.ws.size();i++) if(lenOf(sub(new v2(mouseX,mouseY),c.ws.get(i).pos))<c.ws.get(i).r*0.5f){ dragto = i;break;}
    if(dragto!=-1){
      c.addc(dragfrom,dragto,lenOf(sub(c.ws.get(dragfrom).pos,c.ws.get(dragto).pos)),nkk);
    }else{
      c.addw(new v2(mouseX,mouseY),csize,csize);
      c.addc(dragfrom,c.ws.size()-1,lenOf(sub(c.ws.get(dragfrom).pos,c.ws.get(c.ws.size()-1).pos)),nkk);
    }
  }
  dragfrom = -1;
  dragto = -1;
  pmillis = millis();
}


public void draw() {
  logs[0].addlog(1000f/(millis()-pmillis));
  
  pmillis= millis();
  background(0);
  fill(255);
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
  if(view)for(logger l : logs) l.draw();
}

class car{
  ArrayList<p2> ws= new ArrayList<p2>();
  ArrayList<condata> cons = new ArrayList<condata>();
  car(){
  }
  
  public void run(){
    if(!stop){
      if(keyPress[LEFT]){
        for(int i=0;i<ws.size();i++){
          ws.get(i).w+=0.001f;
        }
      }
      if(keyPress[RIGHT]){
        for(int i=0;i<ws.size();i++){
          ws.get(i).w-=0.001f;
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
  public void draw(){
    stroke(255);
    for(int i=0;i<ws.size();i++){
      ellipse(ws.get(i).pos.x,ws.get(i).pos.y,ws.get(i).r,ws.get(i).r);
    }
    for(int i=0;i<cons.size();i++){
      try{
      strokeWeight(5*cons.get(i).k);
      line(ws.get(cons.get(i).a).pos.x,ws.get(cons.get(i).a).pos.y,ws.get(cons.get(i).b).pos.x,ws.get(cons.get(i).b).pos.y);
      }catch(Exception e){
      }
    }
    strokeWeight(1);
  }
  public void addw(v2 pos,float r,float m){
    ws.add(new p2(pos,r,m));
  }
  public void addc(int a,int b,float l,float k){
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
boolean[] keyPress = new boolean[256];
public void keyPressed(){
  keyPress[keyCode] = true;
}

public void keyReleased(){
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

public void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(keyPress[CONTROL]){
    e*=0.1f;
    if(0<nkk+e&&nkk+e<=1)nkk+=e;
    println(nkk);
  }else{
    e*=3;
    if(0<csize+e&&csize+e<100)csize+=e;
  }
}

public void export(){
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

public void imp(){
  c.cons.clear(); c.ws.clear();
  String s[] = loadStrings("save/car.txt");
  for(int i=0;i<s.length;i++){
    String line[] = split(s[i],',');
    if(line[0].charAt(0)=='w') c.addw(new v2(parseFloat(line[1]),parseFloat(line[2])),parseFloat(line[3]),parseFloat(line[4]));
    else c.addc(parseInt(line[1]),parseInt(line[2]),parseFloat(line[3]),parseFloat(line[4]));
  }
}
class logger{
  int x,y,w,h;
  String name;
  float data[];
  int inPoint;
  float multi = 1;
  float ava = 0;
  float max = 0;
  float great;
  boolean press=false;
  boolean pressOn=false;
  int mpx=0;
  int mpy=0;
  logger(int x,int y,int w,int h,String name){
    this.x=x; this.y=y; this.w=w; this.h=h;
    this.name = name;
    data = new float[w];
    for(float f : data) f = 0;
    inPoint = 0;
    great=-1;
  }
  logger(int x,int y,int w,int h,String name,float great){
    this.x=x; this.y=y; this.w=w; this.h=h;
    this.name = name;
    data = new float[w];
    for(float f : data) f = 0;
    inPoint = 0;
    this.great = great;
  }
  public void addlog(float d){
    
    ava=(ava*w+d)/(w+1);
    max += (ava-max) *0.001f;
    if(max>ava*10)max+= (ava-max) *0.1f;
    if(d>max) max = d;
    if(max*multi<h*0.5f && multi<64 )multi*=2;
    else if(max*multi>h)multi*=0.5f;
    
    data[inPoint] = d;
    inPoint = (inPoint+w-1)%w;
  }
  public void draw(){
    if(mousePressed){
      if(press){
        if(pressOn){
          x=mouseX-mpx;
          y=mouseY-mpy;
          for(logger l : logs){
            if(abs(x-l.x)<15) {x=l.x; stroke(0,255,0,64); strokeWeight(1); line(x,y,x,l.y);}
            if(abs(y-l.y)<15) {y=l.y; stroke(0,255,0,64); strokeWeight(1); line(x,y,l.x,y);}
          }
        }
      }else{
        if(x<mouseX&&mouseX<x+w&&y-h<mouseY&&mouseY<y){
          mpx = mouseX-x; mpy = mouseY-y;
          pressOn = true;
        }
      }
      press = true;
    }else{
      pressOn = false;
      press = false;
    }
    
    
    
    
    fill(255,64);stroke(0xff12E3FC,128);strokeWeight(1);
    if(pressOn) fill(255,128);
    rect(x,y,w,-h);
    fill(255); strokeWeight(1);
    text(name+" "+nf(multi,1,2)+"X\nvalue= "+nf(data[(inPoint+1)%w],2,2),x,y+16);
    fill(255,0,0); text(nf(max,1,1),x+w+5,y-max*multi+5);
    fill(0,255,0); text(nf(ava,1,1),x+w+5,y-ava*multi+5);
    
    for(int i=0;i<w;i++){
      float f = data[(inPoint+1+i)%w] ;
      if(abs(f-great)<max*0.1f) stroke(0xff5AF03A,192);
      else if(f<=ava) stroke(0xff12E3FC,192);
      else if(f>max) stroke(0xffFF4231,192);
      else stroke(0xffFFB031,192);
      line(x+i,y,x+i,y-f* multi);
    }
    
    stroke(256,128);strokeWeight(4);
    line(x,y-ava*multi,x+w,y-ava*multi);
    line(x,y-max*multi,x+w,y-max*multi);
    
    if(great!=-1){
      stroke(255,128);strokeWeight(max*0.1f*multi);
      line(x,y-great*multi,x+w,y-great*multi);
    }
    stroke(0,255,0,128);strokeWeight(2);
    line(x,y-ava*multi,x+w,y-ava*multi);
    
    stroke(255,0,0,192); strokeWeight(2);
    line(x,y-max*multi,x+w,y-max*multi);
  }
}
class Point{
  int x;
  int y;
  int kind;
}

ArrayList<Point> maplist=new ArrayList<Point>();
int drawpoint=0;
int mapstatus=3;
int lasty=330;
int hy=500;
int ly=300;
int dx = 2;
boolean path = true;




public void mapdraw(){
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
public void genMap(){
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
public void mapstart(){
  for(int i=0;i<10;i++){
    maplist.add(mapadd());
  }
}

public Point mapadd(){
  //println(mapstatus);
  int rx=0,ry=0;
  rx = PApplet.parseInt(random(1+mapstatus*2, 2+mapstatus*2))*dx;
  if(PApplet.parseInt(random(10))%10>=(9-mapstatus)){
    ry=lasty+PApplet.parseInt(random(-4-mapstatus*1, 4+mapstatus*1));
  }else {
    if(!path){
      ry=lasty+PApplet.parseInt(random(-4-mapstatus, 0));
    }
    else if (path){
      ry=lasty+PApplet.parseInt(random(0, 4+mapstatus));
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
class p2{
  v2 pos;
  v2v vel;
  v2v pvel;
  float w;
  float pw;
  float r;
  float m;
  p2(v2 pos,float r,float m){
    this.pos = pos;
    this.vel = new v2v(0,0);
    this.pvel = new v2v(0,0);
    this.r = r;
    this.m = m;
    w=0.001f;
  }
  public void run(){
    vel.setY(vel.y()+0.2f);
    pos = add(pos,vel);
    pvel = vel;
    vel = mult(vel,0.999f);
    w*=0.8f;
  }
  
  public void con(p2 p,float l,float k){
    v2v d = add( sub(p.pos, pos).toV2v(), sub(p.pvel, pvel));
    v2v f = mult(new v2v(d.angle,d.len-l),k);
    vel.set(add(vel,mult(f,p.m/(m+p.m)*0.45f)));
    p.vel.set(sub(p.vel,mult(f,m/(m+p.m)*0.45f)));
  }
  
  public void col(p2 p){
    v2v d = add( sub(p.pos, pos).toV2v(), sub(p.pvel, pvel));
    if(abs(d.len)<(r+p.r)*0.5f){
      v2v f = new v2v(d.angle,d.len-(r+p.r)*0.5f);
      v2v n = mult(new v2v(d.angle-HALF_PI,1),((w*r-p.w*p.r)*2*PI));
      f = add(f,n);
      vel.set(add(vel,mult(f,p.m/(m+p.m)*0.5f)));
      p.vel.set(sub(p.vel,mult(f,m/(m+p.m)*0.5f)));
    }
  }
  public void col(l2 p){
    v2v d = sub(pos,p.pos1).toV2v().projection(new v2v(p.toV2v().angle+HALF_PI,1).angle);
    if(-d.len<r*0.5f){
      pos.set(add(pos,new v2v(d.angle,-d.len-r*0.5f)));
      v2v f = mult(vel.projection(d.angle),-1.5f);
      v2v n = mult(new v2v(d.angle+HALF_PI,1),((w*r)*2*PI));
      f = add(f,n);
      vel = add(vel,f);
    }
  }
  
  public void colm(){
    int i=drawpoint+1;
    int sx=-gt%subt*maplist.get(maplist.size()-1).x/subt;
    while(sx<pos.x){
      sx+=maplist.get(i).x;
      i++;
    }
    i-=2;
    col(new l2(new v2(sx-maplist.get(i).x,maplist.get(i).y),new v2(sx,maplist.get(i+1).y)));
  }
}

class l2{
  v2 pos1;
  v2 pos2;
  l2(v2 pos1,v2 pos2){
    this.pos1 = pos1;
    this.pos2 = pos2;
  }
  public v2 toV2(){
    return sub(pos2,pos1);
  }
  public v2v toV2v(){
    return toV2().toV2v();
  }
}
class v2v{
  float angle;
  float len;
  v2v(float angle,float len){
    this.angle = angle;
    this.len = len;
  }
  public void setA(float angle){
    this.angle = angle;
  }
  public void setL(float len){
    this.len = len;
  }
  public void set(float angle,float len){
    this.angle=angle;
    this.len = len;
  }
  public void set(v2v p){
    this.angle=p.angle;
    this.len = p.len;
  }
  public void setX(float x){
    angle=angleOf(x,y());
    len=lenOf(x,y());
  }
  public void setY(float y){
    angle=angleOf(x(),y);
    len=lenOf(x(),y);
  }
  public void setXY(float x,float y){
    angle=angleOf(x,y);
    len=lenOf(x,y);
  }  
  public v2 toV2(){
    return new v2(x(),y());
  }
  public v2v projection(float a){
    v2v out = new v2v(a,cos(angle-a)*len);
    return out;
  }
  public float x(){
    return cos(angle)*len;
  }
  public float y(){
    return sin(angle)*len;
  }
}

class v2{
  float x;
  float y;
  v2(float x,float y){
    this.x = x;
    this.y = y;
  }
  public void setX(float x){
    this.x=x;
  }
  public void setY(float y){
    this.y=y;
  }
  public void set(float x,float y){
    this.x=x;
    this.y=y;
  }
  public void set(v2 p){
    this.x=p.x;
    this.y=p.y;
  }
  public v2v toV2v(){
    return new v2v(angleOf(x,y),lenOf(x,y));
  }
  public float len(){
    return lenOf(x,y);
  }
  public float angle(){
    return angleOf(x,y);
  }
}

public v2v add(v2v a,v2v b){
  float x = a.x()+b.x();
  float y = a.y()+b.y();
  return new v2v(angleOf(x,y),lenOf(x,y));
}

public v2v sub(v2v a,v2v b){
  float x = a.x()-b.x();
  float y = a.y()-b.y();
  return new v2v(angleOf(x,y),lenOf(x,y));
}

public v2v mult(v2v a,float f){
  return new v2v(a.angle,a.len*f);
}

public v2 mult(v2 a,float f){
  return new v2(a.x*f,a.y*f);
}

public v2 add(v2 a,v2 b){
  return new v2(a.x+b.x,a.y+b.y);
}

public v2 sub(v2 a,v2 b){
  return new v2(a.x-b.x,a.y-b.y);
}

public v2 add(v2 a,v2v b){
  return new v2(a.x+b.x(),a.y+b.y());
}

public v2 sub(v2 a,v2v b){
  return new v2(a.x-b.x(),a.y-b.y());
}

public v2v add(v2v a,v2 b){
  return add(a,b.toV2v());
}

public v2v sub(v2v a,v2 b){
  return sub(a,b.toV2v());
}

public float angleOf(float x,float y){
  if(x==0&&y==0) return 0;
  else if(x>=0&&y>=0) return atan(y/x);
  else if(x>=0) return atan(y/x)+TWO_PI;
  else return atan(y/x)+PI;
}
public float angleOf(v2 p){
  if(p.x==0&&p.y==0) return 0;
  else if(p.x>=0&&p.y>=0) return atan(p.y/p.x);
  else if(p.x>=0) return atan(p.y/p.x)+TWO_PI;
  else return atan(p.y/p.x)+PI;
}
public float lenOf(float x,float y){
  return sqrt(x*x+y*y);
}

public float lenOf(v2 p){
  return sqrt(p.x*p.x+p.y*p.y);
}

public void line(v2 a,v2 b){
  line(a.x,a.y*0.5f,b.x,b.y*0.5f);
}

public void ellipse(v2 p,float w,float h){
  ellipse(p.x,p.y*0.5f,w,h*0.5f);
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "carPhy" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
