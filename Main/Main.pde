import de.bezier.data.sql.*;

boolean loggedIn = false;
boolean login = false;
boolean signUp = true;

Input signUpUsernameInput;
Input signUpPasswordInput;

void setup() {
  size(500, 500);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);
  textAlign(CENTER);
  signUpUsernameInput = new Input(width/2, height/2 - 35, 300, 45);
  signUpPasswordInput = new Input(width/2, height/2 + 35, 300, 45);
}

void draw() {
  clear();
  background(200);
  
  // Login side
  if (login == true) { 
  }

  // Create side
  if (signUp == true) { 
    signUpUsernameInput.active = true;
    signUpUsernameInput.display();
    signUpPasswordInput.display();
  }
  
  // Allerede logget ind
  if (loggedIn == true) { 
  }
}

void mousePressed() {
  signUpUsernameInput.setActive();
  signUpPasswordInput.setActive();
}

void keyPressed() {
  signUpUsernameInput.input();
  signUpPasswordInput.input();
}
