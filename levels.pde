/*
 * Key:
 * "  " - empty square
 * "a " - obstacle
 * "xx" (where x is a digit from 0 to 9) - robot  e.g. 04 or 42
 */

String[][][] levels = {
  {
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "a ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "02", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "a ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "a ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
    {"  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  "},
  },
  {
    {"a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "00", "  ", "  ", "a ", "a ", "a ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "  ", "  ", "  ", "  ", "  ", "l ", "l ", "l ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "01", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "a ", "a "},
    {"a ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "  ", "a ", "a ", "a ", "a ", "a "},
    {"a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a ", "a "},
  }
};

boolean[][] availableBitsPerLevel = {
  {false, true, false, false, false, false, false},
  {true, true, false, false, false, false, false},
  {false, true, false, false, false, false, false},
};


String[] levelMessage = {
  "Click on the robot to target it.\nNow click on a bit to alter how the robot acts. \nSend it into the lava.",
  "You have access to more bits. \nNow you can change what direction the robot turns."
};
