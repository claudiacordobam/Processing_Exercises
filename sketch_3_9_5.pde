// Escriviu un programa en el qual una bola es mogui seguint un moviment
// circular uniforme al voltant de la posició on
// es troba el ratolí en cada instant.
float x, y;
float r = 60; // Definim el radi de la circumferència que servirà com a recorregut
float t = 2; // Definim el període
float globalTime = 0;

void setup() {
  size(1200, 720);
}

void draw() {
  background(0);
  
  globalTime = globalTime + 0.02; // Per cada frame, globalTime augmenta en 0.02 increments per frame
  
  x = mouseX + r * cos(((2*PI)/t) * globalTime); // Definim la fórmula física de la coordenada X per un MCU
  y = mouseY + r * sin(((2*PI)/t) * globalTime); // Definim la fórmula física de la coordenada Y per un MCU
  
  fill(255, 223, 153); // Definim el color de l'elipse
  ellipse(x, y, 30, 30); // Dibuixem l'elipse amb centre en x, y  
}
