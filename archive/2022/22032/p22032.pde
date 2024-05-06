
ArrayList<Hexagon> hexagons = new ArrayList<Hexagon>(); 
OpenSimplexNoise noise; 

import peasy.*;
PeasyCam cam;


void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  colorMode(HSB); 
  noise = new OpenSimplexNoise(); 


  //cam = new PeasyCam(this, 1000);

  float res =150; 
  float size = width/(res*3); 
  float off = 0;
  float yoff = 0; 
  for (int i = 0; i <= res; i++) {

    for (int j = 0; j <= res; j++) {
      if (j % 2 == 0) {
        off = size*1.5;
      } else {
        off = 0;
      }

      float y = map(j, 0, res, -height/2, height/2); 
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

  translate(width/2, height/2);
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
  
  int randFill; 
  boolean fillHex;

  Triangle(PVector c, float s, float angle, int num) {
    size = s;
    a = angle;
    center = c; 
    triNum = num; //number of triangle in the hexagon (clockwise) from 1 - 6; 
    alpha = map(triNum, 1, 6, 20, 240); 
    
    
    randFill = int(map((float)noise.eval(center.x*0.008, center.y*0.008), -1, 1, 1, 6));  


    strokeWeight(1.5);
    //stroke(20); 
    noStroke(); 

    //noFill();
  }

  void renderTriangle() {
    v1 = new PVector(0, - size); 
    v2 = new PVector(0, - size).rotate(radians(120));
    v3 = new PVector(0, - size).rotate(radians(-120));

    push(); 
    rotate(radians(30)); //rotate the triangle so the point/peak faces down
    rotate(a); //rotate each triangle about the center point of the hexagon
    translate(0, size); 
    //rotate(radians(mouseX)); 

    //if(fillHex){
    //fill(155, 200, 255, alpha); 
    //}else{noFill();}
    
    if(randFill == triNum){
     fill(80, 200, 100);  
    }else{fill(80, 200, 100, alpha);}; 


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
  float randFill; //randomly decide which hexagons to fill

  Hexagon(PVector c, float s) {
    size = s; 
    center = c; 

    for (int a = 0; a < 360; a+=60) {
      triNum++; 
      //randFill = int(map((float)noise.eval(center.x*0.008, center.y*0.008), -1, 1, 0, random(1,6)));
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
