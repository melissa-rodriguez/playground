
ArrayList<Hexagon> hexagons = new ArrayList<Hexagon>(); 
import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise; 


void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  colorMode(HSB); 
  noise =  new OpenSimplexNoise(); 


  //cam = new PeasyCam(this, 1000);

  float res = 5; 
  float size = width/(res*3); 
  float off = 0;
  float jres = res; 
  for (int i = 0; i <= res; i++) {

    for (int j = 0; j <= jres; j++) {
      if (j % 2 == 0) {
        off = size*1.5;
      } else {
        off = 0;
      }

      float y = map(j, 0, jres, -height/2, height/2); 
      float x = map(i, 0, res, -width/2+off, width/2+off);



      PVector center = new PVector(x, y); 

      if (mag(center.x, center.y) < 400) {
      hexagons.add(new Hexagon(center, size));
      }
    }  
  }
}


void draw() {
  //clear();
  background(240); 
  //background(155, 255, 20); 

  translate(width/2, height/2, -100);
  //println(mouseX); 


  for (Hexagon hex : hexagons) {
    hex.renderHexagon();
  }
}

void mousePressed() {
  saveFrame("output###.png");
}

class Triangle { 
  PVector v1; 
  PVector v2; 
  PVector v3; 
  float size; 
  float a;
  float t; 
  PVector center; 
  int triNum;
  float alpha; //alpha of color

  Triangle(PVector c, float s, float angle, int num) {
    size = s;
    a = angle;
    center = c; 
    triNum = num; //number of triangle in the hexagon (clockwise) from 1 - 6; 
    alpha = map(triNum, 1, 6, 20, 240); 


    strokeWeight(1.5);
    //stroke(20); 


    //noFill();
  }

  void renderTriangle() {
    v1 = new PVector(0, - size); 
    v2 = new PVector(0, - size).rotate(radians(120));
    v3 = new PVector(0, - size).rotate(radians(-120));

    float d = dist(center.x, center.y, 0, 0); 

    push(); 
    rotate(radians(30)); //rotate the triangle so the point/peak faces down
    rotate(a); //rotate each triangle about the center point of the hexagon
    translate(0, size); 
    //rotate(radians(d)+sin(radians(mouseX))); 


    //if(triNum == 3 || triNum == 4 || triNum == 5){
    // fill(155, 200, 255); 
    //}else{
    //  fill(155, 200, 200); 
    //}


    stroke(155, 200, 100);
    strokeWeight(1); 
    //noFill(); 
    fill(155, 200, 255, alpha); 
    arc(v3.x, v3.y, size*4, size*4, 0, PI/3);

    fill(155, 200, 255, alpha); 
    noStroke(); 

    beginShape();
    vertex(v1.x, v1.y); 
    vertex(v2.x, v2.y); 
    vertex(v3.x, v3.y);
    endShape(CLOSE);
    pop();
  }
}



class Hexagon {
  ArrayList<Triangle> triangles = new ArrayList<Triangle>(); 
  float size; //size of each hexagon
  PVector center; 
  int triNum = 0; //number of triangle in the hexagon from 1-6; (clockwise)

  Hexagon(PVector c, float s) {
    size = s; 
    center = c; 

    for (int a = 0; a < 360; a+=60) {
      triNum++; 
      triangles.add(new Triangle(center, size, radians(a), triNum));
    }
  }

  void renderHexagon() {

    for (Triangle t : triangles) {
      push();
      translate(center.x, center.y); 
      t.renderTriangle();
      pop();
    }
  }
}
