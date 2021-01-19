class Thread extends Spring{
  Thread(float x0, float y0, float x1, float y1, float l){
    super(x0,y0,x1,y1,l,100);
  }
  Thread(float x0, float y0, float x1, float y1, float l,float d){
    super(x0,y0,x1,y1,l,d);
  }
  Thread(float x0, float y0, float x1, float y1, float l,int connectedMass){
    super(x0,y0,x1,y1,l,100,connectedMass);
  }
  Thread(float x0, float y0, float x1, float y1, float l,float d,int connectedMass){
    super(x0,y0,x1,y1,l,d,connectedMass);
  }
  PVector getForce(){
    if(this.getLength()<springLength){
      return new PVector(0,0);
    }
    PVector f = new PVector();
    f.set(r1);
    f.sub(r0);
    f.normalize();
    f.mult(-1.0*D*(this.getLength()-springLength));
    return f;
  }
}
