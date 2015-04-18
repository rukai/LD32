import java.util.*;
import ddf.minim.*;

List<Actor> actors = new ArrayList<Actor>();
HUD hud;

int currentLevel = 0;

void setup(){
  size(640, 640);
  hud = new HUD();

  setupLevel();
}

void setupLevel(){
  for(int y = 0; y < levels[currentLevel].length; y++){
    for(int x = 0; x < levels[currentLevel][y].length; x++){
      if(levels[currentLevel][y][x].equals("r ")){
        actors.add(new Robot(x * 32, y * 32, hud));
      }
      if(levels[currentLevel][y][x].equals("a ")){
        actors.add(new Obstacle(x * 32, y * 32));
      }
    }
  }
}

void draw(){

  //act
  hud.act();
  for(Actor actor : actors){
    actor.act();
  }

  //draws
  background(0);
  for(Actor actor : actors){
    image(actor.getGraphic(), actor.getX(), actor.getY());
  }
  image(hud.getGraphic(), 0, height-64);
}
