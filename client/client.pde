import processing.net.*;
int gt = 0;
ArrayList<Text> TEXTS=new ArrayList<Text>();
addtext NEWtext=new addtext(0,0);
Text IPtext=new Text(100,100,"","IP");
Text nametext=new Text(100,200,"","NAME");
int texttop=0;
void setup(){
  noCursor();
  size(500,500);
  textSize(20);
  pqi();
  
  tbs.add(new textbox("ip",100,20,150,30));
  tbs.add(new textbox("name",100,80,150,30));
}

void draw(){
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
