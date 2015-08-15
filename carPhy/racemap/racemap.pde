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

void setup() {
	size(500, 500);
	mapstart();
	//frameRate(5);
}

void draw() {
	mapdraw();
}

void mapdraw(){
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

void mapstart(){
	for(int i=0;i<2;i++){
		maplist.add(mapadd());
	}
}

Point mapadd(){
	int rx=0,ry=0;
	rx = int(random(1+mapstatus*2, 2+mapstatus*2));
	if(int(random(10))%10>=(9-mapstatus)){
		ry=lasty+int(random(-4-mapstatus*1, 4+mapstatus*1));
	}else {
		if(!path){
			ry=lasty+int(random(-4-mapstatus, 0));
		}
		else if (path){
			ry=lasty+int(random(0, 4+mapstatus));
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
