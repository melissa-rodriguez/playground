import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 1700);
  sphereDetail(5);
}

float p, i, t, k = 1;
float radius = 200;
int count = 0;
void draw() {
  background(0);

  t+=0.005;
  noStroke();

  float numPoints = 2;
  float r = 175;

  for (i = 0; i<k; i++) {
    p = (i+t)/k; 
    for (float theta = 0; theta<=TAU; theta+=TAU/numPoints) {
      push();
      float x = r*cos(theta);
      float y = r*sin(theta);
      rotateX(cos(theta));

      translate(x, 0, y);
      if(x>=175){
       fill(0);
       stroke(255);
      }
      else{
       fill(255);
       stroke(0);
      }
      rotateY((theta+p));

      drawTorus();

      pop();
    }
  }

  //if(t>1){
  // t=0; 
  //}
  
  //if(frameCount<=32){
  // saveFrame("output/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
  
 
  //println(mouseX);
}

void drawTorus() {
  float numPoints = 60;
  float numPoints2 = 40;
  //noStroke();
  for (float a = 0; a < TAU; a += TAU/numPoints) {
    float xpos = radius*sin(a+p*2);
    float zpos = radius*cos(a+p*2);
    //fill(255*map(tan(TAU*t-mag(xpos,xpos)*0.04), -1, 1, 0.3, 1));
    for (float phi = 0; phi<TAU; phi+= TAU/numPoints2) {
      push();
      rotate(PI/2);
      rotateX(phi);
      
      translate(xpos, 0, zpos+radius*2);
      box(30);
      pop();
    }
  }
}
