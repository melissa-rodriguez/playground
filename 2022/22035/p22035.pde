
ArrayList<Hexagon> hexagons = new ArrayList<Hexagon>(); 
import peasy.*;
PeasyCam cam;

OpenSimplexNoise noise; 


void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  colorMode(HSB); 

  noise = new OpenSimplexNoise(); 


  //cam = new PeasyCam(this, 1000);

  float res = 25; 
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

  int randNum; 
  float randScale;

  Triangle(PVector c, float s, float angle, int num) {
    size = s;
    a = angle;
    center = c; 
    triNum = num; //number of triangle in the hexagon (clockwise) from 1 - 6; 
    alpha = map(triNum, 1, 6, 20, 240); 


    randScale = random(0.003, 0.1); 
    randNum = int(map((float)noise.eval(center.x*0.008, center.y*0.008), -1, 1, 1, 4));  


    strokeWeight(1.5);
    noFill();
    stroke(0); 
    //noStroke(); 

    //noFill();
  }

  void renderTriangle() {
    v1 = new PVector(0, - size); //vertex 1
    v2 = new PVector(0, - size).rotate(radians(120)); //vertex 2
    v3 = new PVector(0, - size).rotate(radians(-120)); //vertex 3

    push(); 
    rotate(radians(30)); //rotate the triangle so the point/peak faces down
    rotate(a); //rotate each triangle about the center point of the hexagon
    translate(0, size); 
    //rotate(radians(mouseX)); 

    float d = dist(center.x, center.y, 0, 0);
    //if (d < 400) {
    //fill(155, map(d, 0, width, 100, 255), 255, alpha);
    //}

    PVector midPoint12 = new PVector((v1.x + v2.x)/2, (v1.y + v2.y)/2);  //midpoints b/w v1 and v2
    PVector midPoint23 = new PVector((v2.x + v3.x)/2, (v2.y + v3.y)/2);  //midpoints b/w v2 and v3
    PVector midPoint31 = new PVector((v3.x + v1.x)/2, (v3.y + v1.y)/2);  //midpoints b/w v3 and v1
    float triangleHeight = size*sin(radians(60)); 
    PVector centerTriangle = new PVector(midPoint23.x, midPoint23.y-size*sin(radians(60))/1.5);

    //circle(midPoint1.x, midPoint1.y, size/5);
    //circle(midPoint23.x-mouseX, midPoint23.y-triangleHeight/1.5, size/5);  
    //if (randNum == 3) {
    //  line(midPoint12.x, midPoint12.y, midPoint23.x, midPoint23.y);
    //} else if (randNum ==2) {
    //  line(midPoint23.x, midPoint23.y, midPoint31.x, midPoint31.y);
    //} else { 
    //  line(midPoint31.x, midPoint31.y, midPoint12.x, midPoint12.y);
    //} 


    if (randNum == 3) {
      stroke(70, 255, 50); 
      arc(midPoint12.x, midPoint12.y, size, size, -PI/2, PI/2);
    } else if (randNum ==2) {
      stroke(70, 255, 100); 
      arc(midPoint23.x, midPoint23.y, size, size,  PI/2, -PI);
    } else { 
      stroke(100); 
      arc(midPoint31.x, midPoint31.y, size, size, PI/2, PI);
    } 
    //arc(midPoint12.x, midPoint12.y, size, size, PI/2, PI/2+PI);

    //arc(midPoint12.x, midPoint12.y, size, size, 0, PI);
    //arc(midPoint23.x, midPoint23.y, size, size, 0, PI);
    //arc(midPoint12.x, midPoint12.y, mouseX, mouseX, PI, PI+PI);
    //arc(midPoint12.x, midPoint12.y, size, size, PI/2, PI/2+PI);




    //circle(midPoint3.x, midPoint3.y, size/5);



    //beginShape();
    //vertex(v1.x, v1.y); 
    //vertex(v2.x, v2.y); 
    //vertex(v3.x, v3.y);
    //endShape(CLOSE);

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
