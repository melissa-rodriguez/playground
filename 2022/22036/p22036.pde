
ArrayList<Hexagon> hexagons = new ArrayList<Hexagon>(); 
import peasy.*;
PeasyCam cam;


void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  colorMode(HSB); 


  //cam = new PeasyCam(this, 1000);

  float res = 5; 
  float size = width/(res*3); 
  float off = 0;
  float yoff = 0; 
  float jres = res/sin(radians(60)); // THIS CLOSES THE GAP BETWEEN ROWS
  for (int i = 0; i <= res; i++) {

    for (int j = 0; j <= jres+1; j++) {
      if (j % 2 == 0) {
        off = size*1.5;
      } else {
        off = 0;
      }

      float y = map(j, 0, jres, -height/2, height/2); 
      float x = map(i, 0, res, -width/2+off, width/2+off);



      PVector center = new PVector(x, y); 

      //float randPlace = random(1); 
      //if(randPlace > 0.2){

      //if (mag(center.x, center.y) < 400) {
      hexagons.add(new Hexagon(center, size));
      //}
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

  Triangle(PVector c, float s, float angle, int num) {
    size = s;
    a = angle;
    center = c; 
    triNum = num; //number of triangle in the hexagon (clockwise) from 1 - 6; 
    alpha = map(triNum, 1, 6, 20, 240); 


    strokeWeight(1.5);
    noFill();
    stroke(20); 
    //noStroke(); 

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

    float d = dist(center.x, center.y, 0, 0); 
    int numPoints = 20; 
    //fill(155, map(d, 0, width, 100, 255), 255, alpha); 

    if (triNum == 6) {
      for (int i =0; i <=numPoints; i++) {
        strokeWeight(1.5); 
        PVector lineV1 = v1; 
        PVector lineV2 = v3;
        PVector corner = v2; 
        float x1 = map(i, 0, numPoints, lineV1.x, lineV1.x+corner.x*2);
        float y1 = map(i, 0, numPoints, lineV1.y, corner.y); 
        fill(20); 
        circle(lineV1.x+x1, lineV1.y, 2); 
        line(lineV1.x+x1, lineV1.y, lineV2.x+x1, lineV2.y);
      }
    }else if (triNum ==2) {
      for (int i =0; i <=numPoints; i++) {
        strokeWeight(1.5); 
        PVector lineV1 = v1; 
        PVector lineV2 = v3;
        PVector corner = v2; 
        float x1 = map(i, 0, numPoints, lineV1.x, lineV1.x+corner.x*2);
        float y1 = map(i, 0, numPoints, lineV1.y, corner.y); 
        fill(20); 
        //circle(lineV1.x, lineV1.y+y1, 2); 
        
        line(lineV1.x+x1, lineV1.y+0, lineV2.x+x1, lineV2.y+0);

      }
    }

    v1 = new PVector(0, - size); 
    v2 = new PVector(0, - size).rotate(radians(120));
    v3 = new PVector(0, - size).rotate(radians(-120));

    //fill(alpha); 
    noStroke(); 
    noFill(); 
    //fill(240); 
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
