import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;

void settings() {
  size(900, 900, P3D);
  pixelDensity(2);
  smooth(8);
}
void setup() {
  cam = new PeasyCam(this, 100);
  noise = new OpenSimplexNoise();
}
float a,t, i, p, x, y, k=60;
void draw() {
  t+=.005;
  background(0);
  for (a=0; a<TAU; a+=.1) {
    for (i=0; i<k; i++) {
      p=(i-t)/k;
      push();
      float x = p*width*cos(a);
      float y = p*width*sin(a);
      float z = 500-p*1e4;
      //translate(-width/2, -height/2, -height/2);
      translate(x, y, z);
      //rotateY(3*TAU*(p-t));

      fill(0);
      //println(z);
      stroke(255*map(z, -100, 10, 1, 0));
      //translate(300, 0, 0);
      //rotate(60*TAU*p);
      //box(5*1.5+5*easeInElastic(sin(TAU*(p-t))), 10*1.5, 100*1.5);
      circle(0, 0, 20);
      pop();
    }
  }
  //println(mouseX);
  //if(frameCount <=200){
  //saveFrame("output/gif###.png");
  //}
}
