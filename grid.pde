class Grid {
  int rows;
  int cols;
  
  int dr; // width of a row in pixels
  int dc; // height of a col in pixels
  
  float diffusion = 0.04;
  
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
        if (j % 2 == 0) {
          pos.x += 0.5 * dr; // position in a staggered arrangement
        }
        joints[i][j] = new Joint(pos);
      }
    }
  }
  
  void process() {
    // for each joints in grid
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        joints[i][j].process();
        diffuse(i, j);
        
        // call draw() here to avoid looping the same array two times
        draw(i, j);
      }
    }
  }
  
  void randomHammer() {
    float r = random(0, 1);
    if (r < 0.008) {
      int i = (int) random(1, rows -1);
      int j = (int) random(1, cols -1);
      joints[i][j].hammer();
    }
  }
  
  void diffuse(int i, int j) {
    float energy = joints[i][j].amplitude;
    // exclude border cases
    if (i > 0 && j > 0 && i < rows - 1 && j < cols - 1) {
      // process according to each neighbor's energy
      for (int k = -1; k <= 1; k++) {
        for (int l = -1; l <= 1; l++) {
          float neighbourEnergy = joints[i + k][j + l].amplitude;
          if (energy > neighbourEnergy) {
            float dE = diffusion * (energy - neighbourEnergy);
            joints[i + k][j + l].absorbeEnergy(dE);
          }
        }
      }
    }
  }
  
  void draw(int i, int j) {
    push();
    translate(dr/2, dc/2);
    joints[i][j].draw();
    pop();
  }
  
  void onMouseClicked() {
    int i = int(mouseX / dr);
    int j = int(mouseY / dc);
    
    joints[i][j].hammer();
  }
}
