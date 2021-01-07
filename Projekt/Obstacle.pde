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
    if(id>(sides.size()-1)){
      sides.add(new boolean[corners.size()]);
      return new Return(false,0);
    }
    PVector r=m.r.copy();
    r.add(m.v.copy().normalize().mult(m.size/2));
    //println(r);
    for(int i=0;i<corners.size();i++){
      if(i+1==corners.size()){
        boolean side=getSide(corners.get(i),corners.get(0),r);
        if(side!=sides.get(id)[i]){
          sides.get(id)[i]=side;
          if(between(corners.get(i).x,r.x,corners.get(0).x)){
            println(i);
            return new Return(true,i); 
          }
        }
      }
      else{
        boolean side=getSide(corners.get(i),corners.get(i+1),r);
        if(side!=sides.get(id)[i]){
          sides.get(id)[i]=side;
          if(between(corners.get(i).x,r.x,corners.get(i+1).x)){
            println(i);
            return new Return(true,i); 
          }
        }
      }
    }
    return new Return(false,0);
  }
  PVector calculateRebounce(Mass m,int side){
    PVector a=corners.get(side);
    PVector b;
    if(side==corners.size()-1){
      b=corners.get(0);
    }
    else{
      b=corners.get(side+1);
    }
    PVector c=sub(b,a);
    c.normalize();
    PVector v=m.v.copy();
    v.normalize();
    float angle=PVector.angleBetween(v,c);
    if(((c.x<0&&v.x>0)||(c.x>0&&v.x<0))&&((c.y<0&&v.y>0)||(c.y>0&&v.y<0))){
      c.x=-c.x;
      c.y=-c.y;
    }
    println(v);
    v=rotate(c,-degrees(angle));
    println(v);
    v.mult(m.v.mag());
    return v;
  }
  public void draw(){
    //println(corners);
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
