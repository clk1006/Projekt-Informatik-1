// A class that represents a physical mass point (classical mechanics)
//
// used global variables: 
// float dt  -   the time interval that is used when accel and move are called
// 
class Mass {
  
  // mass in kg
  float m = 1;
  // location in m                   (1m = 1 pixel unless implemented differently)
  PVector r = new PVector(0,0);
  // velocity in m/s
  PVector v = new PVector(0,0);
  // size for drawing in pixel
  int size = 10;
  
  // method for acceleration
  // Parameter: extForce = effective external force to the mass in N  
  void accel(PVector extForce) {
    
    // acceleration has a direction -> vector
    PVector acc = new PVector();
    // a = F / m
    acc.set(extForce);
    acc.div(m);
    // approximation:
    // calculate as linear acceleration during dt, because dt is small:  dv = a * dt 
    PVector dv = acc.mult(dt);
    // change velocity: v = v + dv
    v.add(dv);
  }
  
  // method for acceleration
  // No parameter - the mass "knows" where to go, because of r & v ...  
  void move() {
    // the distance we have to step
    PVector dr = new PVector();
    // approximation:
    // calculate as linear motion, because dt is small:  dr = v * dt
    // (Think: why is v.mult(dt) and then dr.set(v) not a good choice, 
    // although it seems to have the same result in the first place ... ?)
    dr.set(v);
    dr.mult(dt);
    // r = r + dr
    r.add(dr);
  }
  
  // set the position of the mass
  void setPos(int x, int y) {
    r.set(x,y,0);
  }
  
  // draw the mass by ellipse at r 
  void draw() {
    ellipse(r.x, r.y,size,size);
  }
}
