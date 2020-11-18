class Thread{
  PVector Pivot;
  float length;
  PVector direction;
  Thread(float pX,float pY,float l,float dX,float dY){
    Pivot =new PVector(pX,pY);
    length=l;
    direction=new PVector(dX,dY);
  }
  PVector getForce(PVector g){
    PVector f=direction.normalize();
    f.mult(g.y);
    return f;
  }
  void move(PVector dS){
    PVector pos=Pivot.add(direction.normalize().mult(length));
    pos=pos.add(dS);
    direction=Pivot.sub(pos);
    length=direction.mag();
  }
  void draw(){
    PVector pos=Pivot.add(direction.normalize().mult(length));
    line(Pivot.x,Pivot.y,pos.x,pos.y);
  }
  PVector getPos(){
    return Pivot.add(direction.normalize().mult(length));
  }
}
