import processing.net.*;
Server mainserver;

class Player{
 	int id;
 	String name;
 	int x=0;
 	int y=0;
}

int[] id={1,2,3};
String[] value={"start","p","t"};

ArrayList<String> input=new ArrayList<String>();
String[] temp;
String[] queue;
Player[] playerlist=new Player[99];
int playernum=0;
int tid=1;
int tbash=1;
Player tplayer;
boolean start=false;


void setup() {
	size(512, 512);
	mainserver = new Server(this, 7480); 
	println("server is start in "+Server.ip());
	start=false;
	fill(255);
	rect(10, 10, 490, 460);
	rect(10, 480, 490, 28);
	bash("server is start in "+Server.ip());
	frameRate(20);
}

void draw() {
	listen(); 
	if(start){
		send();
	}
}

void listen(){
	Client thisClient = mainserver.available();
  	if (thisClient !=null) {
	    	String whatClientSaid = thisClient.readString();
		try{
			if (whatClientSaid != null) {
				queue=split(whatClientSaid, '|');
				for(int i=0;i<queue.length;i++){
					if(queue[i]!=""){
						engine(queue[i],thisClient);
					}	
				}
					
			} 
		}catch (Exception e) {}
  	}
}

void engine(String a,Client thisClient){
	//println(a);
	temp=split(a, ',');
	int event=convert(temp[0]);
	//println(event);
	switch (event) {
		case 1 :
			tplayer=new Player();
			tplayer.id=tid;
			tid++;
			tplayer.name=temp[1];
			playerlist[playernum]=tplayer;
			playernum++;
			bash("Player "+tplayer.name+" Add");
			//println("Player "+tplayer.name+" Add");
			thisClient.write("success,"+tplayer.id);
			start=true;
			println("ok!");
		break;	
		case 2 :
			tplayer=who(int(temp[1]));
			tplayer.x=int(temp[2]);
			tplayer.y=int(temp[3]);
			//bash("Player "+tplayer.name+" move to ("+tplayer.x+","+tplayer.y+")");
			//println("Player "+tplayer.name+" move to ("+tplayer.x+","+tplayer.y+")");
		break;
		case 3 :
			tplayer=who(int(temp[1]));
			String yo=temp[2];
			yo=yo.substring(0,yo.length()-1);
			input.add(tplayer.id+","+yo);
			bash("Player "+tplayer.name+" text "+yo);
			println("Player "+tplayer.name+" text "+yo);
			mainserver.write("t,"+tplayer.id+","+yo+","+temp[3]+","+temp[4]+"|");
		break;		
	}
}

void send(){
	String tempstr="";
	for(int i=0;i<playernum;i++){
		tempstr+="p,"+playerlist[i].name+","+playerlist[i].x+","+playerlist[i].y;
		tempstr+="|";
	}
	mainserver.write(tempstr);
	//println(tempstr);
}

void  bash(String t){
	if(tbash>26){
		fill(255);
		rect(10, 10, 490, 460);
		tbash=1;
	}
	textSize(16);
	fill(0, 0, 0);
	text(t, 14, 10+16*tbash);
	tbash++;
}

Player who(int temp){
	Player wplayer=new Player();
	for(int i=0;i<playernum;i++){
		if(playerlist[i].id==temp){
			wplayer=playerlist[i];
		}
	}
	return wplayer;
}

int convert(String tp){
	int re=0;
	for(int i=0;i<id.length;i++){
		if(tp.equals(value[i])){
			re=id[i];
		}
	}
	println(re);
	return re;
}
