import java.util.ArrayList;
class Obstacle{
  ArrayList<PVector> corners=new ArrayList();
  boolean[] sides;
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
    sides=new boolean[corners.size()];
  }
  
}
