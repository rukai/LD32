class Actor{
  protected int x;
  protected int y;
  protected int w;
  protected int h;
  protected PImage graphic;

  public void act(){
  }

  public int getX(){
    return x;
  }

  public int getY(){
    return y;
  }

  public PImage getGraphic(){
    return graphic.get();
  }
}
