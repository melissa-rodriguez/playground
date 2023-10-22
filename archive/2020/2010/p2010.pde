PImage img;
PImage nike;

void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  img = loadImage("air.jpg");
  img.resize(1080, 1080);
}


float z = -150;
void draw() {
  background(240);
  fill(0);
  noStroke();
  imageMode(CENTER);
  sphereDetail(3);
  float tiles = 200;
  float tileSize = width/tiles;


  push();
  translate(width/2, height/2);

  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x*tileSize), int(y*tileSize));
      float b = map(brightness(c), 0, 255, 1, 0);
      z = map(b, 0, 1, -150, 150);
      z = tan(radians(frameCount))*z;


      push();
      translate(x*tileSize - width/2, y*tileSize - height/2, z);
      sphere(tileSize*b*0.8);
      pop();
    }
  }


  pop();



  //rec();
}
