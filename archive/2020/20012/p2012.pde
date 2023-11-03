//void setup(){
//  size(1080, 1080, P2D);
//}

//void draw(){
// background(240); 
//}

// Code based on my rasterization-tutorial 
// https://timrodenbroeker.de/rasterize
// Enjoy! :-)
// Tim Rodenbröker 
// 2019 

PImage img; 
PFont font;

void setup() {
  size(1080, 1080);
  img = loadImage("venus.jpg");
  img.resize(1080, 1080);
  font = createFont("Mono.ttf", 400);
  textFont(font);
}

float yoff = 0.0;
void draw() {
  background(255);
  fill(0);
  noStroke();
  float tiles = width;
  float tileSize = width/tiles;
  translate(tileSize/2,tileSize/2);
  
  float xoff = 0;
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x*tileSize),int(y*tileSize));
      float size = map(brightness(c),0,255,tileSize,0); 
      float ydef = map(noise(xoff, yoff), 0, 1, 200, 300);
      //if(size > .6){
      // println(size); 
      // size
      // ellipse(x*tileSize, y*tileSize, size, size);
      //}
       //int wave = int(sin(frameCount*0.05+(x*y)*0.07)*100);
       int wave = int(sin(frameCount+(x*y))*2);
       ellipse((x*tileSize)+wave*2, (y*tileSize)-wave*2, size, size);
       xoff+= 0.05;
      
    }
  }
  yoff+= 0.01;
  
  pushMatrix();
  textAlign(CENTER, CENTER);
  textSize(400);
  text("ART", width/2, height/2);
  popMatrix();
}
