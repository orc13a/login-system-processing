class Input {
  String value = "";
  String placeholder = "";
  float x, y, w, h;
  boolean active = false;
  boolean showBlinkCursor = true;
  Input nextInput;
  
  Input(float x_, float y_, float w_, float h_) {  
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }

  void display() {
    fill(255);
    if (active) {
      stroke(#c44dff); // Giv anden stroke farve for at vise at input er aktivt
    }
    rect(x, y, w, h);
    
    fill(0);
    textSize(18);
    text(value, x, y+8);

    // Hvis input er tomt vis placeholder tekst
    if (value.length() == 0) {
      fill(#c2c2c2);
      text(placeholder, x, y+8);
    }

    // Hver 35 frame skift cursor aktiv
    if (frameCount % 35 == 0) {
      if (showBlinkCursor == true) {
        showBlinkCursor = false;
      } else {
        showBlinkCursor = true;
      }
    }
  
    // Hvis cursor
    if (showBlinkCursor == true && active == true) {
      stroke(0);
      line((width / 2) + (textWidth(value) / 2) + 3, y-12, (width / 2) + (textWidth(value) / 2) + 3, y+12);
    }
    
    stroke(0); // Reset stroke
  }

  // Hvis man klikker på input feltet
  void setActive() {
    if (mouseX > x - (w/2) && mouseX < x + (w/2) && mouseY < y + (h/2) && mouseY > y - (h/2) ) {
      active = true;
    } else {
      active = false;
    }
  }
  
  // Når man skriver i input feldtet
  void input() {
    if (active == true) {
      if (key == BACKSPACE && key != ENTER && value.length() > 0) {
        value = value.substring(0, value.length() - 1);
      } else if (key != BACKSPACE && key != ENTER && value.length() < 25) {
        value += key;
      }
    }
  }
  
  void goNextInput() {
    if (active == true && key == TAB) {
      active = false;
      nextInput.active = true;
    }
  }
}
