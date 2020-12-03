final int fillColor=255;
final int bgColor=128;
float dt = 10;
float timestamp = 0;
Gravity gravity = new Gravity();
Mass m1;        // a point mass object
void setup() {
  size(200, 400);
  ellipseMode(CENTER);
  fill(fillColor);
  m1 = new Mass(1,100,100,0,0,10);
  line(0,100,200,100);
}
void draw() {
  if (timestamp == 0) {
    timestamp = millis();
    return;
  }
  PVector f = new PVector(0,0,0);
  PVector fg = gravity.getForce(m1.m);
  f.add(fg);
  dt = (millis() - timestamp) / 1000.0;
  m1.accel(f);
  m1.move();
  timestamp = millis();
  background(bgColor);
  line(0,100,200,100); 
  rect(0,101,200,400);
  m1.draw();
}
public double dist(PVector a,PVector b){
  return sqrt((a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y));
}
