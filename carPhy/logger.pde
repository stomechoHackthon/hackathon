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
  void addlog(float d){
    
    ava=(ava*w+d)/(w+1);
    max += (ava-max) *0.001;
    if(max>ava*10)max+= (ava-max) *0.1;
    if(d>max) max = d;
    if(max*multi<h*0.5 && multi<64 )multi*=2;
    else if(max*multi>h)multi*=0.5;
    
    data[inPoint] = d;
    inPoint = (inPoint+w-1)%w;
  }
  void draw(){
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
    
    
    
    
    fill(255,64);stroke(#12E3FC,128);strokeWeight(1);
    if(pressOn) fill(255,128);
    rect(x,y,w,-h);
    fill(255); strokeWeight(1);
    text(name+" "+nf(multi,1,2)+"X\nvalue= "+nf(data[(inPoint+1)%w],2,2),x,y+16);
    fill(255,0,0); text(nf(max,1,1),x+w+5,y-max*multi+5);
    fill(0,255,0); text(nf(ava,1,1),x+w+5,y-ava*multi+5);
    
    for(int i=0;i<w;i++){
      float f = data[(inPoint+1+i)%w] ;
      if(abs(f-great)<max*0.1) stroke(#5AF03A,192);
      else if(f<=ava) stroke(#12E3FC,192);
      else if(f>max) stroke(#FF4231,192);
      else stroke(#FFB031,192);
      line(x+i,y,x+i,y-f* multi);
    }
    
    stroke(256,128);strokeWeight(4);
    line(x,y-ava*multi,x+w,y-ava*multi);
    line(x,y-max*multi,x+w,y-max*multi);
    
    if(great!=-1){
      stroke(255,128);strokeWeight(max*0.1*multi);
      line(x,y-great*multi,x+w,y-great*multi);
    }
    stroke(0,255,0,128);strokeWeight(2);
    line(x,y-ava*multi,x+w,y-ava*multi);
    
    stroke(255,0,0,192); strokeWeight(2);
    line(x,y-max*multi,x+w,y-max*multi);
  }
}
