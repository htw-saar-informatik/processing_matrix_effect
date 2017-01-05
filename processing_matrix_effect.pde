// Matrix movie effect
// Reimplementation and improvement (?) of Ji Zhang's version
// https://www.openprocessing.org/sketch/78626
// *********************************************
// Globale Variablen 
int anzahlSpalten; // Anzahl der Spalten, die pro draw() aktualisiert werden
int maxAnzahlSpalten; // max. Anzahl der Spalten, die pro draw() aktualisiert werden
int yPosition; // Aktuelle y-Position zur Zeichen-Darstellung
int initYPosition; // Initiale y-Position
int[] xPositionen; // Feld für zufällige initiale x-Positionen
int[] yOffset; // Feld für zufällige Verschiebungen der y-Position
// Farbe der Ingenieurwissenschaften der htw saar
color htw_ingwi = color(75, 180, 230); 
int fontSize = 10; 
 
// *********************************************
// Vorbereitung
void setup(){
  size(800, 600);
  frameRate(40);
  
  // Spalten maximal ca. auf Fensterbreite
  maxAnzahlSpalten = (int) width/fontSize;  
  
  // Außerhalb des Fensters wegen des Fade-Effekts
  initYPosition = -height/2; 
  yPosition = initYPosition;
 
  // Felder mit zufälligen x-Positionen und y-Verschiebungen befüllen 
  erzeugeZufaelligeXYWerte();
  
}

// *********************************************
void draw(){
  // Transparentes Rechteck in Fenstergröße
  // --> Fade-Effekt über mehrere Frames hinweg
  fill(0, 25.0f); // Je höher der Wert, desto weniger Fade-Effekt
  rect(0, 0, width, height);
 
  // Vordergrundfarbe + Schriftgröße
  fill(htw_ingwi);
  //fill(0,255,0); // GREEN
  //PFont font;
  //font = createFont("AnonymousPro-Regular", fontSize); // SourceCodePro-Bold  AnonymousPro-Regular
  //textFont(font);
  textSize(fontSize); 
 
  // Für jede Spalte ein zufälliges Zeichen ermitteln und an zufällig bestimmter Stelle anzeigen
  for (int i = 0; i < anzahlSpalten; i++) {
    char randomLetter = (char) random(33, 255); // http://www.asciitable.com/
    text(randomLetter, xPositionen[i], yPosition + yOffset[i]);
  }
  
  // In Buchstabengröße nach unten zum Fensterrand fortschreiten 
  yPosition = yPosition + fontSize; // ggf. noch mit vertikalem Abstand zwischen den Buchstaben (int) fontSize/1.2
  
  // Reset, falls das Ende des Fensters erreicht ist
  if (yPosition > height) { // Faktor > 1 --> außerhalb des Fensters, Schätzwert wegen Fade-Effekt
    yPosition = initYPosition; // Wieder oben außerhalb des Fensterrandes beginnen
    
    // Neue zufällige x-Positionen und y-Verschiebungen
    erzeugeZufaelligeXYWerte();
  }
  
  // Werbung ;-)
  zeigeWerbung();
  
 // Einzelne Bilder speichern; z.B., um eine Animation später daraus zu generieren
 //saveFrame("line-######.png");
  
}

// *********************************************
// Felder mit zufälligen x-Positionen und y-Verschiebungen befüllen 
void erzeugeZufaelligeXYWerte() {
 
 // Zufällige Anzahl von Spalten, die dargestellt werden 
 anzahlSpalten = (int) random(maxAnzahlSpalten/100,maxAnzahlSpalten);

 // Felder neu erstellen
 xPositionen = new int[anzahlSpalten];
 yOffset = new int[anzahlSpalten];
    
 // Befülle Felder zufällig 
 for (int i = 0; i < anzahlSpalten; i++) {
    xPositionen[i] = (int) random(width/fontSize)*fontSize;
    yOffset[i] = (int) random(initYPosition,height);
  }
  
}

// *********************************************
// "Werbeblock" 
void zeigeWerbung() {
  textSize(32); // Schriftgröße
  textAlign(CENTER, CENTER); // Ausrichtung des Textes
  if ( (frameCount%400) == 0 ) {
    text("KOMMUNIKATIONSINFORMATIK", width/2,height/2);
  }  else if( (frameCount%200) == 0 ) {
    text("PRAKTISCHE INFORMATIK", width/2,height/2);
  }
  
}