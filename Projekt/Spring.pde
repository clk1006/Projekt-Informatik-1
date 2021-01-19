class Spring {
  float D;
  float springLength;
  PVector r0;
  PVector r1;
  int connectedMass=-1;
  Spring(float x0, float y0, float x1, float y1, float l, float d) {
    D = d;
    springLength = l;
    r0 = new PVector();
    r1 = new PVector();
    r0.set(x0,y0,0);
    r1.set(x1,y1,0);
  }
  Spring(float x0, float y0, float x1, float y1, float l, float d, int connectedMass) {
    D = d;
    springLength = l;
    r0 = new PVector();
    r1 = new PVector();
    r0.set(x0,y0,0);
    r1.set(x1,y1,0);
    this.connectedMass=connectedMass;
  }
  float getLength() {
    PVector d = new PVector();
    d.set(r1).sub(r0);
    return d.mag();
  }
  PVector getForce() {
    PVector f = new PVector();
    f.set(r1);
    f.sub(r0);
    f.normalize();
    f.mult(-1.0*D*(this.getLength()-springLength));
    return f;
  }
  void setR0(PVector r) {
    r0.set(r);
  }
  void setR1(PVector r) {
    r1.set(r);
  }
  void draw() {
    line(r0.x, r0.y, r1.x, r1.y);
  }
}
