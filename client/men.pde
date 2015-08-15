class men{
  Client me;
  int status = 0;
  //狀態列表
  //  0 無
  //  1 傳送登記資料
  //  2 接收id完成
  //  3  
  int sTime = 0;//紀錄狀態開始時間
  boolean serverOk = false;
  String[] getData;
  String dataType = "";
  final int maxWaitTime = 300;
  
  int id;
  String serverIp;
  String name;
  men(){
    
  }
  boolean login(String ip,int port,String name){
    try{
      me = new Client(this,ip,port);
      me.write("start,"+name);
      newStatus(1);
    } catch (Exception e){
      return false;
    }
  }
  void update(){
    if(serverOk) getData();
    switch(status){
      case 0:
        break;
      case 1:
        if(dt<=maxWaitTime && dataType == "success"){
          id = parseInt(data[2]);
          status = 2;
        }
        break;
      case 
      
    }
  }
  
  void getData(){
    if(me.avaliable() > 0){
      String inString = me.readString();
      data = split(inString,',');
      dataType = data[0];
    }
  }
  
  void newStatus(int s){
    status = s;
    t = gt;
  }
  int dt(){
    return gt-t;
  }
}
