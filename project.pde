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
      if(checkRobotID(levels[currentLevel][y][x])){
        actors.add(new Robot(x * 32, y * 32, hud, levels[currentLevel][y][x]));
      }
      else if(levels[currentLevel][y][x].equals("a ")){
        actors.add(new Obstacle(x * 32, y * 32));
      }
    }
  }
}

/*
 * Verifies that the past string is a valid robotID
 */
boolean checkRobotID(String string){
  for(String subString : string.split("")){
    if(!digits.contains(subString)){
      return false;
    }
  }
 return true;
}
String digits = "1234567890";

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
