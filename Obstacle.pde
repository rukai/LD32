class Obstacle extends Actor{
  final int maxSprites = 4;
  public Obstacle(int x, int y){
    graphic = loadImage("graphics/obstacle.png");
    int xOffset = (int) random(4) * 32;
    graphic = graphic.get(xOffset, 0, 32, 32);
    this.x = x;
    this.y = y;
    this.w = 32;
    this.h = 32;
  }
}
