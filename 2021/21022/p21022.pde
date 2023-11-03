// Code based on rasterization-tutorial 
// https://timrodenbroeker.de/rasterize
// Enjoy! :-)
// Tim Rodenbröker 
// 2019 

PImage img; 
PImage back;
ArrayList<Vehicle> vehicles = new ArrayList<Vehicle>();
OpenSimplexNoise noise;

float tiles;
float tileSize;
float fc = 0;

void setup() {
  size(1080, 1080, P2D);
  pixelDensity(2);

  img = loadImage("statuehead.png");
  img.resize(1080, 1080);

  noise = new OpenSimplexNoise();
  //translate(width/2, height/2);
  rasterize();
}

void rasterize() {
  noStroke();
  tiles = width/8;
  //tiles = width;
  tileSize = width/tiles;
  translate(tileSize/2, tileSize/2);
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x*tileSize), int(y*tileSize));
      float size = map(brightness(c), 0, 255, 0, tileSize);   
      //fill(c);
      //println(size);
      //ellipse(x*tileSize, y*tileSize, size, size);
      vehicles.add(new Vehicle(x*tileSize, y*tileSize, size, red(c), green(c), blue(c)));
    }
  }
}

void draw() {
  background(0);
  translate(tileSize/2, tileSize/2);

  //rasterize();
  for (Vehicle v : vehicles) {  
    v.behaviors();
    v.update();
    v.display();
  }

  //for (int i = 0; i<vehicles.size(); i++) {
  //  if (mousePressed) {
  //    PVector wind = new PVector(random(-5,5), 0);
  //    vehicles.get(i).applyForce(wind);
  //  }
  //}
  
  //if(frameCount > 50){
  ////fc += 1;
  //println("start recording");
  //saveFrame("slice3/gif-###.png");
  //}

  //rec();
}
