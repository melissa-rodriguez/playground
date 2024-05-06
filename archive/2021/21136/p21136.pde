import peasy.*;
PeasyCam cam;
Tile tile;
OpenSimplexNoise noise;
PImage img;
ArrayList<Tile> tiles;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 650);
  sphereDetail(5);
  noise = new OpenSimplexNoise();
  img = loadImage("img2.jpg");
  img.resize(1080, 1080);

  tiles = new ArrayList<Tile>();
  for (int i = 0; i < n1; i++) {
    for (int j = 0; j < n2; j++) {
      float x = map(i, 0, n1, -w, w);
      float z = map(j, 0, n2, -d, d);
      //push();
      //translate(x, -100, z);
      //box(10);
      //pop();
      tiles.add(new Tile(x, -100, z, PI/2));
      tiles.add(new Tile(x, 100, z, -PI/2));
    }
  }
  rectMode(CENTER);
  smooth(8);
}

float n1 = 7; //num of x tiles
float n2 = 35; //num of z tiles
float w = 100;
float d = 500;
float dt;
void draw() {
  background(0);
  background(img);
  //lights();
  //circle(0,0,200);
  //tile.display();
  translate(16, 0, 0);

  dt+=0.03;
  for (Tile t : tiles) {
    t.display(); 
    t.showDot(dt);

  }
  
  //saveFrame("output/gif###.png");
}

class Tile {
  float xpos, ypos, zpos, size, rot, off;
  float show;
  float starSize;
  Tile(float x, float y, float z, float rotate) {
    xpos = x; 
    ypos = y;
    zpos = z;
    size = 29;
    rot = rotate;
    off = random(-PI, PI);
    show = (random(0, 1));
    starSize = random(2, 10);
  }

  void display() {
    //size = mouseX;
    //println(mouseX);
    fill(map(zpos, 0, d/3, 0, 255));
    push();
    translate(xpos, ypos, zpos);
    rotateX(-rot);
    strokeWeight(2);
    box(size, size, size/5);

    push();
    translate(0, 0, size/10+1);
    fill(0);
    noStroke();
    //stroke(255);
    circle(0, 0, size/1.5);
    pop();

    pop();
  }

  void showDot(float dt) {
    if (rot == -PI/2 && show > 0.6) {
      push();
      translate(xpos, (ypos+10)*(sin(dt+off)), zpos);
      //noStroke();
      //stroke(255);
      
      rotate((sin(dt+off)));
      sphere(5);
      //strokeWeight(10);
      //stroke(255);
      //point(0, 0, 0);

      pop();
    }
  }

}
