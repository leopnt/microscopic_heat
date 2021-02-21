class Grid {
  int rows;
  int cols;
  
  int dr; // width of a row in pixels
  int dc; // height of a col in pixels
  
  Joint[][] joints;
  
  Grid(int rows_, int cols_) {
    rows = rows_;
    cols = cols_;
    
    dr = width / rows;
    dc = height / cols;
    
    joints = new Joint[rows][cols];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        PVector pos = new PVector(i * dr, j * dc);
        joints[i][j] = new Joint(pos);
      }
    }
  }
  
  void process() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        joints[i][j].process();
        float r = random(0, 1);
        if (r < 0.0002) joints[i][j].hammer(20);
      }
    }
  }
  
  void draw() {
    push();
    translate(dr/2, dc/2);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        joints[i][j].draw();
      }
    }
    pop();
  }
}
