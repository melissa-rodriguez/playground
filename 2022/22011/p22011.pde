import peasy.*;
PeasyCam cam;

float scale = 20;

float r1 = 20; //big ring
float r2 = 10; //big ring 

PVector surface(float theta, float phi, float r1, float r2) {
  //float x = scale*(r1+r2*cos(theta+t/4))*cos(phi+t);
  //float y = scale*(r1+r2*cos(theta+t/4))*sin(phi+t);
  //float z = scale*r2*sin(theta+t/4);

  float x = scale*(r1+r2*(cos(theta+t)))*(cos(phi));
  float y = scale*(r1+r2*(cos(theta+t)))*(sin(phi));
  float z = scale*r2*(sin(theta+t));

  return new PVector(x, y, z);
}

void draw_surface(float r1, float r2, int n1, int n2, String dir) {
  String direction = dir;

  stroke(255); // white lines
  fill(0); // black fill
  strokeWeight(5);
  //noStroke();


  for (int i = 0; i < n1; i++) {
    beginShape(TRIANGLE_STRIP);

    for (int j = 0; j < n2+1; j++) {
      float theta1 = map(i, 0, n1, 0, 2*PI);
      float theta2 = map(i+1, 0, n1, 0, 2*PI);

      float phi = map(j, 0, n2, theta1, (theta2));

      PVector v1 = surface(theta1, phi, r1, r2);
      PVector v2 = surface(theta2, phi, r1, r2);

      float u = map(i, 0, i+1, 0, 1);
      float v = map(j, 0, j+1, 0, 1);
      float v_2 = map(j+1, 0, j+1, 0, 1);

      vertex(v1.x, v1.y, v1.z, i, j);
      

      if (direction == "D1") {
        vertex(v2.x, v2.y, v2.z, i-1, j);
      } else if (direction == "D2") {
        vertex(v2.x, v2.y, v2.z, i+1, j);
      }
    }
    endShape();
  }
}





void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  cam = new PeasyCam(this, 800);
}


float t;
void draw() {
  //clear();
  background(0);
  
  t+=radians(3);
  rotateX(radians(25));

  push();
  println(mouseX);

  pushMatrix();
  //rotateY(2*PI*t);
  int res = 40;
  //draw_surface(r1, r2, res, res, "D2" ); //outer 
  draw_surface(r1, r2, 5, 5, "D2");
  //draw_points(r1, r2, 40, 40, "D2");
  //draw_surface(r3, r4, res-30, res, "D1"); //inner 
  popMatrix();

  pop();
  
  //if(frameCount<=60){
  // saveFrame("output/gif###.png");  
  //}else{
  // exit(); 
  //}
}
