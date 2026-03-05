// Escriviu un programa en el qual una bola es mogui seguint un moviment
// oscil·latori harmònic simple en la direcció vertical al voltant de la posició on
// es troba el ratolí en cada instant.
float y;
float a = 150; // Definim l'amplitud
float t = 2; // Definim el període  en increments per frame
float globalTime = 0; // Generem una variable de temps global i l'inicialitzem a 0

void setup() {
  size(1200, 720);
}

void draw() {
  background(0);
  
  globalTime = globalTime + 0.02; // Per cada frame, globalTime augmenta en 0.02 increments per frame
  
  y = mouseY + a * sin(((2*PI)/t) * globalTime); // Utilitzem la fórmula física del MHS amb mouseY com a y0
  
  fill (209, 255, 214); // Definim els colors de l'elipse
  ellipse (mouseX, y, 40, 40); // Generem l'elipse
}
