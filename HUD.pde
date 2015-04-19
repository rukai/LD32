class HUD{
  private Robot target;
  private boolean[] bits = {};
  private boolean[] bitsAvailable = {};
  private boolean pressable = true;

  private PGraphics graphic;
  private PImage bitSpritesheet;
  private PImage HUDSpritesheet;
  private PImage shutterSpritesheet;

  public HUD(){
    bitSpritesheet = loadImage("graphics/bit.png");
    HUDSpritesheet = loadImage("graphics/HUD.png");
    shutterSpritesheet = loadImage("graphics/shutter.png");
    graphic = createGraphics(width, 64);
    graphic.beginDraw();
    graphic.background(255);
    graphic.endDraw();
  }

  public PImage getGraphic(){
    return graphic.get();
  }
  
  /*
   * Draw the HUD including bit buttons and fancy details of robot
   */
  private void drawHud(){
    graphic.beginDraw();
    if(target != null){
      graphic.background(0);
      graphic.image(HUDSpritesheet, 0, 0);
      graphic.fill(0);
      graphic.text(target.getX(), 300, 20);
      graphic.text(target.getY(), 300, 35);
      String statusMessage;
      if(target.isAlive()){
        stroke(0, 255, 0);
        statusMessage = "Status: Operational";
      }
      else{
        stroke(255, 0, 0);
        statusMessage = "Status: Eliminated";
      }
      graphic.text(statusMessage , 300, 50);

      for(int i = 0; i < bits.length; i++){
        if(bitsAvailable[i]){
          //set spritesheet offset
          int xOffset = 13;
          if(bits[i]){
            xOffset = 0;
          }
          //draw bit from spritesheet
          graphic.image(bitSpritesheet.get(xOffset, 0, xOffset+13, 26), 10+i*32, 36);
        }
        else{
          graphic.image(shutterSpritesheet, i*32, 0);
        }
      }
    }
    else{
      graphic.background(0);
    }
    graphic.endDraw();
  }

  /*
   * Update the hud
   */
  public void act(){
    if(target != null){
      checkButtons();
    }

    drawHud();
  }

  /*
   * Set the robot that the HUD will focus on
   */
  public void setTarget(Robot target){
    this.target = target;
    analyseTarget();
  }
  
  /*
   * Get information on the robot
   */
  private void analyseTarget(){
    bits = target.getBits();
    bitsAvailable = target.getBitsAvailable();
  }
  
  /*
   * Set modifications on the robot
   */
  private void modifyTarget(){
    target.setBits(bits);
  }

  /*
   * Check if the buttons on the HUD have been pressed
   */
  private void checkButtons(){
    int relMouseX = mouseX;
    int relMouseY = mouseY - (height - HUDSpritesheet.height);
    boolean xCollision = relMouseX > 0 && relMouseX < bitsAvailable.length * 32;
    boolean yCollision = relMouseY > 0 && relMouseY < HUDSpritesheet.height;

    if(mousePressed){
      if(xCollision && yCollision && pressable){
        int bitIndex = relMouseX / 32;
        bits[bitIndex] = !bits[bitIndex];
        modifyTarget();
      }
      pressable = false;
    }
    else{
      pressable = true;
    }
  }
}
