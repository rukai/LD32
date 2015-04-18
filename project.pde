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
      String objectID = levels[currentLevel][y][x];
      if(checkRobotID(objectID)){
        actors.add(new Robot(x * 32, y * 32, hud, actors, levels[currentLevel][y][x]));
      }
      else if(objectID == "a "){
        actors.add(new Obstacle(x * 32, y * 32));
      }
      else if(objectID == "l "){
        actors.add(new Lava(x * 32, y * 32));
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
  List<Actor> tmpActors = new ArrayList<Actor>(actors);
  for(Actor actor : tmpActors){
    actor.act();
  }

  //draws
  background(80, 235, 90);
  for(Actor actor : tmpActors){
    image(actor.getGraphic(), actor.getX(), actor.getY());
  }
  image(hud.getGraphic(), 0, height-64);
}
