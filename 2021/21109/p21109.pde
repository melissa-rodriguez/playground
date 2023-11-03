import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;
void settings() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
}
void setup() {
  cam = new PeasyCam(this, 800);
  sphereDetail(5);
  noise = new OpenSimplexNoise();
}

float p, i, t, k = 1;
float radius = 200;
void draw() {
  background(0);
  //noFill();


  fill(0);
  strokeWeight(3);
  //noStroke();
  t+=0.01;

  float numPoints = 80;
  float numPoints2 = 80;


  beginShape(POINTS);
  for (i = 0; i<k; i++) {
    p = (i+t)/k; 
    for (float a = 0; a <= TAU; a += TAU/numPoints) {
      //radius = 200*sin(a+easeOutElastic(p));
      float xpos = radius*sin(a+(p));
      float zpos = radius*cos(a+(p));

      for (float phi = 0; phi<=TAU; phi+= TAU/numPoints2) {
        push();
        rotateY(PI/2);
        rotate(radians(148));
        rotateX(radians(8));

        rotateX(phi);
        rotateY(sin(PI*(phi)));
        translate(xpos, 0, zpos+100);
        float d = dist(xpos, 0, zpos+100, 0, 0, 0);

        //stroke(255*map(d,0,250,0, 1));
        if (mag(0, 0, zpos+100) > 500) {
          stroke(255);
        } else {
          stroke(255*map(mag(0, 0, zpos+100), 0, 200, 1, 0.5));
        }
        //stroke(255);
        //sphere(10);
        sphere(10);

        //rotateY(3*TAU*p);
        //box(5,5,300);       
        //box(5,100,50);
        pop();
      }
    }
  }

  endShape();

  if (t>=1) {
    t=0;
  }
  //if(t<=2){
  // saveFrame("output/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}
