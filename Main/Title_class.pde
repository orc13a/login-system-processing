class Title {
  String text;
  float x, y;
  color textColor = 0;
  int textSize = 30;
  
  Title(String text_, float x_, float y_) {
    text = text_;
    x = x_;
    y = y_;
  }
  
  void display() {
    fill(textColor);
    textSize(textSize);
    text(text, x, y);
  }
}
