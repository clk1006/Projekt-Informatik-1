public class Gravity extends PVector {
  private float g = 9.81;
  public Gravity() {
     super(0,0,0);
     this.y = g;
   }
   public PVector getForce(float mass) {
     return this.copy().mult(mass);
   }
}
