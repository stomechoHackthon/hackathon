Client me;
class men{
  Client me;
  int status = 0;
  //狀態列表
  //  0 無
  //  1 傳送登記資料
  //  2 接收id完成
  //  3  
  int t = 0;//紀錄狀態開始時間
  boolean serverOk = false;
  String[] data;
  final int maxWaitTime = 300;
  
  int id=0;
  String serverIp;
  String name;
  
  mouse mice = new mouse("me",0,0);
  men(String name){
    this.name = name;
  }
  boolean login(String ip,int port,String name){
    try{
      this.name = name;
      mice.name = name;
      loginip(ip,port);
      write("start,"+name);
      newStatus(1);
      serverOk = true;
      return true;
    } catch (Exception e){
      println("ip= "+ip);
      return false;
    }
  }
  void update(){
    mice.set(mouseX,mouseY);
    if(serverOk) {
      if(id!=0)write("p,"+id+","+mice.tx+","+mice.ty);
      getData();
    }
  }
  
  void getData(){
    if(available() > 0){
      String inString[] = split(readString(),'|');
      for(int i=0;i<inString.length;i++){
        println(inString[i]);
        data = split(inString[i],',');
        try{
          if(data.length>1){
            if(data[0].equals("success")){
              id = parseInt(data[1]);
            }else if(data[0].equals("p")){
              if(!data[1].equals(name))mdata(data[1],parseInt(data[2]),parseInt(data[3]));
            }else if(data[0].equals("t")){
              if(!data[1].equals(name))TEXTS.add(new Text(parseInt(data[3]),parseInt(data[4]),data[2],data[1]));
            }
          }
        }catch(Exception e){
        }
      }
    }
  }
  void sentText(String s,int x,int y){
    write("t,"+id+","+s+","+x+","+y);
  }
  
  void newStatus(int s){
    status = s;
    t = gt;
  }
  int dt(){
    return gt-t;
  }
}

void loginip(String ip,int port){
  me = new Client(this,ip,port);
}
void write(String s){
  me.write(s+"|");
}
int available(){
  return me.available();
}
String readString(){
  return me.readString();
}
PApplet thisapp(){
  return this;
}
