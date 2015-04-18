class HUD{
  private Robot target;
  private PGraphics graphic;
  private boolean[] bits = {};
  private boolean[] bitsAvailable = {};
  private PImage bitSpritesheet;
  private PImage HUDSpritesheet;

  public HUD(){
    bitSpritesheet = loadImage("bit.png");
    HUDSpritesheet = loadImage("HUD.png");
    graphic = createGraphics(width, 64);
    graphic.beginDraw();
    graphic.background(255);
    graphic.endDraw();
  }

  public PImage getGraphic(){
    return graphic.get();
  }

  private void drawHud(){
    graphic.beginDraw();
    if(target != null){
      graphic.background(255);
      graphic.image(HUDSpritesheet, 0, 0);
      graphic.fill(0);
      graphic.text(target.getX(), 300, 30);
      graphic.text(target.getY(), 300, 47);

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
          //shutter
        }
      }
    }
    else{
      graphic.background(0);
    }
    graphic.endDraw();
  }

  public void act(){
    drawHud();
  }

  public void setTarget(Robot target){
    this.target = target;
    analyseTarget();
  }

  private void analyseTarget(){
    bits = target.getBits();
    bitsAvailable = target.getBitsAvailable();
  }
}
