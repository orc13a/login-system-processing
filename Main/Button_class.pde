class Button {
  String text;
  float x, y, w, h;
  color btnColor = 0;
  color textColor = 255;
  int textSize = 18;
  boolean hidden = true;

  Button(String text_, float x_, float y_, float w_, float h_) {
    text = text_;
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }

  void display() {
    fill(btnColor);
    rect(x, y, w, h);
    fill(textColor);
    textSize(textSize);
    text(text, x, y + 8);
    
    // Hvis en klikke hånd som musen hvis man har musen over knappen
    if (clickCheck() == true) {
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
  }
  
  void hide() {
    hidden = true;
  }
  
  void show() {
    hidden = false;
  }
  
  // Tjek om man klikker på knappen
  boolean clickCheck() {
    if (hidden == false) {
      if (mouseX > x - (w/2) && mouseX < x + (w/2) && mouseY < y + (h/2) && mouseY > y - (h/2) ) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
