// Modify the "Binary" program so that the threshold grey value
// (at which pixels become either black or white) can be adjusted interactively.

// NOTE:
// The image file used in this project ("mandrill-bin.png") is not included in the repository.
// If you wish to run this sketch, you may use any image of your choice.
// To do so, simply download or place your image in the same folder as this Processing file,
// and update the filename in the line where img1 is loaded:
//
// img1 = loadImage("your-image-name.png");
//
// Make sure the image file is located in the same directory as this sketch.

import controlP5.*; // The ControlP5 library must be imported via Processing's library manager (Sketch → Import Library) in order to use GUI elements such as sliders
ControlP5 cp5;

PImage img, img1, img2; // Main image variables: original, processed, and displayed image
boolean binary; // Toggles between original and binary image view
int threshold; // Current threshold value controlled by the slider
int lastThreshold; // Stores previous threshold value to detect changes

void setup() {
  size(512, 512); // Set the size of the display window
  
  cp5 = new ControlP5(this); // Initialise ControlP5 GUI system
   
  cp5.addSlider("threshold") // Create a slider to control the threshold value
    .setPosition((width/2), height-40) // Position of the slider in the window
    .setSize(200, 20) // Slider dimensions
    .setRange(0, 255) // Valid threshold range (0–255 for greyscale)
    .setValue(126); // Initial threshold value
  
  threshold = 126; // Set default threshold value
  
  // Load the input image
  img1 = loadImage("mandrill-bin.png");
  img1.loadPixels(); // Load pixel data from the original image
  
  // Create a blank image for the binary result
  img2 = createImage(img1.width, img1.height, RGB);
  img2.loadPixels();
  
  // Start by displaying the original image
  img = img1;
  binary = true;
}

void draw() {
   image(img, 0, 0);  // Display the currently selected image
   
  // Check whether the threshold has changed
  // If it has, recalculate the binary image
   if (lastThreshold != threshold){
     recalculateBinary();
     lastThreshold = threshold;
   }
}
  
void keyPressed(){
  if(key==' '){ // Pressing the space bar toggles between original and binary image
    binary = !binary;
      if(binary){ 
        img = img1; // Show original image
       }
       else{
        img=img2; // Show processed binary image
      }
  }
}

void recalculateBinary() {
  img2.loadPixels(); // Load pixel data of the output image before modifying it
  
  // Loop through every pixel in the image
  for(int j = 0; j<img1.height; j++){
  for(int y = 0; y<img1.width; y++){
    
    // Apply threshold to the red channel (grayscale assumption)
    if(red(img1.pixels[j*img1.width+y])>threshold){
      img2.pixels[j*img1.width+y]=color(255,255,255); // White pixel
    }
    else {
      img2.pixels[j*img1.width+y]=color(0,0,0); // Black pixel
    } 
   }
  }
  
  img2.updatePixels(); // Update the image with modified pixel data
}


// SOURCE CODE PROVIDED BY THE BOOK (original version)
// PImage img, img1, img2;
// boolean binario;
// int threshold;

// void setup() {
  // size(512, 512);
  // threshold = 126;
  // img1 = loadImage("mandrill-bin.png");
  // img1.loadPixels();
  // img2 = createImage(img1.width, img1.height, RGB);
  // img2.loadPixels();
  // for(int j = 0; j<img1.height; j++){
    // for(int y = 0; y<img1.width; y++){
      // if(red(img1.pixels[j*img1.width+y])>threshold){
        // img2.pixels[j*img1.width+y]=color(255,255,255);
      // }
      // else {
        // img2.pixels[j*img1.width+y]=color(0,0,0);
      // } 
     // }
  // }
  
 // img = img1;
 // binario = true;
// }

// void draw() {
   // image(img, 0, 0);
// }
  
  // void keyPressed(){
   // if(key==' '){
     // binario = !binario;
       // if(binario){ 
         // img = img1;
       // }
       // else{
         // img=img2;
       // }
   // }
// }
