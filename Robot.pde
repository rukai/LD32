class Robot extends Actor{
  boolean turnDirection = true;
  int stepsBeforeTurn = 0;
  HUD hud;

  public void act(){
    x++;
    checkTargeted();
  }

  public void checkTargeted(){
    boolean xCollision = mouseX > x && mouseX < x + w;
    boolean yCollision = mouseY > y && mouseY < y + h;
    if(xCollision && yCollision && mousePressed){
      print("FROOB");
    }
  }
  
  public Robot(int x, int y, HUD hud){
    graphic = loadImage("robot.png");
    this.hud = hud;
    this.x = x;
    this.y = y;
    this.w = 32;
    this.h = 32;
  }
}
