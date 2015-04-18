class Robot extends Actor{
  boolean turnDirection = true;
  boolean move = true;
  int direction = 0;
  int stepsBeforeTurn = 0;
  int stepsBeforeTurnCount = 0;
  int gridCount = 0;
  boolean[] accessibleBits = {};
  HUD hud;

  public void act(){
    checkTargeted();
    if(move){
      movement();
    }
  }

  public void movement(){
    switch(direction){
      case 0:
        x++;
        break;
      case 1:
        y--;
        break;
      case 2:
        x--;
        break;
      case 3:
        y++;
        break;
    }
    
    //disable controls while moving between grids
    if(gridCount == 31){
      //manage turning
      stepsBeforeTurnCount++;
      if(stepsBeforeTurnCount == stepsBeforeTurn){
        stepsBeforeTurnCount = 0;
        if(turnDirection){
          direction++;
          if(direction > 3){
            direction = 0;
          }
        }
        else{
          direction--;
          if(direction < 0){
            direction = 3;
          }
        }
      }
      gridCount = 0;
    }
    else{
      gridCount++;
    }
  }

  public void checkTargeted(){
    boolean xCollision = mouseX > x && mouseX < x + w;
    boolean yCollision = mouseY > y && mouseY < y + h;
    if(xCollision && yCollision && mousePressed){
      hud.setTarget(this);
    }
  }

  /*
   * Maybe use bits array directly? Hmmmm.
   */

  public boolean[] getBits(){
    boolean[] bits = new boolean[totalBits];
    for(int i = 0; i < bits.length; i++){
      bits[i] = true;
    }
    bits[0] = turnDirection;
    bits[1] = move;
    return bits;
  }

  public void setBits(boolean[] bits){
    turnDirection = bits[0];
    move = bits[1];
  }

  public boolean[] getBitsAvailable(){
    return accessibleBits;
  }
  
  public Robot(int x, int y, HUD hud, String robotID){
    graphic = loadImage("robot.png");
    accessibleBits = new boolean[totalBits];
    for(int i = 0; i < accessibleBits.length; i++){
      accessibleBits[i] = true;
    }
    this.hud = hud;
    this.x = x;
    this.y = y;
    this.w = 32;
    this.h = 32;

    //also check level mebe?
    if(robotID.equals("00")){
      this.stepsBeforeTurn = 4;
      this.turnDirection = true;
      this.direction = 2;
    }
    if(robotID.equals("01")){
      this.stepsBeforeTurn = 1;
      this.turnDirection = false;
      this.direction = 1;
    }
  }
}

final int totalBits = 4;
