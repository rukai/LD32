class Robot extends Actor{
  boolean turnDirection = true;
  boolean move = true;
  boolean blocked = false;
  boolean oneStep = false; //take one 32 pixel step
  boolean alive = true;
  boolean pressable = true;
  int direction = 0;
  int stepDirection = 0;
  int speed = 2; //needs to be a multiple of 32 at the moment.
  int stepsBeforeTurn = 0;
  int stepsBeforeTurnCount = 0;
  int gridCount = 0;

  //value of -1 means do not draw, 
  //0 < value < drawLaserMax means draw and increment
  //value > drawLaserMax means set to -1
  int drawLaser = -1; 
  final int drawLaserMax = 7;

  //boolean[] availableBits = {};
  List<Actor> actors;
  HUD hud;

  /*
   * Manage robot
   */
  public void act(){
    checkTargeted();
    if(move){
      movement();
    }
    checkDeath();
    laser();
  }

  /*
   * Manage laser
   */
  public void laser(){
    if(drawLaser > -1){
      drawLaser++;
      if(drawLaser > drawLaserMax){
        drawLaser = -1;
      }
    }
  }

  /*
   * Should a laser be drawn, fired at the robot
   */
  public boolean drawLaser(){
    return drawLaser > -1;
  }
  
  private void checkDeath(){
    if(collision(Lava.class) != null){
      alive = false;
      actors.remove(this);
    }
  }

  /*
   * Controls motion according to set bits
   */
  public void movement(){
    //if(!blocked){
    //  switch(direction){
    //    case 0:
    //      x += speed;
    //      break;
    //    case 1:
    //      y -= speed;
    //      break;
    //    case 2:
    //      x -= speed;
    //      break;
    //    case 3:
    //      y += speed;
    //      break;
    //  }
    //}
  

    //manage a single step accross 32 pixels
    if(gridCount >= 32){
      gridCount = 0;
      oneStep = false;
    }
    if(oneStep){
      gridCount += speed;
      switch(stepDirection){
        case 0:
          x += speed;
          break;
        case 1:
          y -= speed;
          break;
        case 2:
          x -= speed;
          break;
        case 3:
          y += speed;
          break;
      }
    }

    //manage the routine change of direction;
    if(stepsBeforeTurnCount == stepsBeforeTurn * 32/speed){
      stepsBeforeTurnCount = 0;
      if(turnDirection){
        direction--;
        if(direction < 0){
          direction = 3;
        }
      }
      else{
        direction++;
        if(direction > 3){
          direction = 0;
        }
      }
    }
    stepsBeforeTurnCount++;

    //start a step when clear
    if(!isBlocked()){
      oneStep = true;
      stepDirection = direction;
    }

    
    ////disable controls while moving between grids
    //if(gridCount > 31){
    //  //manage turning
    //  blocked = isBlocked();
    //  stepsBeforeTurnCount++;
    //  if(stepsBeforeTurnCount == stepsBeforeTurn){
    //    stepsBeforeTurnCount = 0;
    //    if(turnDirection){
    //      direction--;
    //      if(direction < 0){
    //        direction = 3;
    //      }
    //    }
    //    else{
    //      direction++;
    //      if(direction > 3){
    //        direction = 0;
    //      }
    //    }
    //  }
    //  gridCount = 0;
    //}
    //else{
    //  gridCount += speed;
    //}
    ////alow movement out of blocked state
    //if(blocked){
    //  blocked = isBlocked();
    //}
  }

  /*
   * Returns true if the robot is blocked by impassible objects
   */
  public boolean isBlocked(){
    if(direction == 0 && actorAtLocation(getX()+48, getY()+16, Obstacle.class) != null){
      return true;
    }
    else if(direction == 1 && actorAtLocation(getX()+16, getY()-16, Obstacle.class) != null){
      return true;
    }
    else if(direction == 2 && actorAtLocation(getX()-16, getY()+16, Obstacle.class) != null){
      return true;
    }
    else if(direction == 3 && actorAtLocation(getX()+16, getY()+48, Obstacle.class) != null){
      return true;
    }
    else{
      return false;
    }
  }

  /*
   * If the robot is clicked on set as a target of the HUD
   */
  public void checkTargeted(){
    boolean xCollision = mouseX > x && mouseX < x + w;
    boolean yCollision = mouseY > y && mouseY < y + h;
    if(mousePressed){
      if(xCollision && yCollision && pressable){
        hud.setTarget(this);
      }
      pressable = false;
    }
    else{
      pressable = true;
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
    drawLaser = 0;
  }

  public boolean[] getBitsAvailable(){
    return availableBitsPerLevel[currentLevel];
  }
  
  public Robot(int x, int y, HUD hud, List<Actor> actors, String robotID){
    graphic = loadImage("graphics/robot.png");
    //accessibleBits = new boolean[totalBits];
    //for(int i = 0; i < accessibleBits.length; i++){
    //  accessibleBits[i] = true;
    //}
    this.hud = hud;
    this.actors = actors;
    this.x = x;
    this.y = y;
    this.w = 32;
    this.h = 32;

    //also check level mebe?
    if(robotID == "00"){
      this.stepsBeforeTurn = 4;
      this.turnDirection = true;
      this.direction = 2;
    }
    if(robotID == "01"){
      this.stepsBeforeTurn = 1;
      this.turnDirection = false;
      this.direction = 1;
    }
    if(robotID == "02"){
      this.stepsBeforeTurn = -1;
      this.direction = 0;
      this.move = false;
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
  private Actor actorAtLocation(int x, int y, Class cls){
    for(Actor actor : actors){
      if(actorAtLocation(actor, x, y) && actor != this && actor.getClass() == cls){
        return actor;
      }
    }
    return null;
  }

  /*
   * Check if an actor is at the passed location
   */
  private boolean actorAtLocation(Actor actor, int x, int y){
    boolean xCollision = x >= actor.getX() && x <= actor.getX() + actor.getW();
    boolean yCollision = y >= actor.getY() && y <= actor.getY() + actor.getH();
    //println(y + ":" + actor.getY()+"-" + (actor.getY() + actor.getH()));
    return xCollision && yCollision;
  }

  public boolean isAlive(){
    return alive;
  }
}

final int totalBits = 4;
