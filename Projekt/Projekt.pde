final int fillColor=255;
final int bgColor=128;
float dt = 0.1;
float timestamp = 0;
Gravity gravity = new Gravity();
Mass m1;   
Obstacle[] obstacles=new Obstacle[2];
Mass[] masses=new Mass[1];
void setup() {
  size(200, 400);
  ellipseMode(CENTER);
  fill(fillColor);
  masses[0]= new Mass(1,100,150,0,0,10);
  obstacles[0]=new Obstacle(70,180,130,160);
  obstacles[1]=new Obstacle(90,140,110,140,100,110);
  line(0,100,200,100);
}
void draw() {
  if (timestamp == 0) {
    timestamp = millis();
    return;
  }
  dt = (millis() - timestamp) / 1000.0;
  for(int i=0;i<obstacles.length;i++){
    for(int a=0;a<masses.length;a++){
      Return Collision=obstacles[i].checkCollision(masses[a],a);
      if(Collision.collided){
        masses[a].v.set(obstacles[i].calculateRebounce(masses[a],Collision.side));
      }
    }
  }
  for(int i=0;i<masses.length;i++){
    PVector f = new PVector(0,0,0);
    PVector fg = gravity.getForce(masses[i].m);
    f.add(fg);
    masses[i].accel(f);
    masses[i].move(); 
  }
  timestamp = millis();
  background(bgColor);
  line(0,100,200,100); 
  rect(0,101,200,400);
  for(int i=0;i<obstacles.length;i++){
    obstacles[i].draw();
  }
  for(int i=0;i<masses.length;i++){
    masses[i].draw();
  }
}
public double dist(PVector a,PVector b){
  return sqrt((a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y));
}
public PVector rotate(PVector origin, float degrees){
  float mag=origin.mag();
  origin.normalize();
  float degreesOrigin=getAngle(origin);
  degreesOrigin+=radians(degrees);
  origin.y=sin(degreesOrigin);
  origin.x=cos(degreesOrigin);
  origin.mult(mag);
  return origin;
}
public boolean between(float a,float b,float c){
  return (a<b&&b<c)||(c<b&&b<a);
}
public float getAngle(PVector a){
  float angle=asin(a.y);
  if(abs(cos(angle)-a.x)>0.0001){
    angle+=PI; 
  }
  return degrees(angle);
}
