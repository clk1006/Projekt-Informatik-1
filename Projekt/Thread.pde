public PVector substract(PVector a,PVector b){
  return new PVector(a.x-b.x,a.y-b.y);
}
public PVector add(PVector a,PVector b){
  return new PVector(a.x+b.x,a.y+b.y);
}
class Thread{
  PVector Pivot;
  PVector endPoint;
  PVector force,force2,force3;
  Thread(float pX,float pY,float dX,float dY){
    Pivot =new PVector(pX,pY);
    endPoint=new PVector(dX,dY);
    force=new PVector(0,0);
    force2=new PVector(0,0);
    force3=new PVector(0,0);
  }
  PVector getForce(PVector g,PVector v){
    PVector f=substract(Pivot,endPoint);
    f.normalize();
    PVector f2;
    if(f.x>0){
      f2=new PVector(-f.y,f.x);
      //println("f :"+f+" f2 :"+f2);
    }
    else{
      f2=new PVector(f.y,-f.x);
      //println("f :"+f+" f2 :"+f2);
    }
    g.mult(dt).add(v);
    this.force=g.copy();
    //println("g :"+g);
    f2.mult(g.mag());
    this.force2=f2.copy();
    //println("f2: "+f2);
    f.set(substract(f2,g));
    //println("f :"+f);
    this.force3=f.copy();
    println(add(f,g)==f2);
    return f;
  }
  void move(PVector dS){
    endPoint.add(dS);
  }
  void draw(){
    line(Pivot.x,Pivot.y,endPoint.x,endPoint.y);
    stroke(#D92E0A);
    line(endPoint.x,endPoint.y,PVector.add(endPoint,this.force).x,PVector.add(endPoint,this.force).y);
    stroke(#F0FF39);
    line(endPoint.x,endPoint.y,PVector.add(endPoint,this.force2).x,PVector.add(endPoint,this.force2).y);
    stroke(#3727F7);
    line(endPoint.x,endPoint.y,PVector.add(endPoint,this.force3).x,PVector.add(endPoint,this.force3).y);
    stroke(0);
  }
  PVector getPos(){
    return endPoint;
  }
}
