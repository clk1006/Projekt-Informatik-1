class Thread{
  PVector Pivot;
  PVector endPoint;
  Thread(float pX,float pY,float dX,float dY){
    Pivot =new PVector(pX,pY);
    endPoint=new PVector(dX,dY);
  }
  PVector getForce(PVector g){
    PVector f=PVector.sub(endPoint,Pivot).normalize();
    f.y=f.y*-1;
    f.x=f.x*-1;
    
    float angle=abs(acos(f.x)-PI/2);
    f.mult((cos(angle))*g.y);
    println("f: "+f.copy().normalize()+" fg+f: "+PVector.add(g,f).normalize());
    return f;
  }
  void move(PVector dS){
    endPoint.add(dS);
  }
  void draw(){
    line(Pivot.x,Pivot.y,endPoint.x,endPoint.y);
  }
  PVector getPos(){
    return endPoint;
  }
}
