import java.util.ArrayList;
class Obstacle{
  ArrayList<PVector> corners=new ArrayList();
  ArrayList<boolean[]> sides=new ArrayList();
  private boolean getSide(PVector a,PVector b,PVector c){
    double m=(a.y-b.y)/(a.x-b.x);
    return (a.y+m*(a.x-c.x))>c.y;
  }
  Obstacle(int... points){
    PVector corner=new PVector();
    for(int i=0;i<points.length;i++){
      if(i%2==0){
        corner.x=points[i];
      }
      if(i%2==1){
        corner.y=points[i];
        corners.add(corner.copy());
      }
    }
  }
  public Return checkCollision(Mass m,int id){
    PVector r=m.r.copy();
    if(id>(sides.size()-1)){
      boolean[] sidesNew=new boolean[corners.size()];
      for(int i=0;i<corners.size();i++){
        if(i+1==corners.size()){
          sidesNew[i]=getSide(corners.get(i),corners.get(0),r);
        }
        else{
          sidesNew[i]=getSide(corners.get(i),corners.get(i+1),r);
        }
      }
      sides.add(sidesNew);
      return new Return(false,0);
    }
    for(int i=0;i<corners.size();i++){
      if(i+1==corners.size()){
        boolean side=getSide(corners.get(i),corners.get(0),r);
        if(side!=sides.get(id)[i]){
          sides.get(id)[i]=side;
          if(between(corners.get(i).x,r.x,corners.get(0).x)||between(corners.get(i).y,r.y,corners.get(0).y)){
            return new Return(true,i); 
          }
        }
      }
      else{
        boolean side=getSide(corners.get(i),corners.get(i+1),r);
        if(side!=sides.get(id)[i]){
          sides.get(id)[i]=side;
          if(between(corners.get(i).x,r.x,corners.get(i+1).x)||between(corners.get(i).y,r.y,corners.get(i+1).y)){
            return new Return(true,i); 
          }
        }
      }
    }
    return new Return(false,0);
  }
  PVector calculateRebounce(Mass m,int side,int id){ 
    PVector a=corners.get(side);
    
    PVector b=corners.get(0);
    if(side!=corners.size()-1){
      b=corners.get(side+1);
    }
    PVector c=b.copy().sub(a);
    c.normalize();
    PVector v=m.v.copy();
    v.normalize();
    PVector ret=rotate(c,getAngle(c)-getAngle(v));rotate(c.copy(),getAngle(c.copy())-getAngle(v.copy()));
    ret.mult(m.v.mag());
    sides.get(id)[side]=!sides.get(id)[side];
    return ret;
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
class Return{
 public int side;
 public boolean collided;
 Return(boolean a,int b){
   side=b;
   collided=a;
 }
}
