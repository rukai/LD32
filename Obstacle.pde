class Obstacle extends Actor{
  public Obstacle(int x, int y){
    graphic = loadImage("graphics/obstacle.png");
    this.x = x;
    this.y = y;
    this.w = 32;
    this.h = 32;
  }
}
