class HUD{
  private Robot target;
  private boolean[] bits = {};
  private boolean[] bitsAvailable = {};
  private boolean pressable = true;
  private boolean keyPressable = true;

  private PGraphics graphic;
  private PImage bitSpritesheet;
  private PImage HUDSpritesheet;
  private PImage shutterSpritesheet;
  private AudioPlayer setTargetSFX;

  public HUD(){
    setTargetSFX = minim.loadFile("sfx/setTarget.wav");
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
    graphic.background(0);
    graphic.image(HUDSpritesheet, 0, 0);
    drawBits();
    drawRobotStatus();
    drawLevelMessage();
    graphic.endDraw();
  }
  
  /*
   * Draw the modifiable robot bits
   */
  public void drawBits(){
    //bits
    if(target == null){
      for(int i = 0; i < 4; i++){
        graphic.image(shutterSpritesheet, i * 32, 0);
      }
    }
    else{
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
  }

  /*
   * Draw ricey robot status
   */
  public void drawRobotStatus(){
    int statusX = 150;
    graphic.fill(0);
    if(target == null){
      graphic.text("Robot Status:", statusX, 20);
      graphic.text("N\\A", statusX, 35);
    }
    else{
      graphic.text("Robot Status:", statusX, 20);
      graphic.text("Coords: " + target.getX() + ", " + target.getY(), statusX, 35);
      String statusMessage;
      if(target.isAlive()){
        graphic.fill(#177b0d);
        statusMessage = "Operational";
      }
      else{
        graphic.fill(235, 10, 10);
        statusMessage = "Eliminated";
      }
      graphic.text("State: " + statusMessage , statusX, 50);
    }
  }

  /*
   * Draws a unique message for each level
   */
  public void drawLevelMessage(){
    int messageX = 300;
    graphic.fill(0);
    String message = levelMessage[currentLevel];
    graphic.text(levelMessage[currentLevel], messageX, 25);
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
    if(target != null){
      analyseTarget();
      setTargetSFX.rewind();
      setTargetSFX.play();
    }
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
  final String inputs = "qwer";
  private void checkButtons(){
    int relMouseX = mouseX;
    int relMouseY = mouseY - (height - HUDSpritesheet.height);
    boolean xCollision = relMouseX > 0 && relMouseX < bitsAvailable.length * 32;
    boolean yCollision = relMouseY > 0 && relMouseY < HUDSpritesheet.height;
  
    //mouse controls
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
    
    //qwer controls
    if(keyPressed){
      if((key == 'q' || key == 'w' || key == 'e' || key == 'r') && keyPressable){
        int bitIndex = 0;
        if(key == 'q'){
          bitIndex = 0;
        }
        else if(key == 'w'){
          bitIndex = 1;
        }
        else if(key == 'e'){
          bitIndex = 2;
        }
        else if(key == 'r'){
          bitIndex = 3;
        }
        bits[bitIndex] = !bits[bitIndex];
        modifyTarget();
      }

      keyPressable = false;
    }
    else{
      keyPressable = true;
    }
  }
}
