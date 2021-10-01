class Input {
  String value = "";
  float x, y, w, h;
  boolean active = false;
  boolean showBlinkCursor = true;
  
  Input(float x_, float y_, float w_, float h_) {  
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }

  void display() {
    fill(255);
    rect(x, y, w, h);
    fill(0);
    textSize(18);
    text(value, x, y+8);

    if (frameCount % 60 == 0) {
      if (showBlinkCursor == true) {
        showBlinkCursor = false;
      } else {
        showBlinkCursor = true;
      }
    }

    if (showBlinkCursor == true && active == true) {
      stroke(0);
      line((width / 2) + (textWidth(value) / 2) + 3, y-12, (width / 2) + (textWidth(value) / 2) + 3, y+12);
    }
  }

  void setActive() {
    if (mouseX > x - (w/2) && mouseX < x + (w/2) && mouseY < y + (h/2) && mouseY > y - (h/2) ) {
      value = "";
      active = true;
    } else {
      active = false;
    }
  }

  void input() {
    if (active == true) {
      if (key == BACKSPACE && key != ENTER && value.length() > 0) {
        value = value.substring(0, value.length() - 1);
      } else if (key != BACKSPACE && key != ENTER && value.length() < 25) {
        value += key;
      }
    }
  }
}
