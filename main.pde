game1 b; // 宣告物件

void setup() {
  size(800, 600);
  b = new game1(); // 初始化物件
}

void draw() {
  background(0);
  b.display();
}

void keyPressed() {
  int dx = 0, dy = 0;
  if (keyCode == UP)    dy = -1;
  else if (keyCode == DOWN)  dy = 1;
  else if (keyCode == LEFT)  dx = -1;
  else if (keyCode == RIGHT) dx = 1;

  b.movePlayer(dx, dy);
}
