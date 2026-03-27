// Simulate the explosion of a grenade that breaks 
// into several pieces in the following cases:
// a) The grenade is at rest.
// b) The grenade is moving with constant speed.

import java.util.ArrayList; // Import the ArrayList class for storing fragments

// Declare two Grenade objects: one at rest and one moving
Grenade stillGrenade;
Grenade movingGrenade;

void setup() {
  size(1200, 720); // Set the window size
  
  // Initialise grenades:
  // stillGrenade: positioned at (300, 360) and stationary (velocity 0)
  // movingGrenade: positioned at (900, 1) and moving downwards at speed 5
  stillGrenade = new Grenade(300, 360, 0);
  movingGrenade = new Grenade(900, 1, 5);
}

void draw() {
  background(0); // Clear the background with black
  
  // Draw the vertical dividing line between the two simulations
  stroke(255);
  line(width/2, 0, width/2, height);
  
  // Draw the text labels for each half
  fill(255);               
  textSize(20);            
  textAlign(CENTER, CENTER);
  
  // Label for the grenade at rest (left half)
  text("Grenade exploding at rest", width/4, height - 30);
  
  // Label for the moving grenade (right half)
  text("Grenade exploding in motion", 3 * width/4, height - 30);

  // Update and display the grenades
  stillGrenade.update();
  stillGrenade.display();
  
  movingGrenade.update();
  movingGrenade.display();
  
  // Determine when to trigger the explosions:
  // If the vertical positions are very close (threshold = 5 pixels)
  float threshold = 5;
  
  if (abs(stillGrenade.y - movingGrenade.y) < threshold) {
    stillGrenade.explode();
    movingGrenade.explode();
  }
  
  // If both grenades have finished their explosions (all fragments disappeared), reset them
  if (stillGrenade.isFinished() && movingGrenade.isFinished()) {
    stillGrenade.reset(300, 360, 0);
    movingGrenade.reset(900, 1, 5);
  }
}

// Grenade class
class Grenade {
  float x, y; // Position of the grenade
  PVector velocity; // Velocity vector (x, y)
  boolean exploded; // Flag to indicate if the grenade has exploded
  ArrayList<Fragment> fragments; // List of fragments produced upon explosion
  
  // Constructor
  Grenade (float posx, float posy, float vel){
  x = posx;
  y = posy;
  velocity = new PVector(0, vel); // Only vertical movement for simplicity
  exploded = false; // Not exploded initially
  fragments = new ArrayList<Fragment>(); // Initialise empty list
  }
  
  // Update the grenade or its fragments
  void update(){
    if (!exploded){
      // If not exploded, move the grenade according to its velocity
      x += velocity.x;
      y += velocity.y;
    }
    else {
      // If exploded, update all fragments
      // IMPORTANT CHANGE: iterate backwards to safely remove fragments while looping
      // If we looped forwards, removing items shifts the indexes and could skip fragments
      for (int i = fragments.size() - 1; i >= 0; i--) {
        Fragment f = fragments.get(i);
        f.update(); // Update fragment position and lifespan
        if (f.lifespan <= 0) {
          fragments.remove(i); // Remove fragment if it has disappeared
        }
      }
     }
  }
  
  // Trigger explosion
  void explode(){
    if(!exploded) {
      fragments = new ArrayList<Fragment>(); // Ensure fragments list is empty
      
      // Generate 50 fragments
      for (int i = 0; i < 50; i++) {
        PVector dir = PVector.random2D().mult(random(2,5)); // Random direction and speed
        dir.add(velocity); // Add grenade's velocity to fragments for realistic movement
        Fragment f = new Fragment(x, y, dir, 255, 10, color(255, 0, 0), x);
        fragments.add(f); // Add fragment to the list
      }
      exploded = true; // Mark grenade as exploded
    }
  }
  
  // Display grenade or its fragments
  void display(){
    if (exploded == false) {
      // Draw the grenade itself (ellipse)
      noStroke();
      fill(179, 255, 181);
      ellipse (x, y, 30, 30);
    }
    
    else {
      // Draw all fragments
      for (int i = 0; i < fragments.size(); i++) {
        Fragment f = fragments.get(i);
        
        // Only draw fragments within their original half of the screen 
        if ((f.originX < width/2 && f.x < width/2) || (f.originX > width/2 && f.x > width/2)) {
          f.display();
        }
      }
    }
   } 
   
   // Check if all fragments are gone (grenade has finished exploding)
   boolean isFinished() {
    if (!exploded) return false;

    return fragments.isEmpty();
   }
   
   // Reset grenade for looping animation
   void reset(float posx, float posy, float vel) {
    x = posx;
    y = posy;
    velocity = new PVector(0, vel);
    exploded = false;
    fragments = new ArrayList<Fragment>(); 
  }
}

// Fragment class
class Fragment {
  float x, y; // Position of fragment
  PVector velocity; // Velocity vector
  float lifespan; // Time left before fragment disappears
  float size; // Diameter of fragment
  color colour; // Colour of fragment
  float originX; // Original X position of grenade, used for limiting to screen half
  
  // Constructor
  Fragment (float posx, float posy, PVector vel, float ls, float sz, color c, float originX_) {
    x = posx;
    y = posy;
    velocity = vel;
    lifespan = ls;
    size = sz;
    colour = c;
    originX = originX_;
  }
  
  // Update fragment position and lifespan
  void update(){
    x += velocity.x;
    y += velocity.y;
    lifespan -= 2; // Decrease lifespan gradually
  }
  
  // Display fragment as a coloured ellipse
  void display() {
    noStroke();
    fill(colour, lifespan); // Use alpha to fade out
    ellipse(x, y, size, size);  
  }
}
