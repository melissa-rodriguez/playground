import peasy.*;
PeasyCam cam;


PGraphics pg; 
PFont font;


// Total number of frames in the gif
int numFrames = 144;

float scale = 20;
float r1 = 20; //big ring
float r2 = 10; //big ring 


float r3 = 20; //small ring
float r4 = 3;  //small ring

PVector surface(float theta, float phi, float r1, float r2) {
  //float x = scale*(r1+r2*cos(theta+t/4))*cos(phi+t);
  //float y = scale*(r1+r2*cos(theta+t/4))*sin(phi+t);
  //float z = scale*r2*sin(theta+t/4);

  float x = scale*(r1+r2*(cos(theta+t)))*(cos(phi+t));
  float y = scale*(r1+r2*(cos(theta+t)))*(sin(phi+t));
  float z = scale*r2*(sin(theta+t));

  return new PVector(x, y, z);
}

void draw_surface(float r1, float r2, int n1, int n2, String dir) {
  String direction = dir;

  if (direction == "D2") { //outer
    textGraphics("OUTER", 0); //word and zoom out amt
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
    //Stripes
    //if ((i)%2 == 0) {
    //  fill(0);
    //} else {
    //  fill(200);
    //}

    beginShape(TRIANGLE_STRIP);
    texture(pg);
    for (int j = 0; j < n2+1; j++) {
      float theta1 = map(i, 0, n1, 0, 2*PI);
      float theta2 = map(i+1, 0, n1, 0, 2*PI);

      float phi = map(j, 0, n2, 0, 2*PI);

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

      //vertex(v1.x, v1.y, v1.z, j, i-1);
      //vertex(v2.x, v2.y, v2.z, j, i);

      //vertex(v1.x, v1.y, v1.z);
      //vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
}


void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);

  pg = createGraphics(1080, 1920, P3D); 

  font = createFont("bebas.ttf", 300);
  pg.imageMode(CENTER);

  textureMode(NORMAL);

  cam = new PeasyCam(this, 550);
}

float t; 
void draw() {
  background(0);
  //t = 1.0*(frameCount-1)/numFrames;
  t+=radians(0.5);

  //push();


  push();
  rotateX(radians(75));
  translate(-200, 0);
  
  //rotateX(radians(75));
  //translate(-200, 0);
  //rotate(radians(mouseX));

  println(mouseX);

  pushMatrix();
  //rotateY(2*PI*t);
  int res = 40;
  draw_surface(r1, r2, res, res-5, "D2" ); //outer 
  draw_surface(r3, r4, res-30, res, "D1"); //inner 
  popMatrix();

  pop();

  //footer();

  //Saves the frame
  //println(frameCount,"/",numFrames);
  //saveFrame("output2/gif###.png");

  //// Stops when all the frames are rendered
  //if(frameCount == numFrames){
  //    exit();
  //}
}

void textGraphics(String str, int zoom) {
  String word = str;
  pg.beginDraw();
  pg.background(0);

  pg.push();
  pg.translate(pg.width/2, pg.height/2, pg.width-zoom);
  pg.rotate(-PI/2);
  pg.fill(255);
  pg.textSize(200);
  pg.textFont(font);
  pg.textAlign(CENTER, CENTER);
  pg.text(word, 0, 0); 

  pg.pop();
  pg.endDraw();
}
