// This sketch represents a ball falling from a given height and bouncing on the ground:
// a) Without friction (no energy loss)
// b) With friction (loses a percentage of energy on each bounce)

ball ball1;
ball ball2;

void setup() {
  size(1200,720);
  
  // Create two ball instances:
  // Parameters: x, y, radius, restitution coefficient, horizontal friction, ground level, initial horizontal velocity
  ball1 = new ball(50, 50, 15, 1, 0, height/2, 5); // No energy loss
  ball2 = new ball(50, 650, 15, 0.8, 0.95, height, 5); // Energy loss with friction
}

void draw(){
  background(0);
  
  // Draw dividing line between the two scenarios
  stroke(255);
  line(0, height/2, width, height/2);
  
  // Labels
  textSize(20);
  fill(255);
  text("Without friction", 20, 20);
  text("With friction", 20, height/2 + 20);
  
  // Update and display both balls
  ball1.update();
  ball1.display();
  
  ball2.update();
  ball2.display();
  
  // Display real-time information panels
  ball1.displayInfo(width - 220, height/2 - 120);
  ball2.displayInfo(width - 220, height - 120);
}

class ball{
  float x, y; // Position
  float vx, vy; // Velocity components
  float radius; // Ball radius
  float restitution; // Coefficient of restitution (energy retained after bounce)
  float frictionX; // Horizontal friction coefficient
  float g = 0.5; // Gravitational acceleration
  float ground; // Ground level for this ball
  
  // Constructor
  ball (float posx, float posy, float r, float rest, float fricX, float gr, float velx) {
    x = posx;
    y = posy;
    radius = r;
    restitution = rest;
    frictionX = fricX;
    ground = gr;
    vx = velx;
  }
  
  void update(){
    // Apply gravity to vertical velocity
    vy += g;
      
    // Update position using current velocity
    x += vx;
    y += vy;
    
    // Check for collision with the ground
    checkBounce();  
  }
  
  void checkBounce() {
    // Detect collision with the ground
    if (y + radius >= ground) {
      // Calculate how much the ball has penetrated the ground
      float excess = (y + radius) - ground; 
      
      // Reverse vertical velocity and apply restitution (energy loss)
      vy = -abs(vy) * restitution;
      
      // Apply horizontal friction
      vx = vx * frictionX;
      
      // Correct position to avoid sinking into the ground
      y = ground - radius - excess;
      
        // Prevent small oscillations ("vibration") when velocity is very low
        if (abs(vy) < 0.5) {
          vy = 0;
          y = ground - radius;
        }
        if (abs(vx) < 0.05) {
          vx = 0;
        }
    }
  }
  
  void display(){
    // Draw the ball
    noStroke();
    fill(255, 188, 97);
    ellipse(x, y, radius*2, radius*2); 
  }
  
  void displayInfo(float posX, float posY){
    // Draw semi-transparent information panel
    fill(30, 150);
    stroke(255);
    rect(posX, posY, 200, 100);
    
     // Display real-time data
    fill(255);
    textSize(12);
    textAlign(LEFT);
    
    text("Position: (" + int(x) + ", " + int(y) + ")", posX + 10, posY + 20);
    text("Velocity: (" + nf(vx,1,2) + ", " + nf(vy,1,2) + ")", posX + 10, posY + 35);
    
    // Calculate and display speed (magnitude of velocity)
    float speed = sqrt(vx*vx + vy*vy);
    text("Speed: " + nf(speed,1,2), posX + 10, posY + 50);
    
    text("Restitution: " + restitution, posX + 10, posY + 65);
    
    text("Friction: " + frictionX, posX + 10, posY + 80);
  }
}
