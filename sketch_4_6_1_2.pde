// Divide the screen into two halves. In one half, represent the movement of a mass 
// that you have given a certain initial velocity and bounces off the walls 
// (make it move in both axes, X and Y, considering that the movement occurs in the plane). 
// On the other half of the screen, represent the movement of an identical mass 
// with the same initial velocity but with the presence of a coefficient 
// of friction μ between the mass and the surface on which it moves.

// DEFINITION OF VARIABLES
float x1, y1, vx1, vy1; // Position (x1, y1) and velocity (vx1, vy1) of ball 1
float x2, y2, vx2, vy2, friction; // Position and velocity of ball 2 + friction coefficient
float diameter; // Diameter of both balls

void setup() {
  size(1200, 720); // Set canvas size: 1200px wide, 720px high
  smooth(); // Enable anti-aliasing for smoother drawing (blends the edge pixels slightly)
  ellipseMode(CENTER); // Draw ellipses from their center
  colorMode(HSB, 255); // Set color mode to HSB with range 0-255
  
  // Initialise ball 1 at random position within left half of the screen
  x1 = random(width/2 - 300, width/2 - 100);
  y1 = random(height - 500, height - 300);
  
  // Initialise ball 2 at random position within right half of the screen
  x2 = random(width/2 + 100, width/2 + 300);
  y2= random(height - 500, height - 300);
  
  diameter = 60; // Both balls have diameter = 60
  friction = 0.001; // Friction coefficient for ball 2
  
  // Initial velocities
  vx1 = 2;
  vy1 = 2;
  vx2 = 2;
  vy2 = 2;
}

void draw(){
  background(0); // Clear the screen with black background
  
  stroke(255); // White stroke
  line(width/2, 0, width/2, height); // Draw a vertical line to divide the screen in half
  
  // Ball 1 (no friction) movement
  x1 += vx1; // Update horizontal position
  y1 += vy1; // Update vertical position
  
  float rad = diameter / 2; // Radius of the ball for collision detection
  float left1 = 0 + rad; // Left boundary for ball 1
  float right1 = width/2 - rad; // Right boundary for ball 1
  float top = 0 + rad; // Top boundary (both balls share top/bottom)
  float bottom = height - rad; // Bottom boundary
  
  // Horizontal collision: reverse velocity if hitting left or right walls
  if (x1 <= left1 || x1 >= right1) {
    vx1 = -vx1;
  }
  
  // Vertical collision: reverse velocity if hitting top or bottom
  if (y1 <= top || y1 >= bottom) {
    vy1 = -vy1;
  }
  
  // Ball 2 (with friction) movement
  x2 += vx2; // Update horizontal position
  y2 += vy2; // Update vertical position
  vx2 *= (1 - friction); // Apply friction to horizontal velocity
  vy2 *= (1 - friction); // Apply friction to vertical velocity
  
  // Optional: set velocity to zero if very small (prevents jitter -tiny, unwanted rapid motion of ball-)
  if (abs(vx2) == 0){
  vx2 = 0;
  }
  
  float left2 = width/2 + rad; // Left boundary for ball 2
  float right2 = width - rad; // Right boundary for ball 2
  
  // Horizontal collision
  if (x2 <= left2 || x2 >= right2) {
    vx2 = -vx2;
  }
  
  // Vertical collision
  if (y2 <= top || y2 >= bottom) {
    vy2 = -vy2;
  } 
  
  // DRAW BALLS WITH HSB COLOR BASED ON SPEED
  noStroke();
  float vMax = 5; // Maximum expected speed for color mapping
  
  // Ball 1
  float v1 = sqrt(vx1*vx1 + vy1*vy1); // Compute speed (magnitude of velocity)
  float hue1 = map(v1, 0, vMax, 160, 0); // Map speed to HSB hue (blue -> red)
  fill(hue1, 255, 255);  // Full saturation and brightness
  ellipse(x1, y1, diameter, diameter); // Draw ball 1

  // Ball 2
  float v2 = sqrt(vx2*vx2 + vy2*vy2); // Speed magnitude
  float hue2 = map(v2, 0, vMax, 160, 0); // Map speed to HSB hue
  fill(hue2, 255, 255); // Full saturation and brightness
  ellipse(x2, y2, diameter, diameter); // Draw ball 2
  
  // USER INTERFACE (UI)
  // Ball 1 UI
  // Switch to RGB mode temporarily so we can use an exact HEX colour (#CCFEFF)
  // If we used HSB here, the colour would be distorted by the current HSB mode.
  colorMode(RGB, 255);
  fill(204, 254, 255); 
  rect(width/2 - 300, 100, 200, 75); // Draw UI rectangle for ball 1
  
  textSize(15);
  fill(0); // Black text
  text("Real-time data:", width/2 - 290, 120);
  text("Friction: 0", width/2 - 290, 140); // Display the friction coefficient for ball # 1 (0)
  text("Speed: " +nf(v1, 0, 2) + " px/frame", width/2 - 290, 160); // Display speed
  
  // Ball 2 UI
  colorMode(RGB, 255);
  fill(204, 254, 255);
  rect(width/2 + 300, 100, 200, 75); // Draw UI rectangle for ball 2
  
  textSize(15);
  fill(0); // Black text
  text("Real-time data:", width/2 + 310, 120);
  text("Friction: " +friction, width/2 + 310, 140); // Display the friction coefficient for ball # 2
  text("Speed: " +nf(v2, 0, 2) + " px/frame", width/2 + 310, 160); // Display speed
  
  // Switch back to HSB mode for the balls' speed-gradient colours next frame
  colorMode(HSB, 255);
}
