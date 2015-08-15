import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class server extends PApplet {


Server mainserver;

class Player{
 	int id;
 	String name;
 	int x=0;
 	int y=0;
}

int[] id={1,2,3};
String[] value={"start","p","t"};

String[] input;
String[] temp;
String[] queue;
Player[] playerlist=new Player[99];
int playernum=0;
int tid=1;
int tbash=1;
Player tplayer;
boolean start=false;


public void setup() {
	size(512, 512);
	mainserver = new Server(this, 7480); 
	bash("server is start in "+Server.ip());
	println("server is start in "+Server.ip());
	start=false;
}

public void draw() {
 	listen(); 
 	if(start){
 		send();
 	}
}

public void listen(){
	Client thisClient = mainserver.available();
  	if (thisClient !=null) {
    	String whatClientSaid = thisClient.readString();
    		try{
	    		if (whatClientSaid != null) {
	    			queue=split(whatClientSaid, '|');
	    			for(int i=0;i<queue.length;i++){
	    				if(queue[i]!=""){
	    					temp=split(queue[i], ',');
				      		int event=convert(temp[0]);
				      		switch (event) {
				      			case 1 :
				      				tplayer=new Player();
				      				tplayer.id=tid++;
				      				tplayer.name=temp[1];
				      				playerlist[playernum]=tplayer;
				      				playernum++;
				      				bash("Player "+tplayer.name+" Add");
				      				println("Player "+tplayer.name+" Add");
				      				thisClient.write("success,"+tplayer.id);
				      				start=true;
			  					println("ok!");
				      			break;	
				      			case 2 :
				      				tplayer=who(PApplet.parseInt(temp[1]));
								tplayer.x=PApplet.parseInt(temp[2]);
								tplayer.y=PApplet.parseInt(temp[3]);
								bash("Player "+tplayer.name+" move to ("+tplayer.x+","+tplayer.y+")");
								println("Player "+tplayer.name+" move to ("+tplayer.x+","+tplayer.y+")");
				      			break;
				      			case 3 :
				      				tplayer=who(PApplet.parseInt(temp[1]));
				      				input[input.length]=tplayer.id+","+temp[2];
				      				bash("Player "+tplayer.name+" text "+temp[2]);
				      				println("Player "+tplayer.name+" text "+temp[2]);
				      				mainserver.write("t,"+tplayer.id+","+temp[2]+","+temp[3]+","+temp[4]+"|");
				      			break;		
				      		}
	    				}	
	    			}
	    				
	    		} 
    		}catch (Exception e) {}
  	}
}

public void send(){
	String tempstr="";
	for(int i=0;i<playernum;i++){
		tempstr+="p,"+playerlist[i].name+","+playerlist[i].x+","+playerlist[i].y;
		tempstr+="|";
	}
	mainserver.write(tempstr);
	println(tempstr);
}

public void  bash(String t){
	textSize(16);
	fill(0, 0, 0);
	text(t, 10, 10+16*tbash);
	tbash++;
}

public Player who(int temp){
	Player wplayer=new Player();
	for(int i=0;i<playernum;i++){
		if(playerlist[i].id==temp){
			wplayer=playerlist[i];
		}
	}
	return wplayer;
}

public int convert(String tp){
	int re=0;
	for(int i=0;i<id.length;i++){
		if(tp.equals(value[i])){
			re=id[i];
		}
	}
	println(re);
	return re;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "server" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
