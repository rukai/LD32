class Robot extends Actor{
  boolean turnDirection = true;
  boolean move = true;
  int direction = 0;
  int stepsBeforeTurn = 0;
  int stepsBeforeTurnCount = 0;
  int gridCount = 0;
  boolean[] accessibleBits = {};
  List<Actor> actors;
  HUD hud;

  public void act(){
    checkTargeted();
    if(move){
      movement();
    }
    checkDeath();
  }
  
  private void checkDeath(){
    if(collision(Lava.class) != null){
      actors.remove(this);
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
  
  public Robot(int x, int y, HUD hud, List<Actor> actors, String robotID){
    graphic = loadImage("robot.png");
    accessibleBits = new boolean[totalBits];
    for(int i = 0; i < accessibleBits.length; i++){
      accessibleBits[i] = true;
    }
    this.hud = hud;
    this.actors = actors;
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

  /*
   * Return any actors that collide with this actor
   */
  private Actor collision(Class cls){
    for(Actor actor : actors){
      if(collision(actor) && actor != this && actor.getClass() == cls){
          return actor;
      }
    }
    return null;
  }

  /*
   * Check if collision occurs with the specified actor
   */
  private boolean collision(Actor actor){
    boolean xCollision = !(x + w < actor.getX() || x > actor.getX() + actor.getW());
    boolean yCollision = !(y + h < actor.getY() || y > actor.getY() + actor.getH());
    return xCollision && yCollision;
  }

  /*
   * Return an actor at the passed location
   */
  private Actor actorAtLocation(int x, int y){
    for(Actor actor : actors){
      if(actorAtLocation(actor, x, y)){
          return actor;
      }
    }
    return null;
  }

  /*
   * Check if an actor is at the passed location
   */
  private boolean actorAtLocation(Actor actor, int x, int y){
    boolean xCollision = x > actor.getX() && x < actor.getX() + actor.getW();
    boolean yCollision = y > actor.getY() && y < actor.getY() + actor.getH();
    return xCollision && yCollision;
  }
}

final int totalBits = 4;
