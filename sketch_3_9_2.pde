// Escriviu un programa en el qual l'usuari cliqui sobre la pantalla per crear una
// bola que descrigui un moviment amb acceleració constant en vertical i cap
// amunt. La bola començarà el seu moviment de repòs.
float y, vy, vyscreen; // Declarem les variables de posició vertical, velocitat vertical i velocitat que es mostrarà en pantalla
float a = -0.08; // Declarem la variable d'acceleració
boolean moviment = false; // Generem un boolean tipus false per iniciar el moviment quan sigui true
float startTime, currentTime, totalTime; // Generem les variables de temps per calcular-lo

void setup() {
  size(1200,720);
  noStroke();
}

void draw() {
  background(0);
  fill (255, 184, 235);

  if (moviment) { // El moviment == true quan l'usuari fa click al ratolí
    ellipse(width/2, y, 40, 40); // Es dibuixa l'elipse
    // Fem els càlculs de posició i velocitat
    vy = vy + a;
    y = y + vy;
    currentTime = millis();
    totalTime = currentTime - startTime; // El temps total és la diferència entre el temps actual i el temps d'inici
    if (y <= 0) { // En el moment en què la bola toca la part superior de la finestra de treball, rebota
      vy = -vy;
    }
  }
   
  vyscreen = abs(vy); // Transformem en absolut (sense negatius) la velocitat vertical i li assignem a vyscreen
  
  //Creem el rectangle amb les dades que dibuixarem en text
  fill(255, 235, 251);
  rect(50, 50, 300, 125);
  fill (0);
  textSize (15);
  text("Dades:", 120, 70);
  text("La velocitat és " + nf(vyscreen, 0, 3), 120, 100); // Utilitzem nf() per arrodonir els decimals de vyscreen
  text("L'acceleració és " +a, 120, 130);
  text("El temps transcorregut és " +totalTime/1000, 120, 160);
}

void mouseClicked() { // Codi que s'executa quan l'usuari fa click al ratolí
  moviment = true; // Moviment passa a ser true
  vy = 0; // La velocitat inicial és 0
  y = height - 50; // La posició y inicial és igual a l'alçada de la finestra de treball - 50 píxels
  startTime=millis();
}
