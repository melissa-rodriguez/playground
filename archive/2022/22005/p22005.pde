void setup() {
  size(1080, 1080, P2D);
  pixelDensity(2);
  //colorMode(HSB); 
  background(240);
}

float a, r;
int count = 0; 
void draw() {
  //background(240); 
  translate(width/2, height/2); 
  noStroke();

  if (a > TAU) {
    a = 0; 
    count++;
  }
  println(count); 
  //stroke(#C33E16); 

  r = 10; 
  int numRings = int(150/r); 

  for (int i = 0; i < numRings; i++) {
    float x = (300-(r+5)*i)*cos(a); 
    float y = (300-(r+5)*i)*sin(a); 




    fill(#F7926C);
    strokeWeight(2); 
    square(x-r/2, y, r); 

    fill(#C33E16); 
    //stroke(#F7926C);
    strokeWeight(2); 
    square(x+r/2, y, r);
  }
  a+=radians(0.1);
  
  
}

void mousePressed(){
 saveFrame("render.png");  
}
