int ires = 100;
int len = 150; 
float theta; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8); 
  rectMode(CORNER);
  colorMode(HSB);

  background(240);
}

void draw() {
  background(155, 100, 255); 
  noFill();
  strokeWeight(3); 
  noStroke(); 

  gradientLine(width/2-300, height/2, -PI/2); 
  gradientLine(width/2, height/2, PI/2);
  gradientLine(width/2+300, height/2, -PI/2);
  //gradientLine(width/2-100, height/2+150, -PI/3); 


  //if (theta < TAU) {
  //  theta+=radians(0.5);
  //}
}

void gradientLine(float x, float y, float a) {
  push();
  translate(x, y); 
  rotate(a); 
  //rotate(PI/2);

  float size = len/ires;
  float numLines = 5000; 

  for (theta = 0; theta<TAU; theta+=TAU/numLines) {
    push(); 
    rotate(theta); 
    beginShape();
    for (int i = 0; i < ires; i++) {
      PVector v1 = pt(i); 
      PVector v2 = pt(i+1);

      stroke(155, map(theta, 0, TAU+PI/2, 155, 0), 255, map(v2.x, 0, len, 255, 0));
      fill(155, map(theta, 0, TAU+PI/2, 155, 0), 255, map(v2.x, 0, len, 255, 50));
      vertex(v1.x, v1.y);
      vertex(v2.x, v2.y);
      //square(v1.x, v1.y, size);
    }
    endShape(); 
    pop();
  }
  pop(); 
}

PVector pt(int i) {
  float x = map(i, 0, ires, 0, len); 
  float y = 0; 

  return new PVector(x, y);
}

void mousePressed() {
  saveFrame("output###.png");
}
