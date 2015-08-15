import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class client extends PApplet {


int gt = 0;
ArrayList<Text> TEXTS=new ArrayList<Text>();
addtext NEWtext=new addtext(0,0);
Text IPtext=new Text(100,100,"","IP");
Text nametext=new Text(100,200,"","NAME");
int texttop=0;
public void setup(){
  noCursor();
  size(500,500);
  textSize(20);
  pqi();
  
  tbs.add(new textbox("ip",100,20,150,30));
  tbs.add(new textbox("name",100,80,150,30));
}

public void draw(){
  if(mousePressed){
    if(IPtext.touch());
    else if(nametext.touch());
    else
    NEWtext.reset(mouseX,mouseY);
  }
 
  update();
  render();
//  IPtext.draw();
//  nametext.draw();
  NEWtext.draw();
  for(int i=0;i<texttop;i++)TEXTS.get(i).draw();
  gt++;
}
boolean keyPress[] = new boolean[256];
public void keyreset(){
  for(int i=0;i<256;i++)keyPress[i]=false;
}
public void keyPressed(){
  pqa(keyCode);
    if(IPtext.state)
  IPtext.s+=PApplet.parseChar(keyCode+32);
  else if(nametext.state)
  nametext.s+=PApplet.parseChar(keyCode+32);
  else
  NEWtext.s+=PApplet.parseChar(keyCode+32);
  keyPress[keyCode] = true;
  if(keyPress[ENTER]){
      if(IPtext.state);
      else if(nametext.state);
      else
        NEWtext.end();
  }
//  else if(keyPress[BACKSPACE]){
//      if(IPtext.state){
//        if(IPtext.s.equals(""))
//        IPtext.s=IPtext.s.substring(0,IPtext.s.length()-2);
//      }
//      else if(nametext.state){
//        if(nametext.s.equals(""))
//        nametext.s=nametext.s.substring(0,nametext.s.length()-2);
//      }
//      else
//      if(NEWtext.s.equals(""))
//        NEWtext.s=NEWtext.s.substring(0,NEWtext.s.length()-2);
//  }
  
  boolean ok = false;
  if(keyCode == 'l'-32) ok=f.login("192.168.43.16",7480,tbs.get(1).text+(int)random(20));
  println(ok);
  
}
public void keyReleased(){
  keyPress[keyCode] = false;
}
//192.168.43.67
Client me;
class men{
  Client me;
  int status = 0;
  //\u72c0\u614b\u5217\u8868
  //  0 \u7121
  //  1 \u50b3\u9001\u767b\u8a18\u8cc7\u6599
  //  2 \u63a5\u6536id\u5b8c\u6210
  //  3  
  int t = 0;//\u7d00\u9304\u72c0\u614b\u958b\u59cb\u6642\u9593
  boolean serverOk = false;
  String[] data;
  final int maxWaitTime = 300;
  
  int id=0;
  String serverIp;
  String name;
  
  mouse mice = new mouse("me",0,0);
  men(String name){
    this.name = name;
  }
  public boolean login(String ip,int port,String name){
    try{
      this.name = name;
      mice.name = name;
      loginip(ip,port);
      write("start,"+name);
      newStatus(1);
      serverOk = true;
      return true;
    } catch (Exception e){
      println("ip= "+ip);
      return false;
    }
  }
  public void update(){
    mice.set(mouseX,mouseY);
    if(serverOk) {
      if(id!=0)write("p,"+id+","+mice.tx+","+mice.ty);
      getData();
    }
  }
  
  public void getData(){
    if(available() > 0){
      String inString[] = split(readString(),'|');
      for(int i=0;i<inString.length;i++){
        println(inString[i]);
        data = split(inString[i],',');
        try{
          if(data.length>1){
            if(data[0].equals("success")){
              id = parseInt(data[1]);
            }else if(data[0].equals("p")){
              if(!data[1].equals(name))mdata(data[1],parseInt(data[2]),parseInt(data[3]));
            }else if(data[0].equals("t")){
              if(!data[1].equals(name))TEXTS.add(new Text(parseInt(data[3]),parseInt(data[4]),data[2],data[1]));
            }
          }
        }catch(Exception e){
        }
      }
    }
  }
  public void sentText(String s,int x,int y){
    write("t,"+id+","+s+","+x+","+y);
  }
  
  public void newStatus(int s){
    status = s;
    t = gt;
  }
  public int dt(){
    return gt-t;
  }
}

public void loginip(String ip,int port){
  me = new Client(this,ip,port);
}
public void write(String s){
  me.write(s+"|");
}
public int available(){
  return me.available();
}
public String readString(){
  return me.readString();
}
public PApplet thisapp(){
  return this;
}
mouse[] otherm = new mouse[99];
int mouseCount=0;
class mouse{
  int tx,ty;
  int px,py;
  int x,y;
  int st,dt=2;
  int avadt = 10;
  String name="default";
  mouse(String name,int x,int y){
    tx=x;
    ty=y;
    px=x;
    py=y;
    st=gt;
    dt=10;
    this.name = name;
  }
  public void set(int x,int y){
    px=tx;
    py=ty;
    tx=x;
    ty=y;
    dt = avadt;
    st = gt;
  }
  public void draw(){
    ellipse(x(),y(),5,5);
    text(name,x()+10,y()+2);
  }
  public int x(){
    return vspeed(px,tx,st,dt,gt);
  }
  public int y(){
    return vspeed(py,ty,st,dt,gt);
  }
}

public void mdata(String name,int x,int y){
  println("new mouse");
  int i=0;
  for(i=0;i<mouseCount&&!otherm[i].name.equals(name);i++) {
    println("see "+otherm[i].name);
  }
  if(i==mouseCount) {
    println("new mouse at "+i+" call "+name);
    otherm[i] = new mouse(name,x,y);
    mouseCount++;
  }
  otherm[i].set(x,y);
}

public void drawOtherm(){
  for(int i=0;i<mouseCount;i++){
    fill(0,255,0);
    otherm[i].draw();
  }
}

int[] pressQuene = new int[10];
int pqs=0;
int pqe=0;
boolean over;
boolean gotover;
public void pqi(){
  for(int i=0;i<10;i++)pressQuene[i]=-1;
}

public void pqa(int x){
  if('a'-32<=x&&x<='z'-32){
    pressQuene[pqs]=x+32;
    pqe=(pqe+1)%10;
  }
}

public int pqo(){
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
  public void check(){
    if(!gotover&&x<mouseX&&mouseX<x+w&&y<mouseY&&mouseY<y+h) {over = true;gotover = true;}
    else over = false;
    if(over&&mousePressed){
      for(int i=0;i<tbs.size();i++) tbs.get(i).focus = false;
      focus = true;
    }
  }
  public void type(int x){
    if(focus) text+=PApplet.parseChar(x);
  }
  public void draw(){
    noFill();stroke(255);strokeWeight(1);
    rect(x,y,w,h);
    fill(255);
    text(name+" "+text+((gt%20<10)?"|":" "),x+5,y+15);
  }
}

public void check(){
  gotover = false;
  for(int i=0;i<tbs.size();i++) tbs.get(i).check();
}

public void type(){
  int in = pqo();
  while(in!=-1){
    for(int i=0;i<tbs.size();i++) tbs.get(i).type(in);
    in = pqo();
  }
}

public void drawTB(){
  for(int i=0;i<tbs.size();i++) tbs.get(i).draw();
}
class addtext{
  int x,y;
  int len=150;
  String s="";
  int state=1;
  String name="me";
  int count=0;
  addtext(int x,int y){
    this.x=x;
    this.y=y;
  }
  public void reset(int x,int y){
    if(count==0)
     reset2(x,y);
     count++;
  }
  public void reset2(int x,int y){
    this.x=x;
    this.y=y;
    len=150;
    state=0;
    s="";
  }
  public void end(){
    NEWtext.state=1;
    TEXTS.add(new Text(NEWtext.x,NEWtext.y,NEWtext.s,f.name));
    f.sentText(NEWtext.s,NEWtext.x,NEWtext.y);
    texttop++;
    count=0;
  }
  public void draw(){
    switch(state){
      case 0:
        if((s.length()-6)*20>150)len=(s.length()-6)*20;
        fill(0xff909090);
        stroke(0xff909090);
        strokeWeight(5);
        rect(x,y,len,26);
        fill(255);
        text(s,x,y+23);
      break;
      case 1:
        
      break;
    }
  }
}
class Text{
  int x,y;
  int len=150,namelen=0;
  boolean state=false;
  String s=" ";
  String ad="";
  Text(int x,int y,String s,String ad){
    this.x=x;
    this.y=y;
    this.s=s;
    this.ad=ad;
    namelen=(ad.length()-1)*20;
  }
  public void draw(){
    if((s.length()-6)*20>150)len=(s.length()-6)*20;
    fill(0xffB4B4B4);
    stroke(0xffB4B4B4);
    strokeWeight(5);
    rect(x,y,len,26);
    rect(x-namelen-20,y,namelen,26);
    fill(255);
    text(s,x,y+23);
    text(ad+":",x-namelen-20,y+23);
  }
  public boolean touch(){
    if(mouseX>=x&&mouseX<=x+len&&mouseY>=Y&&mouseY<=y+26){
      state=true;
    return true;
    }
    else{
      state=false;
    return false;
    }
  }
}
men f = new men("hans");

public void update(){
  f.update();
  check();
  type();
  
}

public void render(){
  background(0);
  stroke(0); fill(255);
  f.mice.draw();
  drawOtherm();
  drawTB();
}
public int vspeed(int p,int t,int st,int dt,float time){
  return p+(int)(vspeed((float)(time-st)/dt)*(t-p));
}

public float vspeed(float t){
  if(t<=0.5f) return 2*t*t;
  else return 4*t-2*t*t-1;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "client" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
