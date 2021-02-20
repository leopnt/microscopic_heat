Joint o;

void setup() {
  size(400, 400);
  background(0);
  o = new Joint(new PVector(width/2, height/2));
}

void draw() {
  float delta = 1/frameRate;
  background(0);
  o.process(delta);
  o.draw();
}
