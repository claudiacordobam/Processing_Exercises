// Escriviu un programa en el qual apareguin diferents boles (unes 10) i que es
// moguin en paral·lel entre elles i amb l'horitzontal amb velocitats diferents.
// Quan les boles surtin per la pantalla per una banda apareixeran pel costat
// oposat
float x, vx;

void setup (){
  size(1200,720);
  
}

void draw () { 
  background(0);
  // Fem el càlcul de la velocitat
  vx = 2;
  x = x + vx;
  
  if (x >= width) {
    vx = 0;
    x = 0;
  }
  
  //Dibuixem els eixos horitzontals de cada elipse
  strokeWeight(1);
  stroke(255);
  line(0, height/2 - 250, width, height/2 - 250); 
  line(0, height/2 - 200, width, height/2 - 200); 
  line(0, height/2 - 150, width, height/2 - 150); 
  line(0, height/2 - 100, width, height/2 - 100); 
  line(0, height/2 - 50, width, height/2 - 50); 
  line(0, height/2, width, height/2); 
  line(0, height/2 + 50, width, height/2 + 50); 
  line(0, height/2 + 100, width, height/2 + 100); 
  line(0, height/2 + 150, width, height/2 + 150); 
  line(0, height/2 + 200, width, height/2 + 200); 
  
  // Dibuixem les elipses
  noStroke();
  fill(255, 184, 235);
  ellipse(x, height/2 -250, 20, 20);
  ellipse(x*2, height/2 -200, 20, 20);  
  ellipse(x*3, height/2 -150, 20, 20);
  ellipse(x*4, height/2 -100, 20, 20);
  ellipse(x*5, height/2 -50, 20, 20);
  ellipse(x*6, height/2, 20, 20);
  ellipse(x*7, height/2 +50, 20, 20);
  ellipse(x*8, height/2 +100, 20, 20);
  ellipse(x*9, height/2 +150, 20, 20);
  ellipse(x*10, height/2 +200, 20, 20);
}

