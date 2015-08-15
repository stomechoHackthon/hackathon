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

public class racemap extends PApplet {

class Point{
	int x;
	int y;
	int kind;
}

ArrayList<Point> maplist=new ArrayList<Point>();
int drawpoint=0;
int mapstatus=5;
int lasty=330;
int hy=380;
int ly=280;
boolean path = true;

public void setup() {
	size(500, 500);
	mapstart();
	//frameRate(5);
}

public void draw() {
	mapdraw();
}

public void mapdraw(){
	int tx=0;
	fill(0,200,200);
	background(255);
	beginShape();

	Point tpoint=maplist.get(drawpoint);
	println(tx+","+tpoint.y);
	vertex(tx, tpoint.y);

	int i=drawpoint+1;
	while (tx<500) {
		tpoint=maplist.get(i);
  		tx+=tpoint.x;
  		println(tx+","+tpoint.y);
  		vertex(tx, tpoint.y);
  		i++;
  		maplist.add(mapadd());
	}

	drawpoint=drawpoint+1;
	vertex(500,500);
	vertex(0, 500);
	endShape(CLOSE);
	delay(100);
}

public void mapstart(){
	for(int i=0;i<2;i++){
		maplist.add(mapadd());
	}
}

public Point mapadd(){
	int rx=0,ry=0;
	rx = PApplet.parseInt(random(1+mapstatus*2, 2+mapstatus*2));
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "racemap" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
