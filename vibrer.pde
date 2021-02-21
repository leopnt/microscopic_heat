//Joint o;

Grid jointsGrid;

void setup() {
  size(400, 400);
  background(0);
  //o = new Joint(new PVector(width/2, height/2));
  jointsGrid = new Grid(10, 10);
}

void draw() {
  float delta = 1/frameRate;
  background(0);
  
  jointsGrid.process();
  jointsGrid.draw();
  
  //o.process();
  //o.draw();
}
