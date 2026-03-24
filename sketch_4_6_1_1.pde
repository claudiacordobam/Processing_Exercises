// Represent the motion of an object sliding down an inclined plane.
// Vary the angle of inclination of the plane and observe what happens to the acceleration.

// VARIABLE DEFINITIONS
// Scalar (float) variables
float speed, accel, planeAngle, dist;
// speed: current velocity of the object (in pixels/frame)
// accel: acceleration along the plane (pixels/frame²)
// planeAngle: inclination angle in degrees
// dist: distance travelled along the plane

float gravity = 9.8;
// Gravity constant (used as a proportional factor, not real m/s²)

float L, x0, y0, x1, y1;
// L: length of the inclined plane
// (x0, y0): left/top point of the plane (moves when angle changes)
// (x1, y1): right/bottom point of the plane (fixed "ground")

// Vector definitions
PVector pos, direction, movement;
// pos: current position of the object
// direction: unit vector along the plane
// movement: displacement vector (not strictly needed with dist approach)


void setup() {
  size(1200,720);
  
  // Fix the right end of the plane (the "ground")
  x1 = 700;
  y1 = 500;
  
  // Length of the plane
  L = 600;
  
  // Initialise vectors
  pos = new PVector(x0, y0); // initial position (will be updated in draw)
  movement = new PVector();
  
  // Initial conditions
  speed = 0; // Object starts from rest
  planeAngle = 30; // Initial angle in degrees

}

void draw() {
  background(0);
  
  // Limit the angle between 0° and 90°
  planeAngle = constrain(planeAngle, 0, 90);
  
  // Convert angle to radians (required for sin/cos)
  float radPlaneAngle = radians(planeAngle);
  
  // Compute the left/top point of the plane
  // The right point (x1, y1) stays fixed
  // The left point rotates around it
  x0 = x1 - L * cos(radPlaneAngle);
  y0 = y1 - L * sin(radPlaneAngle);
  
  // Draw the inclined plane
  stroke(255);
  line(x0, y0, x1, y1);
  
  // PHYSICS CALCULATION
  // Acceleration along the plane: a = g * sin(theta)
  accel = gravity * sin(radPlaneAngle);
  
  // Update the speed (speed = speed + acceleration)
  speed += accel * 0.1; // 0.1 is a scaling factor to slow down the simulation
  
  // Update distance travelled along the plane
  dist += speed;
  
  // POSITION CALCULATION
  // Direction vector from top (x0,y0) to bottom (x1,y1)
  direction = new PVector(x1 - x0, y1 - y0);
  direction.normalize(); // Normalize to get a unit vector (length = 1)
  
  // Movement vector (not strictly necessary here, but illustrative)
  movement = direction.copy().mult(speed);

  // Compute position based on distance along the plane
  // This ensures the object always stays on the plane
  pos = direction.copy(); // Start from direction
  pos.mult(dist); // Scale by distance travelled
  pos.add(x0, y0); // Shift to the plane's starting point
  
  // DRAW THE OBJECT
  noStroke();
  fill(255, 210, 189);
  ellipse(pos.x, pos.y, 30, 30);

  // Reset when object reaches the end of the plane
  if (dist > L) {
    dist = 0;
    speed = 0;
  }
  
  // USER INSTRUCTIONS UI
  noStroke();
  rectMode(CENTER);
  fill(213, 255, 189);
  rect(width/2, 600, 350, 70);
  
  textAlign(CENTER, CENTER);
  textSize(20);
  fill(0);
  text("Press UP or DOWN to vary the angle", width/2, 600);
  
  // REAL-TIME DATA DISPLAY
  rectMode(CORNER);
  fill(189, 254, 255);
  rect(900, 100, 200, 100); 
  
  textAlign(LEFT, TOP);
  textSize(15);
  fill(0);
  text("Real-time data:", 910, 110);
  text("Angle: " +int(planeAngle)+ " degrees", 910, 130); // Display angle (no decimals)
  text("Speed: " +nf(speed, 0, 3) + " px/frame", 910, 150); // Display speed with 3 decimal places
  text("Acceleration: " +nf(accel, 0, 3) + " px/frame²", 910, 170); // Display acceleration with 3 decimal places
}

// KEYBOARD INPUT
void keyPressed() {
  if (keyCode == UP) {
    planeAngle += 1; // Increase angle
  } else if (keyCode == DOWN) {
    planeAngle -= 1; // Decrease angle
  }
}
