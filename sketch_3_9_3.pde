// Elaboreu un programa en el qual en fer clic sobre la pantalla una bola descrigui
// una trajectòria compatible amb el tir parabòlic. Utilitzeu valors de la
// velocitat inicial, l'angle d'aquesta velocitat amb l'horitzontal i l'acceleració de
// la gravetat que permetin una visualització còmoda del moviment.
float x, vx, y, vy, v;
float temps = 0.25; // Assignem una variable de temps real
float angle = radians(45); // Assignem HALF_PI a angle
float g = 9.8; // Declarem la variable de la gravetat
boolean moviment = false;
ArrayList<PVector> trajectoria; // Generem una nova array per desar punts del vector anomenada "trajectoria"

void setup() {
  size(1200,720);
  noStroke();
  x = 50;
  y = height - 100;
  trajectoria = new ArrayList<PVector>(); // Inicialitzem l'array
}

void draw() {
  background(0);
  
  fill (212, 255, 247); // Definim els colors dels punts que marcaran la trajectòria
  trajectoria.add(new PVector(x, y)); // Per cada nova posició d'x i y, es crea un nou punt a la llista
    
  for (PVector p : trajectoria) { // Aquest for loop recorre la llista i dibuixa un punt per cada posició desada
    ellipse(p.x, p.y, 5, 5);
  }
  
  fill (255, 184, 235); // Definim els colors de l'elipse
  ellipse(x, y, 60, 60); // Dibuixem l'elipse
  
  if (moviment) {
    x = x + vx * temps; // Multiplicant-ho per temps, aconseguim que l'animació no vagi tan ràpida (ja que draw() s'executa 60 vegades per segon)
    y = y + vy * temps; // Multiplicant-ho per temps, aconseguim que l'animació no vagi tan ràpida (ja que draw() s'executa 60 vegades per segon)
    vy = vy + g * temps; // Multiplicant-ho per temps, aconseguim que l'animació no vagi tan ràpida (ja que draw() s'executa 60 vegades per segon)
  

    
    if (y >= height - 100){ //Quan la bola torna a la mateixa alçada que a l'inici, es deté el moviment
    moviment = false;
    vy = 0;
    }
  }
}

void mouseClicked() {
  moviment = true;
  v = 100; // Assignem una velocitat inicial
  vy = -(v * sin(angle)); // Fem que el resultat de multiplicar la velocitat inicial pel sinus de l'angle sigui negatiu (per la manera en què funcionen les coordenades en Processing)
  vx = v * cos(angle); // La velocitat horitzontal és el resultat de multiplicar la velocitat inicial pel cosinus de l'angle de la paràbola
  x = 50; // Tornem a definir els valors d'x i y com estan a void setup() per tal que quan l'usuari cliqui es faci un reinici de l'animació
  y = height - 100;
  trajectoria.clear(); // Esborrem la trajectòria anterior per tal que desaparegui abans de començar el nou tir
}
