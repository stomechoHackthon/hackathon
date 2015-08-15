import processing.net.*;
int gt = 0;
ArrayList<Text> as=new ArrayList<Text>();
int texttop=0;
void setup(){
  size(1000,1000);
  textSize(20);
}
void draw(){
  if(mousePressed){
    as.add(new Text(mouseX,mouseY,"saas","sds"));
    texttop++;
  }
  for(int i=0;i<texttop;i++)as.get(i).draw();
  gt++;
}
