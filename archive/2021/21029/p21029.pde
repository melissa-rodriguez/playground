Ring ring;
ArrayList<Object> objects;
import peasy.*;
PeasyCam cam;

OpenSimplexNoise noise;

void setup() {
  size(1080, 1080, P3D);  
  smooth(8);
  pixelDensity(2);
  noise = new OpenSimplexNoise();

  ring = new Ring();

  cam = new PeasyCam(this, 700);
}

float t = 0;
void draw() {
  background(0);
  rotateX(radians(206));
  //rotate(radians(mouseX));
  println(mouseX);
  //translate(width/2, height/2);
  push();
  ring.showSurface("no");
  ring.showPoint();
  //ring.addObject();
  ring.update();

  pop();
  
  //if(frameCount <= 180){
  // saveFrame("output/gif###.png"); 
  //}else{
  // exit(); 
  //}
}

class Ring {
  float r1, r2;
  PVector center; 
  float rand;

  Ring() {
    r1 = 200;
    r2 = r1*2;
    rand = 1.3*randomGaussian();
    center = new PVector(0, 0);
  }

  void update() {
    t+=radians(1);
  }

  void showPoint() {
    push();
    int n1 = 80; //theta res
    int n2 = 40; //phi res
    stroke(255);
    strokeWeight(10);
    objects = new ArrayList<Object>();

    for (int i = 0; i < n1; i++) {
      //beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < n2+1; j++) {
        float theta1 = map(i, 0, n1, 0, 2*PI);
        float theta2 = map(i+1, 0, n1, 0, 2*PI);

        float phi = map(j, 0, n2, 0, 2*PI);

        PVector v1 = surface(theta1, phi);
        PVector v2 = surface(theta2, phi);

        //point(v1.x, v1.y, v1.z);
        objects.add(new Object(1, v1));

        //vertex(v2.x, v2.y, v2.z);
      }
      //endShape();
    }

    push();
    for (Object o : objects) {
      o.show();
    }
    pop();


    pop();
  }

  void showSurface(String s) {
    push();
    int n1 = 40; //theta res
    int n2 = 40; //phi res
    if (s == "outlined") {
      stroke(255);
    } else {
      stroke(0);
    }
    fill(0);
    for (int i = 0; i < n1; i++) {
      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < n2+1; j++) {
        float theta1 = map(i, 0, n1, 0, 2*PI);
        float theta2 = map(i+1, 0, n1, 0, 2*PI);

        float phi = map(j, 0, n2, 0, 2*PI);

        PVector v1 = surface(theta1, phi);
        PVector v2 = surface(theta2, phi);

        vertex(v1.x, v1.y, v1.z);
        vertex(v2.x, v2.y, v2.z);
      }
      endShape();
    }
    pop();
    
    
    push();
    if (s == "outlined") {
      stroke(255);
    } else {
      stroke(0);
    }
    fill(0);
    for (int i = 0; i < n1; i++) {
      //beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < n2+1; j++) {
        float theta1 = map(i, 0, n1, 0, 2*PI);
        float theta2 = map(i+1, 0, n1, 0, 2*PI);

        float phi = map(j, 0, n2, 0, 2*PI);

        PVector v1 = surface(theta1, phi);
        PVector v2 = surface(theta2, phi);
         strokeWeight(3);
         stroke(100);
         
         //line(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z);
        //vertex(v1.x, v1.y, v1.z);
        //vertex(v2.x, v2.y, v2.z);
      }
      //endShape();
    }
    pop();
  }

  PVector surface(float theta, float phi) {

    float x = (r2+r1*(cos(theta+t)))*cos(phi+t/2);
    float y = (r2+r1*(cos(theta+t)))*sin(phi+t/2);
    float z = r2*(sin(theta+t));
    float n = (float)noise.eval(x*0.002, y*0.002);

    return new PVector(x+50*easeInBack(cos(theta)), y+50*easeInBack(sin(theta)), z);
  }
}

class Object {
  int type; 
  PVector pos;

  Object(int t, PVector p) {
    type = int(random(1, 3));
    pos = p;
  }

  void show() {
    strokeWeight(10);
    stroke(map(pos.z, 0, 200, 255, 0));
    //stroke(255);
    //stroke(255*map((float)noise.eval(pos.x*0.005, pos.y*0.005), -1, 1, 0.5, 1));
    push();
    translate(pos.x, pos.y, pos.z);
    point(0, 0, 0);
    pop();
  }
}
