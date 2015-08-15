import processing.net.*;
int gt = 0;
ArrayList<Text> TEXTS=new ArrayList<Text>();
addtext NEWtext=new addtext(0,0);
Text IPtext=new Text(100,100);
Text nametext=new Text(100,100);
int texttop=0;
void setup(){
  noCursor();
  size(500,500);
  textSize(20);
}

void draw(){
  IPtext.touch();
  nametext.touch();
  if(mousePressed){
    if(IPtext.state);
    else if(nametext.state);
    else
    NEWtext.reset(mouseX,mouseY);
  }
  NEWtext.draw();
  for(int i=0;i<texttop;i++)TEXTS.get(i).draw();
  gt++;
  
  update();
  render();
}
