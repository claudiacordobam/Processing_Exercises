// Represent a string fixed at both ends where standing waves occur.
// This sketch visualises the first, second and third harmonics.
// It also highlights the nodes (points of no displacement) along the string.

// Variables
float L = 1200; // Physical length of the string
float A = 30; // Amplitude of the wave
int N; // Number of points used to discretise the string
float n; // Harmonic number (used later)
float t = 0; // Time variable for animation
float deltaT = 0.02; // Time increment per frame
float f = 1; // Base frequency of oscillation
float omega = 2 * PI * f; // Angular frequency

float[] x; // Array to store x-coordinates along the string
float[] y; // Array to store instantaneous y-coordinates            
float[] y_Screen; // Array to store y-coordinates mapped to the screen
float[] harmonics = {1, 2, 3}; // Array defining which harmonics to draw

void setup(){
  size(1200, 720);
  smooth(); // Enable anti-aliasing for smoother lines
  
  N = width; // Set number of points equal to canvas width
  x = new float[N];
  y = new float[N];
  
  // Calculate the spacing between points along the string
  float deltaX = L / (N-1);
  for (int i = 0; i < N; i++){
    x[i] = i * deltaX; // Assign each x-coordinate along the string
  }
}

void draw() {
  background(0);
  
  // Display the title at the top of the canvas
  fill(255);                  
  textAlign(CENTER, TOP);     
  textSize(24);               
  text("Standing waves - Harmonics", width/2, 15);
  
  t += deltaT; // Increment time for animation
  
  float total_harmonics = 3; // Total number of harmonics being drawn
  float space_between = height/total_harmonics; // Vertical spacing for visual separation
  
  // Loop over each harmonic to draw its wave
  for (int j = 0; j < harmonics.length; j++) {
    float current_n = harmonics [j]; // Current harmonic number
    
    // Vertical offset to centre each harmonic on the canvas
    float yOffset = (current_n - (1 + total_harmonics)/2) * space_between + height/2; 
    
    strokeWeight(3); // Set thickness of the wave line
    
    // Assign a unique colour to each harmonic
    color c;
    if (current_n == 1) c = color(255, 181, 245);
    else if (current_n == 2) c = color(227, 255, 181); 
    else c = color(181, 255, 254);
    stroke(c);
    noFill();
    
    // Draw the wave using vertex points
    beginShape();
    for (int i = 0; i < N; i++) {
      y[i] = A * sin(current_n * PI * x[i]/L) * cos(omega * t); // Standing wave formula
      vertex(x[i], y[i]  + yOffset); // Draw vertex at displaced y-position
    }
    endShape();
    
    // Draw nodes
    pushStyle(); // Save current style settings
    noStroke();
    fill(c);
    
    for (int k = 0; k <= current_n; k++){
      float node_x = k * L / current_n; // x-position of node along the string  
      float node_y = yOffset; // y-position of node (fixed)
      ellipse(node_x, node_y, 12, 12);  
    }
    popStyle(); // Restore previous style settings
    
    // Display harmonic label
    fill(c);
    textSize(15);   
    textAlign(LEFT, CENTER);
    text("Harmonic = " + int(current_n), 30, yOffset + 50);
  }
}
