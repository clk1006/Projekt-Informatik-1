// Default colors
final int fillColor=255;
final int bgColor=128;

// Two global variables for time control between the draw() calls.
// Time interval for step wise linear calculation, in seconds
// and time keeper global variable (see below)
float dt = 10; // dummy value, will be calculated on the fly ... 
// we need a variable to remember the time of last drawing the scene
float timestamp = 0;

// Gravity g factor ("Ortsfaktor") in this environment 
Gravity gravity = new Gravity();

// The physical objects to be created (here:globally available):
Mass m1;        // a point mass object
Mass m2;        // a point mass object
Thread s1;      // a metal spring with linear force law

// Some properties of the starting scene: mass, position and velocity for m1
float m0 = 1;
int posx0 = 100;
int posy0 = 160;
float v0x = 0;
float v0y = 0;


// Setup the scene
void setup() {
  frameRate(5);
  // drawing environment setup
  size(200, 400);
  ellipseMode(CENTER);
  fill(fillColor);
  // create mass point of with the given parameters from above
  m1 = new Mass();
  m1.m = m0;
  m1.setPos(posx0, posy0);
  // (... think about the following statement with two dots ... understood ?)
  m1.v.set(v0x,v0y);
  m1.draw();
  
  // create mass point like m1, a little bit left from it.
  m2 = new Mass();
  m2.m = m0;
  m2.setPos(posx0-50, posy0);
  // (... think about the following statement with two dots ... understood ?)
  m2.v.set(v0x,v0y);
  m2.draw();
  

  // create a Spring from 100,0 to 100,100, 
  // regular length (no force) of 100, spring constant 0.1 N/m
  // (the second point shall be the position of the mass m1
  s1 = new Thread(posx0-30,posy0-60,posx0,posy0);
  s1.draw();
  line(0,100,200,100); // starting height
  
  // REMARK: the fact that spring is connected (!) on both end points 
  // (fixed to background and fixed to mass point m1) is not 
  // part of the object models yet. it is realized in the draw routine
  // and that means, it is "global" knowledge, not known by the objects s1 and m1 themself
  
}

// Physical simulation
void draw() {
  
  // start condition: at very first round we have no timestamp from last round
  if (timestamp == 0) {
    timestamp = millis();
    // do nothing and exit draw() this time only
    return;
  }
  
  // dynamics of mass m1 and connected spring 
  
  // calculate external forces 
  PVector f = new PVector(0,0,0);
  
  // Gravitation force: 
  PVector fg = gravity.getForce(m1.m);
  
  // Spring force:
  PVector fs = new PVector();
  fs.set(s1.getForce(fg,m1.v).mult(m1.m));
  // Calculate overall force
  f.add(fg);
  f.add(fs);
  //println("f: "+f+" fs: "+fs+" fg: "+fg);
  // calculate time difference (time interval) since last drawing
  dt = (millis() - timestamp) / 1000.0;
  
  // let the mass accelerate and move for this time interval 
  m1.accel(f);
  m1.move();
  
  // the spring end point must move with the mass center to its new location
  // (while the spring starting point remains at its inital plpace) 
  s1.move(PVector.sub(m1.r,s1.getPos()));
  
  // dynamics of m2
  fg = gravity.getForce(m2.m);
  // let the mass accelerate and move for this time interval 
  m2.accel(fg);
  m2.move();
  
  // record time stamp for next step's interval calculation
  timestamp = millis();

  // and redraw the new scene
  background(bgColor);
  // starting height line as orientation 
  line(0,100,200,100); 
  rect(0,101,200,400);
  // the objects
  m1.draw();
  s1.draw();
  m2.draw();
}
