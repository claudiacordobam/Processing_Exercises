// Make a simple simulation of a billiards game. 
// Place a ball at a certain point and launch it towards a second ball.
// The collision is elastic, and balls may fall into pockets.

Ball ball1; // First cue ball
Ball ball2; // Second target ball
Pocket[] pockets; // Array of pockets

void setup() {
  size(1200, 720); // Set the window size
  
  // Create two Ball instances
  // Parameters: x, y, radius, horizontal velocity, vertical velocity, colour
  ball1 = new Ball(50, 50, 20, random(3, 6), random(3, 6), color(250, 152, 160)); // Pink cue ball
  ball2 = new Ball(200, 300, 20, 0, 0, color(152, 240, 250)); // Blue target ball
  
  // Initialise the four corner pockets
  pockets = new Pocket[] {
    new Pocket(0, 0, 50), // Top-left
    new Pocket(width, 0, 50), // Top-right
    new Pocket(0, height, 50), // Bottom-left
    new Pocket(width, height, 50) // Bottom-right
  };
}

void draw() {
  background(0, 54, 33); // Draw the table's background
  
  // Update ball positions and handle collisions
  ball1.update(ball2);
  ball2.update(ball1);
  
  // Display the balls only if they have not fallen into a pocket
  if (!ball1.pocketed) ball1.display();
  if (!ball2.pocketed) ball2.display();

  // Draw pockets and check if balls have fallen in
  for (Pocket p : pockets){
    p.display();
    if (!ball1.pocketed && p.contains(ball1)) ball1.pocketed = true;
    if (!ball2.pocketed && p.contains(ball2)) ball2.pocketed = true;
  }
}

// Class to represent a billiard ball
class Ball {
  float x, y; // Position coordinates
  float vx, vy; // Velocity components
  float radius; // Ball radius
  boolean pocketed; // Flag for whether the ball is in a pocket
  color c; // Colour of the ball
  
  // Constructor to initialise a ball
  Ball (float posx, float posy, float r, float velx, float vely, color col){
    x = posx;
    y = posy;
    radius = r;
    vx = velx;
    vy = vely;
    c = col;
    pocketed = false;
  }
  
  // Update the ball's position and handle collisions with the other ball
  void update(Ball other){
    x += vx;
    y += vy; 
    
    // Calculate the distance between this ball and the other ball
    float distance = dist(x, y, other.x, other.y);   
    
    // Check for collision
    if (distance < radius + other.radius) {
      float nx = other.x - x;
      float ny = other.y - y;
      float dist = sqrt(nx*nx + ny*ny);
      nx = nx / dist; // Normal vector x-component
      ny = ny /dist; // Normal vector y-component
      
      // Calculate normal components of the velocities
      float v1_normal = vx * nx + vy * ny;
      float v2_normal = other.vx * nx + other.vy * ny;
      
      // Tangential components of velocity remain unchanged
      float v1_tangent_x = vx - v1_normal * nx;
      float v1_tangent_y = vy - v1_normal * ny;
      float v2_tangent_x = other.vx - v2_normal * nx;
      float v2_tangent_y = other.vy - v2_normal * ny;
      
      // Swap normal components for an elastic collision
      vx = v2_normal * nx + v1_tangent_x;
      vy = v2_normal * ny + v1_tangent_y;
      other.vx = v1_normal * nx + v2_tangent_x;
      other.vy = v1_normal * ny + v2_tangent_y;  
    } 
    
    // Bounce off table edges
    if (x < 0 + radius || x > width - radius) {
      vx = -vx;
    }
    
    if (y < 0 + radius || y > height - radius) {
      vy = -vy;
    }    
  }
  
  // Display the ball
  void display(){
    noStroke();
    fill(c); // Use the ball's colour
    ellipse(x, y, radius*2, radius*2); // Draw the ball
  }
}

// Class to represent a pocket on the table
class Pocket {
  float x, y, radius;
  
  // Constructor to initialise a pocket
  Pocket(float px, float py, float r){
    x = px;
    y = py;
    radius = r; 
  }
  
  // Draw the pocket
  void display() {
    fill(0);
    ellipse (x, y, radius*2, radius*2);
  }
  
  // Check if a ball is inside the pocket
  boolean contains(Ball b){
    float d = dist(x, y, b.x, b.y);
    return d < radius;
  }
}
