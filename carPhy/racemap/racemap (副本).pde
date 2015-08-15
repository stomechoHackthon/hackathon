class Point{
	int x;
	int y;
	int kind;
}

ArrayList<Point> maplist=new ArrayList<Point>();
int drawpoint=0;
int mapstatus=3;
int ly=330;

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
	int rx = int(random(2+mapstatus*2, 6+mapstatus*2));
	int ry=ly+int(random(-4-mapstatus*1, 4+mapstatus*1));
	if(ly+10*mapstatus>500)
		ry=ly+int(random(-2-mapstatus, 0));
	else if ((ly-10*mapstatus)<0)
		ry=ly+int(random(0, 2+mapstatus));
	ly=ry;
	Point rpoint=new Point();
	rpoint.x=rx;
	rpoint.y=ry;
	return rpoint;
}
