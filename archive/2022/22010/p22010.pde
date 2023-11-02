import peasy.*;
PeasyCam cam;

float scale = 20;

PGraphics pg; 
PFont font;


float r1 = 20; //big ring
float r2 = 10; //big ring 
float len = 500; 

PVector surface(float theta, float phi, float r1, float r2, float phase) {
  //float x = scale*(r1+r2*cos(theta+t/4))*cos(phi+t);
  //float y = scale*(r1+r2*cos(theta+t/4))*sin(phi+t);
  //float z = scale*r2*sin(theta+t/4);

  float x = scale*(r1+r2*(cos(theta+t + phase)))*(cos(phi+t + phase));
  float y = scale*(r1+r2*(cos(theta+t+phase)))*(sin(phi+t+phase));
  float z = scale*r2*(sin(theta+t+phase))+phi*len+100*t;

  return new PVector(x, y, z);
}

void draw_surface(float r1, float r2, int n1, int n2, String dir, float rev, float phase) {
  String direction = dir;
  
  if (direction == "D2") { //outer
    textGraphics("FLOW", 0); //word and zoom out amt
  } else if (direction == "D1") { //inner
    textGraphics("INNER", 0); // word and zoom out amt
  }

  stroke(255); // white lines
  fill(0); // black fill
  strokeWeight(3);

  noStroke();
  textureMode(NORMAL);
  textureWrap(REPEAT);


  for (int i = 0; i < n1; i++) {
    beginShape(TRIANGLE_STRIP);
    texture(pg);
    for (int j = 0; j < n2+1; j++) {
      float theta1 = map(i, 0, n1, 0, 2*PI);
      float theta2 = map(i+1, 0, n1, 0, 2*PI);

      float phi = map(j, 0, n2, 0, rev*TAU);

      PVector v1 = surface(theta1, phi, r1, r2, phase);
      PVector v2 = surface(theta2, phi, r1, r2, phase);

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

void textGraphics(String str, int zoom) {
  String word = str;
  pg.beginDraw();
  pg.background(0);

  pg.push();
  pg.translate(pg.width/2, pg.height/2, pg.width-zoom);
  pg.strokeWeight(40);
  pg.rotate(-PI/2);
  pg.fill(255);
  pg.textSize(200);
  pg.textFont(font);
  pg.textAlign(CENTER, CENTER);
  
  pg.stroke(255); 
  pg.noFill();
  
  //pg.text(word, 0, 0); 
  pg.circle(0, 0, 350);
  pg.line(0, - 350/2, width, 0);
  

  pg.pop();
  pg.endDraw();
}

void setup() {
  size(1900, 1900, P3D); 
  pixelDensity(2);
  pg = createGraphics(1080, 1920, P3D); 

  font = createFont("bebas.ttf", 300);
  pg.imageMode(CENTER);

  textureMode(NORMAL);

  cam = new PeasyCam(this, 1600);
}


float t;
void draw() {
  //clear();
  background(0);
  
  t+=radians(5);
  translate(0, width*6, 0);
  rotateX(radians(90));

  push();
  println(mouseX);

  pushMatrix();
  //rotateY(2*PI*t);
  int res = 40;
  //draw_surface(r1, r2, res, res, "D2" ); //outer 
  //draw_surface(r1, r2, 20, 20, "D2");
   push();
   translate(-200, 0); 
   draw_surface(r1, r2, 10, 300, "D2", 6, 0);
   pop();
   
   push();
   translate(200, 0);
   draw_surface(r1, r2, 10, 300, "D2", 6, PI);
   pop();
  //draw_surface(r3, r4, res-30, res, "D1"); //inner 
  popMatrix();

  pop();
  
  //if(frameCount<=180){
  // saveFrame("output2/gif###.png");  
  //}else{
  // exit();  
  //}
}
