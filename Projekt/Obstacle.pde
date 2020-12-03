import java.util.ArrayList;
class Obstacle{
  ArrayList<PVector> corners=new ArrayList();
  ArrayList<boolean[]> sides=new ArrayList();
  private boolean getSide(PVector a,PVector b,PVector c){
    double m=(a.y-b.y)/(a.x-b.x);
    return a.y+m*(a.x-c.x)>c.y;
  }
  Obstacle(int... points){
    PVector corner=new PVector();
    for(int i=0;i<points.length;i++){
      if(i%2==0){
        corner.x=points[i];
      }
      if(i%2==1){
        corner.y=points[i];
        corners.add(corner);
      }
    }
  }
  public boolean checkCollision(Mass m,int id){
    boolean[] sidesNew = new boolean[corners.size()];
    for(int i=0;i<corners.size();i++){
      if(i+1==corners.size()){
        sidesNew[i]=getSide(corners.get(i),corners.get(0),m.r);
      }
      else{
        sidesNew[i]=getSide(corners.get(i),corners.get(i+1),m.r);
      }
    }
    if(id>sides.size()){
      sides.add(sidesNew);
      return false;
    }
    if(sidesNew==sides.get(id)){
      return false;
    }
    sides.set(id,sidesNew);
    return true;
  }
  PVector calculateRebounce(Mass m){
    int indexNearest=0;
    double distNearest=dist(corners.get(0),m.r);
    int indexSecondNearest=1;
    double distSecondNearest=dist(corners.get(1),m.r);
    for(int i=1;i<corners.size();i++){
      if(dist(corners.get(i),m.r)<distNearest){
        indexNearest=i;
        distNearest=dist(corners.get(i),m.r);
      }
      else if(indexSecondNearest==indexNearest){
        indexSecondNearest=i;
      }
      else if(dist(corners.get(i),m.r)<distSecondNearest){
        indexSecondNearest=i;
        distSecondNearest=dist(corners.get(i),m.r);
      }
    }
    PVector a=corners.get(indexNearest);
    PVector b=corners.get(indexSecondNearest);
    PVector c=sub(b,a);
    c.normalize();
    PVector v=m.v;
    v.normalize();
    float angle;
    PVector base=new PVector(0,1);
    if(PVector.angleBetween(base,v)<PVector.angleBetween(base,c)){
      angle=PVector.angleBetween(v,c);
      angle=angle-(PI-2*angle);
    }
    else{
      angle=PVector.angleBetween(c,v);
      angle=angle+(PI-2*angle);
    }
    v=PVector.fromAngle(angle);
    v.mult(m.v.mag());
    return v;
  }
  public void draw(){
    for(int i=0;i<corners.size();i++){
      int a=i+1;
      if(a==corners.size()){
        a=0;
      }
      line(corners.get(i).x,corners.get(i).y,corners.get(a).x,corners.get(a).y);
    }
  }
}
