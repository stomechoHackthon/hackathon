class addtext{
  int x,y;
  int len=150;
  String s="";
  int state=1;
  String name="me";
  addtext(int x,int y){
    this.x=x;
    this.y=y;
  }
  void reset(int x,int y){
    this.x=x;
    this.y=y;
    len=150;
    state=0;
    s="";
  }
  void end(){
    NEWtext.state=1;
    TEXTS.add(new Text(NEWtext.x,NEWtext.y,NEWtext.s,NEWtext.name));
    texttop++;
  }
  void draw(){
    switch(state){
      case 0:
        if((s.length()-6)*20>150)len=(s.length()-6)*20;
        fill(#909090);
        stroke(#909090);
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
  String s="";
  String ad="";
  Text(int x,int y,String s,String ad){
    this.x=x;
    this.y=y;
    this.s=s;
    this.ad=ad;
    len=(s.length()-1)*20;
    namelen=(ad.length()-1)*20;
  }
  void draw(){
    fill(#B4B4B4);
    stroke(#B4B4B4);
    strokeWeight(5);
    rect(x,y,len,26);
    rect(x-namelen-20,y,namelen,26);
    fill(255);
    text(s,x,y+23);
    text(ad+":",x-namelen-20,y+23);
  }
}
