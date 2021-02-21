class Joint {
  PVector position;
  PVector stablePos; // the position that the joint wants stay
  float amplitude;
  float maxAmplitude;
  float k; // constrols how fast the joint will stabilize
  
  PVector electronPos;
  int rotSign;
  
  color coldColor = color(68, 173, 71);
  color hotColor = color(255, 122, 228);
  color currentColor = coldColor;
  
  float t;
  float dt;
  
  Joint(PVector initialPos) {
    stablePos = initialPos.copy();
    position = initialPos.copy();
    
    maxAmplitude = 30;
    amplitude = 0;
    
    k = 0.01;
    
    t = random(0, 10);
    resetTempo();
    
    electronPos = PVector.random2D();
    electronPos.mult(12);
    rotSign = int(round(random(-1, 1)));
    if (rotSign == 0) rotSign = 1;
  }
  
  void process() { 
    float noiseX = map(noise(t), 0, 1, -1, 1);
    float noiseY = map(noise(t + 10), 0, 1, -1, 1);
    
    position.x = stablePos.x + amplitude * noiseX;
    position.y = stablePos.y + amplitude * noiseY;
    
    stabilize();
    
    electronPos.rotate(rotSign * 0.3);
    
    t += dt;
  }
  
  void hammer() {
    amplitude = maxAmplitude;
    resetTempo();
  }
  
  void absorbeEnergy(float dE) {
    amplitude += dE;
    resetTempo();
  }
  
  void resetTempo() {
    dt = 0.1;
  }
  
  void stabilize() {
    float da = k * amplitude;
    amplitude -= da;
    
    dt -= 0.01 * dt; // slow down
  }
  
  void draw() {
    float normalizedAmp = map(amplitude, 0, maxAmplitude, 0, 1);
    color destinationColor = lerpColor(coldColor, hotColor, normalizedAmp);
    currentColor = lerpColor(currentColor, destinationColor, 0.01);
    
    push();
    noStroke();
    fill(currentColor);
    ellipse(position.x, position.y, 16, 16);
    
    ellipse(position.x + electronPos.x, position.y + electronPos.y, 4, 4);
    pop();  
  }
}
