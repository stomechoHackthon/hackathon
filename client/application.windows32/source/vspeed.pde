int vspeed(int p,int t,int st,int dt,float time){
  return p+(int)(vspeed((float)(time-st)/dt)*(t-p));
}

float vspeed(float t){
  if(t<=0.5) return 2*t*t;
  else return 4*t-2*t*t-1;
}
