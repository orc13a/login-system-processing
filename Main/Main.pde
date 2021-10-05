import de.bezier.data.sql.*;
import java.security.*;

SQLite db;

boolean loggedIn = false;
boolean login = true;
boolean signUp = false;
boolean formError = false;

String formErrorText = "";

Title loginTitle;
Title signupTitle;
Title loggedinTitle;

Input loginUsernameInput;
Input loginPasswordInput;
Input signUpUsernameInput;
Input signUpPasswordInput;

Button loginSubmitBtn;
Button loginBackBtn;
Button opretSubmitBtn;
Button signupBtn;
Button opretBtn;
Button logoutBtn;

void setup() {
  size(500, 500);
  smooth(8);
  pixelDensity(2);
  
  rectMode(CENTER);
  textAlign(CENTER);
  
  loginTitle = new Title("Login", width/2, 100);
  signupTitle = new Title("Opret", width/2, 100);
  loggedinTitle = new Title("Logged ind", width/2, 100);
  
  loginUsernameInput = new Input(width/2, height/2 - 35, 300, 45);
  loginPasswordInput = new Input(width/2, height/2 + 35, 300, 45);
  signUpUsernameInput = new Input(width/2, height/2 - 35, 300, 45);
  signUpPasswordInput = new Input(width/2, height/2 + 35, 300, 45);
  
  loginPasswordInput.password = true;
  signUpPasswordInput.password = true;
  
  loginUsernameInput.placeholder = "Brugernavn";
  loginPasswordInput.placeholder = "Adgangskode";
  signUpUsernameInput.placeholder = "Brugernavn*";
  signUpPasswordInput.placeholder = "Adgangskode*";
  
  loginSubmitBtn = new Button("LOGIN", width/2, height/2 + 115, 300, 45);
  loginBackBtn = new Button("TILBAGE", width/2, height/2 + 170, 300, 45);
  opretSubmitBtn = new Button("OPRET", width/2, height/2 + 115, 300, 45);
  opretBtn = new Button("OPRET DIG", width/2, height/2 + 170, 300, 45);
  logoutBtn = new Button("LOG UD", width-75, 40, 100, 45);
}

void draw() {
  clear();
  background(200);
  
  // Login side
  if (login == true) {
    loginTitle.display();
    
    if (formError) {
      fill(#ff4040);
      textSize(14);
      text(formErrorText, width/2, height/2-100);
    }
    
    loginUsernameInput.display();
    loginPasswordInput.display();
    
    loginSubmitBtn.show();
    opretBtn.show();
    
    loginSubmitBtn.display();
    opretBtn.display();
  }

  // Create side
  if (signUp == true) {    
    signupTitle.display();
    
    textSize(12);
    text("* skal udfyldes", width/3 - 20, height/2 - 75);
    
    if (formError) {
      fill(#ff4040);
      textSize(14);
      text(formErrorText, width/2, height/2-100);
    }
    
    signUpUsernameInput.display();
    signUpPasswordInput.display();
    
    opretSubmitBtn.show();
    loginBackBtn.show();
    
    opretSubmitBtn.display();
    loginBackBtn.display();
  }
  
  // Allerede logget ind
  if (loggedIn == true) {
    loggedinTitle.display();
    
    logoutBtn.display();
  }
}

void formErrorReset() {
  formErrorText = "";
  formError = false;
}

void mousePressed() {
  loginUsernameInput.setActive();
  loginPasswordInput.setActive();
  
  signUpUsernameInput.setActive();
  signUpPasswordInput.setActive();
  
  // OPRET knap klik
  if (opretBtn.clickCheck() == true) {
    formErrorReset();
    
    opretBtn.hide();
    
    login = false;
    signUp = true;
  }
  
  // TILBAGE knap klik
  if (loginBackBtn.clickCheck() == true) {
    formErrorReset();
    
    loginBackBtn.hide();
    
    signUp = false;
    login = true;
  }
  
  // LOGIN knap klik
  if (loginSubmitBtn.clickCheck() == true && login == true) {
    formErrorReset();
    
    if (loginUsernameInput.value.length() == 0 || loginPasswordInput.value.length() == 0) {
      formErrorText = "Alle felter skal udfyldes";
      formError = true;
    } else if (formError == false && getUser(loginUsernameInput.value) == null) {
      formErrorText = "Bruger findes ikke";
      formError = true;
    } else if (hashPassword(loginPasswordInput.value) != getUser(loginUsernameInput.value).password) {
      formErrorText = "Adgangskode er forkert";
      formError = true;
    } else {
      login = false;
      loggedIn = true;
    }
  }
  
  // OPRET knap klik
  if (opretSubmitBtn.clickCheck() == true && signUp == true) {
    formErrorReset();
    
    if (signUpUsernameInput.value.length() == 0 || signUpPasswordInput.value.length() == 0) {
      formErrorText = "Alle felter skal udfyldes";
      formError = true;
    } else if (signUpUsernameInput.value.length() == 0) {
      formErrorText = "Du skal have et brugernavn";
      formError = true;
    } else if (signUpPasswordInput.value.length() < 6) {
      formErrorText = "Adgangskode skal være minimum 6 tegn lang";
      formError = true;
    } else if (formError == false && findUser() == true) {
      formErrorText = "Brugernavn allerede brugt";
      formError = true;
    } else { 
      // Gem bruger i database
      try {
        db = new SQLite(this, "appDB.sqlite");
        
        if (db.connect()) {
          db.query("insert into users values (null, \"" + signUpUsernameInput.value + "\", \"" + hashPassword(signUpPasswordInput.value) + "\");");
          
          db.close();
          
          signUp = false;
          login = true;
        } else {
          formErrorText = "Database fejl, prøv igen";
          formError = true;
        }
      } catch (Exception e) {
        println(e);
      }
    }
  }
  
  if (logoutBtn.clickCheck() == true && loggedIn == true) {
    // Log bruger ud
  }
}

boolean findUser() {
  String findUser = "";
    
  try {
    db = new SQLite(this, "appDB.sqlite");
    
    if (db.connect()) {
      db.query("select userName from users where userName = \"" + signUpUsernameInput.value + "\";");
      
      while (db.next()) {
        findUser = db.getString("userName");
      }
    } else {
      formErrorText = "Database fejl, prøv igen";
      formError = true;
    }
    
    db.close();
  } catch (Exception e) {
    println(e);
  }
  
  if (findUser.length() > 0) {
    return true;
  } else {
    return false;
  }
}

User getUser(String userName_) {
  User user = null;
  
  try {
    db = new SQLite(this, "appDB.sqlite");
    
    if (db.connect()) {
      db.query("select * from users where userName = \"" + userName_ + "\";");
      
      while (db.next()) {
        user = new User(db.getInt("userID"), db.getString("userName"), db.getString("password"));
      }
    } else {
      formErrorText = "Database fejl, prøv igen";
      formError = true;
    }
    
    db.close();
  } catch (Exception e) {
    println(e);
  }
  
  return user;
}

String hashPassword(String rawPassword) {
  StringBuffer hashed = new StringBuffer();
      
  // Hash adgangskode
  try {
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    
    md.update(rawPassword.getBytes());
    
    byte[] byteList = md.digest();
    
    for(byte b : byteList) {
      hashed.append(hex(b));
    }
  } catch(Exception e) {
    println(e);
  }
  
  return hashed.toString();
}

void keyPressed() {
  if (login == true) {
    loginUsernameInput.input();
    loginPasswordInput.input();
  }
  
  if (signUp == true) {
    signUpUsernameInput.input();
    signUpPasswordInput.input();
  }
}
