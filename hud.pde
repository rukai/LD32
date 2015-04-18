class HUD{
  private Robot target;
  private PGraphics graphic;

  public HUD(){
    graphic = createGraphics(width, 64);
    graphic.beginDraw();
    graphic.background(255);
    graphic.endDraw();
  }

  public PImage getGraphic(){
    return graphic.get();
  }

  private void drawHud(){
  }

  public void act(){
    drawHud();
  }

  public void setTarget(Robot target){
    this.target = target;
  }
}
