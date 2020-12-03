class Mass {
  float m;
  PVector r;
  PVector v;
  int size = 10;
  Mass(float m,float rX,float rY,float vX, float vY, int size){
    this.m=m;
    r=new PVector(rX,rY);
    v=new PVector(vX,vY);
    this.size=size;
  }
  void accel(PVector extForce) {
    PVector acc = new PVector();
    acc.set(extForce);
    acc.div(m);
    PVector dv = acc.mult(dt);
    v.add(dv);
  }
  void move() {
    PVector dr = new PVector();
    dr.set(v);
    dr.mult(dt);
    r.add(dr);
  }
  void setPos(int x, int y) {
    r.set(x,y,0);
  }
  void draw() {
    ellipse(r.x, r.y,size,size);
  }
}
