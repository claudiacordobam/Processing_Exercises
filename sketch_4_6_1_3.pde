// Represent the motion of two satellites with 
// different masses orbiting around a planet.

// Definition of variables
float planetX, planetY, planetMass; // Coordinates and mass of the planet
float gravity = 9.8; // Gravitational acceleration (simplified)
float dt = 1; // Time step for each frame of the simulation
Satellite sat1, sat2; // Two satellites instantiated from the Satellite class

void setup() {
  size(1200, 720); // Set window size
  
  // Planet setup
  planetX = width/2;
  planetY = height/2;
  planetMass = 1000;
 
  // Create satellites with initial positions and masses
  sat1 = new Satellite(400, 300, 30);
  sat2 = new Satellite(500, 300, 20);
  
  // Set initial tangential velocities for stable orbit
  sat1.setInitialVelocity(planetX, planetY);
  sat2.setInitialVelocity(planetX, planetY);
}

void draw() {
  background(0); // Clear the screen with black
 
  // Draw planet
  noStroke();
  fill(173, 246, 255);
  ellipse(planetX, planetY, 70, 70);
  
  // Update and display each satellite
  sat1.update();
  sat1.display();
  
  sat2.update();
  sat2.display();
  
  // Instruction panel in bottom-right corner
  fill(0, 150); // Semi-transparent background
  rect(width - 260, height - 120, 250, 110, 10);
  
  fill(255);
  textSize(12);
  textAlign(LEFT);
  
  // Instructions text
  text("Controls:", width - 250, height - 100);
  text("UP / DOWN → Satellite 1 mass", width - 250, height - 80);
  text("LEFT / RIGHT → Satellite 2 mass", width - 250, height - 60);
  
  // Display current satellite masses
  text("Sat1 mass: " + sat1.m, width - 250, height - 40);
  text("Sat2 mass: " + sat2.m, width - 250, height - 20);
}

class Satellite {
  float x, y, vx, vy, m; // Position, velocity, and mass
  ArrayList<PVector> trail; // Trail to visualise orbit

  Satellite (float x, float y, float m) {
    this.x = x;
    this.y = y;
    this.m = m;
    this.vx = 0; // Initial x velocity
    this.vy = 0; // Initial y velocity
    trail = new ArrayList<PVector>(); // Initialise trail
  }
  
  // Set initial tangential velocity for circular orbit
  void setInitialVelocity(float planetX, float planetY) {
    float dx = this.x - planetX;
    float dy = this.y - planetY;
    float r = sqrt(dx*dx + dy*dy);
    
    // Magnitude of tangential velocity for circular orbit
    float v = sqrt(gravity * planetMass / r);
    
    // Velocity perpendicular to radius (tangential)
    this.vx = -dy / r * v;
    this.vy = dx / r * v;
  }
  
  void update() {
    float ax, ay, dx, dy, r;
    
    // Calculate the distance to the planet
    dx = this.x - planetX;
    dy = this.y - planetY;
    r = sqrt(sq(dx) + sq(dy)); // Distance to the planet

    // Calculate the acceleration due to gravity
    ax = -gravity * planetMass * dx / (r * r * r);
    ay = -gravity * planetMass * dy / (r * r * r);
    
    // Update the velocity
    this.vx += ax * dt;
    this.vy += ay * dt;
    
    // Update the position
    this.x += this.vx * dt;
    this.y += this.vy * dt;
    
    // Generate the trail
    trail.add(new PVector(this.x, this.y));
    if (trail.size() > 200) {
      trail.remove(0);
    }
  }
  
  void display() {
    // Draw the satellites' orbits/trails
    noFill();
    stroke(150);

    beginShape();
    for (PVector p : trail) {
      vertex(p.x, p.y);
    }
    endShape();
    
    // Draw satellite
    // Scale the size according to the mass
    float size = this.m * 2;  // You can adjust the factor to make them larger or smaller
  
    // Colour depending on the mass
    // Greater mass → more red
    float r = map(this.m, 10, 30, 100, 255);  // m=10 → r=100, m=30 → r=255
    float g = map(this.m, 10, 30, 150, 100);  // Optional: variable green component
    float b = map(this.m, 10, 30, 150, 50);   // Optional: variable blue component
    fill(r, g, b);
    
    noStroke();
    ellipse(this.x, this.y, size, size);
  }
}

void keyPressed() {
  // Adjust Satellite 1 mass → UP / DOWN
  if (keyCode == UP) {
    sat1.m += 1;
  }
  if (keyCode == DOWN) {
    sat1.m = max(1, sat1.m - 1); // Avoid negative mass
  }
  
  // Adjust Satellite 2 mass → RIGHT / LEFT
  if (keyCode == RIGHT) {
    sat2.m += 1;
  }
  if (keyCode == LEFT) {
    sat2.m = max(1, sat2.m - 1);
  }
}
