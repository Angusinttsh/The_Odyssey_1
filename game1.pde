class game1{
  int[][] grid = {
      {2, 2, 2, 2, 2, 2, 2},
      {2, 1, 1, 1, 1, 1, 2},
      {2, 1, 3, 1, 4, 1, 2},
      {2, 1, 3, 1, 1, 1, 2},
      {2, 1, 1, 1, 1, 1, 2},
      {2, 2, 2, 2, 2, 2, 2}
    };
  int maxCols = 0;
  int cellSize = 50;
  PImage imgFloor, imgWall, imgBox, imgPlayer;
  int pX, pY; // 玩家在陣列中的位置
  game1() {
    for (int i = 0; i < grid.length; i++) {
      // 檢查當前這一行的長度是否大於目前紀錄的最大值
      if (grid[i].length > maxCols) {
        maxCols = grid[i].length;
      }
    }
    // 請確保你的 data 資料夾內有這四張圖，或先用顏色替代
    imgFloor = loadImage("floor.png");
    imgWall = loadImage("wall.png");
    imgBox = loadImage("box.png");
    imgPlayer = loadImage("player.png");
    
    findPlayer();
  }
  
  void display() {
    background(50);
    
    // 計算置中偏移量
  
    float totalW = maxCols * cellSize;
    float totalH = grid.length * cellSize;
    float offsetX = (width - totalW) / 2;
    float offsetY = (height - totalH) / 2;
  
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        float x = offsetX + j * cellSize;
        float y = offsetY + i * cellSize;
        
        // 繪製邏輯
        drawTile(grid[i][j], x, y);
      }
    }
  }

  void drawTile(int type, float x, float y) {
    stroke(255, 50); // 格線
    noFill();
    rect(x, y, cellSize, cellSize);
  
    switch(type) {
      case 1: image(imgWall, x, y, 50, 50); break; // 地板 (灰)
      case 2: image(imgFloor, x, y, 50, 50); break; // 牆壁 (藍)
      case 3: image(imgBox, x, y, 50, 50); break; // 箱子 (棕)
      case 4: image(imgPlayer, x, y, 50, 50); break; // 玩家 (綠)
      // 若有圖片，請改用: image(imgPlayer, x, y, 50, 50);
    }
  }

  void movePlayer(int dx, int dy) {
    int nextY = pY + dy;
    int nextX = pX + dx;
  
    // 1. 檢查是否超出陣列邊界
    if (nextY < 0 || nextY >= grid.length || nextX < 0 || nextX >= maxCols) return;
  
    // 2. 如果下一格是地板 (1)
    if (grid[nextY][nextX] == 1) {
      swap(pY, pX, nextY, nextX);
      pY = nextY; pX = nextX;
    } 
    // 3. 如果下一格是箱子 (3)
    else if (grid[nextY][nextX] == 3) {
      int boxNextY = nextY + dy;
      int boxNextX = nextX + dx;
    if (boxNextY >= 0 && boxNextY < grid.length && boxNextX >= 0 && boxNextX < maxCols) {
      if (grid[boxNextY][boxNextX] == 1) {
        // 先推箱子，再移玩家
        grid[boxNextY][boxNextX] = 3;
        grid[nextY][nextX] = 1; 
        swap(pY, pX, nextY, nextX);
        pY = nextY; pX = nextX;
      }
    }
    }
      // 檢查箱子的下一格是否為地板
  }
  void swap(int y1, int x1, int y2, int x2) {
    int temp = grid[y1][x1];
    grid[y1][x1] = grid[y2][x2];
    grid[y2][x2] = temp;
  }
  void findPlayer() {
    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[i].length; j++) {
        if (grid[i][j] == 4) {
          pY = i; pX = j;
          return;
        }
      }
    }
  }
}
