import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;
ArrayList<Tile> tiles;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  rectMode(CENTER);
  smooth(8);
  cam = new PeasyCam(this, 800);
  noise = new OpenSimplexNoise();

  tiles = new ArrayList<Tile>();
  for (float x = -w; x <= w; x+=size) {
    for (float y= -w; y <= w; y+=size) {
      //square(x, y, size);
      tiles.add(new Tile(x, y, size));
    }
  }
}

float size = 10;
float w = 300;
float dt;
void draw() {
  background(0);
  dt+=0.025;
  

  for (Tile t : tiles) {
    t.display(dt);
  }
  
  //saveFrame("output/gif###.png");
}

class Tile {
  float xpos, ypos, off, rot, size;
  Tile(float x, float y, float s) {
    xpos = x; 
    ypos = y;
    size = s;
    off = random(-PI, PI);
    rot = random(1);
  }

  void display(float dt) {
    //fill(0);
    fill(255);
    push();
    translate(xpos, ypos);
    float n = (float)noise.eval(xpos*0.01, ypos*0.01);

    //strokeWeight(0.5);
    //if (rot >0.8) {
      rotateX(dt+off*n);
    //}
    box(size, size, n*50);
    //square(0, 0, size);
    pop();
  }
}
