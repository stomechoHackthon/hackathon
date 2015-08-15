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
  
  int id;
  String serverIp;
  String name;
  
  mouse mice;
  men(){
    
  }
  boolean login(String ip,int port,String name){
    try{
      me = new Client(thisapp(),ip,port);
      me.write("start,"+name);
      newStatus(1);
      return true;
    } catch (Exception e){
      return false;
    }
  }
  void update(){
    mice.set(mouseX,mouseY);
    if(serverOk) {
      me.write("p,"+id+","+mice.x+","+mice.y);
      getData();
    }
  }
  
  void getData(){
    if(me.available() > 0){
      String inString = me.readString();
      data = split(inString,',');
      if(data[0] == "success"){
        id = parseInt(data[2]);
        status = 2;
      }else if(data[0] == "p"){
        mdata(data[1],parseInt(data[2]),parseInt(data[3]));
        
      }
    }
  }
  void sentText(String s,int x,int y){
    me.write("t,"+id+","+x+","+y);
  }
  
  void newStatus(int s){
    status = s;
    t = gt;
  }
  int dt(){
    return gt-t;
  }
}

PApplet thisapp(){
  return this;
}
