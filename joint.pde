class Joint {
  PVector velocity;
  PVector acceleration;
  PVector position;
  PVector stablePos; // the position that the joint wants stay
  float mass;
  float k; // fluid breaking coefficient between 0.0 - 1.0
  float strenght; // how strong is the spring force
  
  float t;
  float dt;
  
  Joint(PVector initialPos) {
    stablePos = initialPos.copy();
    position = initialPos.copy();
    acceleration = new PVector();
    velocity = new PVector();
    mass = 1;
    k = 1;
    strenght = 2;
    
    t = 0.0;
    dt = 0.1;
  }
  
  void applyImpulse(PVector force) {
    acceleration.add(PVector.div(force, mass));
  }
  
  void process(float delta) {
    //randomPerturbation(delta);
    //reachStability(delta);
    
    //velocity.add(acceleration);
    //position.add(velocity);
    
    //acceleration.mult(0);
    
    position.x = stablePos.x + 10 * noise(t);
    position.y = stablePos.y + 10 * noise(t + 10);
    
    t += dt;
  }
  
  void reachStability(float delta) {
    PVector springForce = PVector.sub(stablePos, position);
    springForce.mult(strenght);
    springForce.mult(delta); // framerate independante movement
    
    PVector fluidBreak = velocity.copy().mult(-1);
    fluidBreak.mult(k);
    
    applyImpulse(fluidBreak);
    applyImpulse(springForce);
  }
  
  void randomPerturbation(float delta) {
    float activate = random(0, 1);
    if (activate < 0.1) {
      // make a random perturbation
      PVector perturbation = PVector.random2D();
      float pertStrenght = random(200, 400);
      perturbation.mult(pertStrenght);
      perturbation.mult(delta);
      
      applyImpulse(perturbation);
    }
  }
  
  void draw() {
    push();
    noStroke();
    ellipse(position.x, position.y, 10, 10);
    pop();  
  }
}
