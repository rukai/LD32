import java.util.*;
import ddf.minim.*;

List<Actor> actors = new ArrayList<Actor>();
HUD hud;
PImage moonGraphic;
Minim minim;
AudioPlayer backgroundMusic;

int currentLevel = 0;

State state = State.PREGAME;

void setup(){
  size(640, 640);
  minim = new Minim(this);
  backgroundMusic = minim.loadFile("music/eMinor.wav");
  //backgroundMusic.loop();
  moonGraphic = loadImage("graphics/moon.png");
  hud = new HUD();

  setupLevel();
}

/*
 * Creates a list of actors as specified by the levels array
 */
void setupLevel(){
  actors = new ArrayList<Actor>();
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

/*
 * Runs the draw method for the current state
 */
void draw(){
  if(state == State.PREGAME){
    pregame();
  }
  else if(state == State.GAMEOVER){
    gameover();
  }
  else if(state == State.GAME){
    game();
  }
}

/*
 * Dispay backstory and begin game on any button press
 */
public void pregame(){
  boolean mouseInScreen = mouseX >= 0 && mouseX <= width && mouseY >= 0 && mouseY <= height;
  if((keyPressed || mousePressed) && mouseInScreen){
    state = State.GAME;
  }
  background(0);
  textAlign(CENTER);
  String introduction = "After a fierce battle, rogue robots have taken over earth.";
    introduction += "\nWe, the survivors, have established a temporary colony on the moon.";
    introduction += "\nOur only weapon, is an extremely accurate & long range electromagnetic radiation emitter.";
    introduction += "\nThe weapon cannot directly damage the robots.";
    introduction += "\nHowever if carefully aimed, we can use the electromagnetic radiation to modify bits of the robots memory.";
    introduction += "\nBy carefully choosing which bits to flip we can send the robots to their doom.";
    introduction += "\nTechnician, you have been selected to carry out this task, good luck.";
  text(introduction, width/2, 200);
  text("Press any button to continue", width/2, 400);
  image(moonGraphic, width-190, 290);
}

/*
 * Show end screen
 */
public void gameover(){
  background(0);
  textAlign(CENTER);
  text("The End.\nAll the robots have been destroyed.\nThe Earth is slowly rebuilt...", width/2, height/2);
}


/*
 * Manages the game
 */
public void game(){
  //act
  hud.act();
  List<Actor> tmpActors = new ArrayList<Actor>(actors);
  for(Actor actor : tmpActors){
    actor.act();
  }

  //draws
  background(80, 235, 90);
  for(Actor actor : actors){
    image(actor.getGraphic(), actor.getX(), actor.getY());

    //draw laser
    if(actor.getClass() == Robot.class && ((Robot) actor).drawLaser()){
      //outer
      stroke(250, 20, 20);
      line(actor.getX()+actor.getW()/2-1, actor.getY()+actor.getH()/2, width-1, 0);
      line(actor.getX()+actor.getW()/2+1, actor.getY()+actor.getH()/2, width+1, 0);

      //inner highlight
      stroke(180, 40, 40);
      line(actor.getX()+actor.getW()/2, actor.getY()+actor.getH()/2, width, 0);
    }
  }
  image(hud.getGraphic(), 0, height-64);
  

  //check win condition
  boolean robotsLeft = false;
  for(Actor actor : actors){
    if(actor.getClass() == Robot.class){
      robotsLeft = true;
      break;
    }
  }
  //finish level
  if(!robotsLeft){
    currentLevel++;
    if(currentLevel == levels.length){
      state = State.GAMEOVER;
    }
    else{
      setupLevel();
    }
  }
}
