import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;
Object obj;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
  cam = new PeasyCam(this, 4800);
  smooth(8);

  obj = new Object();
}

void draw() {
  background(0);
  translate(0, -560, 0);
  rotateX(radians(75));
  rotate(radians(233));
  //rotateY(radians(mouseX));
  println(mouseX);
  obj.render();
  
  //if(frameCount<=72){
  // saveFrame("output/gif###.png"); 
  //}
  //else{
  // exit() ;
  //}
}

class Object {
  PVector pos;
  float offset;
  PVector obj; //object position
  float n1, n2, rev; 
  float t = 0;//time
  float p;
  float r = 200; //size of object
  Object() {
    pos = new PVector(random(0.8, 1), random(0.8, 1), random(0.8, 1));
    obj = new PVector(0, 0, 0); //position object at the center of canvas
    n1 = 300; //theta resolution 
    n2 = 100; //phi resolution 
    rev = 3; //number of revolutions of spiral
    offset = random(0, 1);
  }

  void render() {
    renderSurface();
    renderPoints();
    renderCircle();
    update();
  }

  void update() {
    t+=radians(5);
    //renderSurface(t);
  }

  void renderCircle() {
    strokeWeight(8);
    noFill();
    circle(0, 0, 2530);
  }

  void renderSurface() {
    for (int i = 0; i <= n1; i++) {
      p = i/n1;
      beginShape(TRIANGLE_STRIP);
      //noFill();
      //stroke(255);
      noStroke();
      //strokeWeight(3);
      fill(0);
      for (int j = 0; j <= n2; j++) {
        float theta = map(i, 0, n1, 0, rev*TAU);
        float theta2 = map(i+1, 0, n1, 0, rev*TAU);
        float phi = map(j, 0, n2, 0, TAU);
        PVector v = surface(theta, phi, p, n1, n2);
        PVector v2 = surface(theta2, phi, p, n1, n2);
        float n = (float) noise.eval(v.x*0.003, v.y*0.003);
        float offset = map(n, -1, 1, 0.4, 1);
        vertex(v.x, v.y, v.z);
        vertex(v2.x, v2.y, v2.z);
        //point(v.x, v.y, v.z);
      }
      endShape(CLOSE);
    }
  }

  void renderPoints() {
    for (int i = 0; i <= n1; i++) {
      p = i/n1;
      //noFill();
      stroke(255);
      //strokeWeight(8);
      fill(0);
      for (int j = 0; j <= n2; j++) {
        float theta = map(i, 0, n1, 0, rev*TAU);
        float theta2 = map(i+1, 0, n1, 0, rev*TAU);
        float phi = map(j, 0, n2, 0, TAU);
        PVector v = surface(theta, phi, p, n1, n2);
        PVector v2 = surface(theta2, phi, p, n1, n2);


        float n = (float) noise.eval(v.x*0.005, v.y*0.005);
        float off = map(n, -1, 1, 0, 1);
        strokeWeight(13*off);
        point(v.x, v.y, v.z);
      }
    }
  }

  PVector surface(float theta, float phi, float p, float n1, float n2) {
    float x = r*phi*(cos(theta+t));
    float y = r*phi*(sin(theta+t));
    //float z = -p*r*sin(theta+t);
    float mapr = map(mag(x, y), 0, 2000, 0, r);
    float z = -p*r/5*phi*easeOutBack(sin(theta+t))*(sin(phi));
    float n = (float) noise.eval(x*0.005, y*0.005);
    float off = map(n, -1, 1, 0.8, 1);

    return new PVector(x, y, z);
  }
}
