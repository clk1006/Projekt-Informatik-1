final int fillColor=255;
final int bgColor=128;
float dt = 10;
float timestamp = 0;
Gravity gravity = new Gravity();
Mass m1;        // a point mass object
Obstacle[] obstacles=new Obstacle[1];
Mass[] masses=new Mass[2];
Spring[] springs=new Spring[1];
void setup() {
  size(200, 400);
  ellipseMode(CENTER);
  fill(fillColor);
  masses[0]=new Mass(1,100,150,0,0,10);
  masses[1]=new Mass(1,150,150,0,0,10);
  obstacles[0]=new Obstacle(140,200,160,200);
  springs[0]=new Thread(75,150,100,150,25,0);
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
        PVector vNew=obstacles[i].calculateRebounce(masses[a],Collision.side,a);
        masses[a].v.set(vNew);
      }
    }
  }
  for(int i=0;i<masses.length;i++){
    PVector f = new PVector(0,0,0);
    PVector fg = gravity.getForce(masses[i].m);
    f.add(fg);
    for(int a=0;a<springs.length;a++){
      if(springs[a].connectedMass==i){
        f.add(springs[a].getForce());
      }
    }
    masses[i].accel(f);
    masses[i].move(); 
  }
  for(int i=0;i<springs.length;i++){
      springs[i].setR1(masses[springs[i].connectedMass].r);
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
  for(int i=0;i<springs.length;i++){
    springs[i].draw();
  }
}
public float fixAngle(float angle){
  while(angle>360){
    angle-=360;
  }
  while(angle<0){
    angle+=360;    
  }
  return angle;
}
public double dist(PVector a,PVector b){
  return sqrt((a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y));
}
public PVector rotate(PVector origin, float degrees){
  float mag=origin.mag();
  origin.normalize();
  degrees=fixAngle(degrees);
  float degreesOrigin=getAngle(origin);
  degreesOrigin+=degrees;
  degreesOrigin=fixAngle(degreesOrigin);
  origin.y=sin(radians(degreesOrigin));
  origin.x=cos(radians(degreesOrigin));
  origin.mult(mag);
  return origin;
}
public boolean between(float a,float b,float c){
  return (a<b&&b<c)||(c<b&&b<a);
}
public float getAngle(PVector a){
  float angle=asin(a.y);
  if(abs(cos(angle)-a.x)>1){
    angle+=PI; 
  }
  return fixAngle(degrees(angle));
}
