final int fillColor=255;
final int bgColor=128;
float dt = 0.1;
float timestamp = 0;
Gravity gravity = new Gravity();
Mass m1;       
Mass m2;   
Spring s1;      
float m0 = 10;
int posx0 = 100;
int posy0 = 100;
float v0x = 00;
float v0y = 00;
float dalphax;
float dalphay;
float alphaGrad = 90;
float alphaBogen = alphaGrad/180*3.14159;
float d = 5000;
void setup() {
  dalphax= sin(alphaBogen);
  dalphay = cos(alphaBogen);
  size(200, 400);
  ellipseMode(CENTER);
  fill(fillColor);
  m1 = new Mass();
  m1.m = m0;
  m1.setPos(100+round(100*dalphax), round(100*dalphay));
  m1.v.set(v0x,v0y);
  m1.draw();
  m2 = new Mass();
  m2.m = m0;
  m2.setPos(posx0-50, posy0);
  m2.v.set(v0x,v0y);
  m2.draw();
  s1 = new Spring(100, 0, 100+round(100*dalphax), round(100*dalphay), 100.0, d);
  s1.draw();
  line(0,100,200,100);
}
void draw() {
   if (timestamp == 0) {
    timestamp = millis();
    return;
  }
  PVector f = new PVector(0,0,0);
  
  // Gravitation force: 
  PVector fg = gravity.getForce(m1.m);
  
  // Spring force:
  PVector fs = new PVector();
  fs.set(s1.getForce());
  
  // Calculate overall force
  f.add(fg);
  f.add(fs);
  
  // calculate time difference (time interval) since last drawing
  dt = (millis() - timestamp) / 1000.0;
  
  // let the mass accelerate and move for this time interval 
  m1.accel(f);
  m1.move();
  
  // the spring end point must move with the mass center to its new location
  // (while the spring starting point remains at its inital plpace) 
  s1.setR1(m1.r);
  
  // dynamics of m2
  fg = gravity.getForce(m1.m);
  // let the mass accelerate and move for this time interval 
  m2.accel(fg);
  m2.move();
  
  // record time stamp for next step's interval calculation
  timestamp = millis();

  // and redraw the new scene
  background(bgColor);
  // starting height line as orientation 
  //line(0,100,200,100); 
  rect(0,0,200,400);
  // the objects
  m1.draw();
  s1.draw();
  //m2.draw();
}
