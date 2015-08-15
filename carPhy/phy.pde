class p2{
  v2 pos;
  v2v vel;
  v2v pvel;
  float w;
  float pw;
  float r;
  float m;
  p2(v2 pos,float r,float m){
    this.pos = pos;
    this.vel = new v2v(0,0);
    this.pvel = new v2v(0,0);
    this.r = r;
    this.m = m;
    w=0.001;
  }
  void run(){
    vel.setY(vel.y()+0.2);
    pos = add(pos,vel);
    pvel = vel;
    vel = mult(vel,0.999);
    w*=0.8;
  }
  
  void con(p2 p,float l,float k){
    v2v d = add( sub(p.pos, pos).toV2v(), sub(p.pvel, pvel));
    v2v f = mult(new v2v(d.angle,d.len-l),k);
    vel.set(add(vel,mult(f,p.m/(m+p.m)*0.45)));
    p.vel.set(sub(p.vel,mult(f,m/(m+p.m)*0.45)));
  }
  
  void col(p2 p){
    v2v d = add( sub(p.pos, pos).toV2v(), sub(p.pvel, pvel));
    if(abs(d.len)<(r+p.r)*0.5){
      println("col");
      v2v f = new v2v(d.angle,d.len-(r+p.r)*0.5);
      v2v n = mult(new v2v(d.angle+HALF_PI,1),((w*r-p.w*p.r)*2*PI));
      f = add(f,n);
      vel.set(add(vel,mult(f,p.m/(m+p.m)*0.5)));
      p.vel.set(sub(p.vel,mult(f,m/(m+p.m)*0.5)));
    }
  }
  void col(l2 p){
    v2v d = sub(pos,p.pos1).toV2v().projection(new v2v(p.toV2v().angle+HALF_PI,1).angle);
    if(-d.len<r*0.5){
      pos.set(add(pos,new v2v(d.angle,-d.len-r*0.5)));
      v2v f = mult(vel.projection(d.angle),-1.5);
      v2v n = mult(new v2v(d.angle+HALF_PI,1),((w*r)*2*PI));
      f = add(f,n);
      vel = add(vel,f);
    }
  }
}

class l2{
  v2 pos1;
  v2 pos2;
  l2(v2 pos1,v2 pos2){
    this.pos1 = pos1;
    this.pos2 = pos2;
  }
  v2 toV2(){
    return sub(pos2,pos1);
  }
  v2v toV2v(){
    return toV2().toV2v();
  }
}
