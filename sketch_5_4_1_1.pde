// Represent the motion of a wave that propagates 
// according to the following function:
// y(t)=3sin(2*pi*t + ϕ)

// Global variables
float t = 0; // t = time, which increases at each frame to animate the wave
float amplitude = 150; // Wave's amplitude in pixels (already scaled for visibility)
float phase = 0; // Initial phase of the wave
float speed = 0.02; // Amount by which time increases each frame (controls animation speed)

void setup() {
  size (1200, 720); 
}

void draw() {
  background(0);
  
  // Draw the propagating wave
  stroke(255);
  noFill(); // Only draw the outline
  beginShape(); // Start a custom shape (continuous line)
  for(int x = 0; x < width; x++) { // Loop across all horizontal pixels
      float y = amplitude * sin(0.02 * x + 2 * PI * t + phase);
      // Compute the vertical position of the wave at this x
        // 0.02 * x controls the wavelength (spatial frequency)
        // 2*PI*t makes the wave move over time
        // phase shifts the wave horizontally if needed
      
      y = height/2 + y; // Center the wave vertically on the screen
      
      vertex(x, y); // Add this point to the shape
  }
  endShape(); // Finish drawing the continuous wave

  // Draw the point representing y(t) only (as per the assignment)
  float y_point = height/2 + amplitude * sin(2 * PI * t + phase); // Compute y at this time
  fill(255, 0, 0);
  noStroke(); 
  ellipse(width/2, y_point, 20, 20); // Draw the point at center horizontally
  
  // Draw a vertical line from the point to the center for clarity
  stroke(255, 0, 0);       
  line(width/2, y_point, width/2, height/2);

  // Update time
  t += speed; // Increment time to animate the wave
}
