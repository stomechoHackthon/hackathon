import processing.net.*;

Client me;
int x=0;
int y=0;
void setup(){
  size(500,500);
  me = new Client(this,"10.10.10.122",6543);
}

void draw(){
  background(0);
  fill(255);
  meRead();
  ellipse(x,y,10,10);
}

void keyPressed(){
  meWrite('p',str(keyCode));
}
void keyReleased(){
  meWrite('l',str(keyCode));
}

void meWrite(char c,String  ... s ){
  String out = c+"";
  for(String data : s){
    out+=","+data;
  }
  out+="|";
  me.write(out);
}
void meRead(){
  if(me.available()>0){
    String youSay = me.readString();
    if(youSay != null){
      String line[] = split(youSay,'|');
      for(int i=0;i<line.length;i++){
        String data[] = split(line[i],',');
        if(data.length>1){
          try{
            switch(data[0].charAt(0)){
              case 'p':
                x=parseInt(data[1]);
                y=parseInt(data[2]);
                break;
            }
          }catch(Exception e){
            
          }
          println(data);
        }
      }
    }
  }
}
