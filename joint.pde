class Joint {
  PVector position;
  PVector stablePos; // the position that the joint wants stay
  float mass;
  float amplitude;
  float stableAmp;
  float k; // constrols how fast the joint will stabilize
  
  float t;
  float dt;
  
  Joint(PVector initialPos) {
    stablePos = initialPos.copy();
    position = initialPos.copy();
    mass = 1;
    
    amplitude = 0;
    
    k = 0.01;
    
    t = random(0, 10);
    dt = 0.1; // controls how fast the joint is moving
  }
  
  void process() { 
    float noiseX = map(noise(t), 0, 1, -1, 1);
    float noiseY = map(noise(t + 10), 0, 1, -1, 1);
    
    position.x = stablePos.x + amplitude * noiseX;
    position.y = stablePos.y + amplitude * noiseY;
    
    stabilize();
    
    t += dt;
  }
  
  void hammer(float newAmplitude) {
    amplitude = newAmplitude;
    dt = 0.1;
  }
  
  void stabilize() {
    float da = k * amplitude;
    amplitude -= da;
    
    dt -= 0.01 * dt; // slow down
  }
  
  void draw() {
    push();
    noStroke();
    ellipse(position.x, position.y, 10, 10);
    pop();  
  }
}
