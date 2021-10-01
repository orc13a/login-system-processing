import de.bezier.data.sql.*;
boolean loggedIn = false;
boolean login = false;
boolean signUp = true;
Input signUpUsernameInput;
void setup(){
size(500,500);
rectMode(CENTER);
textAlign(CENTER);
signUpUsernameInput = new Input(width/2,height/2-100,200,50);
}

void draw(){
  clear();
  background(200);
 if(login == true){ //Login side
 
 }
 
 if(signUp == true){ //Create side
  signUpUsernameInput.display();
 }
 
 if(loggedIn == true){ //Allerede logget ind
 
 }
 
}

void mousePressed(){
  signUpUsernameInput.setActive();
}

void keyPressed(){
  signUpUsernameInput.input();
}
