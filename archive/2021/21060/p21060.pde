import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;

void settings() {
  size(900, 900, P3D);
  pixelDensity(2);
  smooth(8);
}
void setup() {
  cam = new PeasyCam(this, 900);
  noise = new OpenSimplexNoise();
}
float a, t, i, p, x, y, k=100;
void draw() {
  sphereDetail(3);
  t+=.01;
  background(0);
  //lights();
  //option1
  rotateY(radians(0));
  rotateZ(radians(70));
  rotateX(radians(180));
  //rotateX(radians(mouseX));
  //translate(0, 0, 200);
  //println(mouseX);
  //option2
  //rotateY(radians(100));
  //rotateZ(radians(286));
  //rotateX(radians(-15));

  //option3
  //rotateY(radians(100));
  //rotateZ(radians(137));
  //rotateX(radians(-15));

  translate(0, 0, 200);
  //println(mouseX);
  for (a=0; a<TAU; a+=.05) {
    for (i=0; i<k; i++) {
      p=(i-t)/k;
      push();
      float x = (p)*width/2*cos(a);
      float y = (p)*width/2*sin(a);
      float n = (float) noise.eval(x*0.002,y*0.002,t);
      float z = 500-(p*0.1)*1e4;
      //float z = 500-(p*)*1e4;
      
      
      //translate(-width/2, -height/2, -height/2);
      translate(x, y, z);
      rotateY(TAU*(p-t));

      stroke(255*p*2, 255*(abs(sin(PI*(p)))));
      fill(0);
      //noFill();
      //println(z);
      //noStroke();
      //stroke(255*map(z, -100, 10, 1, 0),100);
      //translate(300, 0, 0);
      //rotate(mouseX*TAU*(p));
      box(5*1.5+5*easeInElastic(sin(TAU*(p-t))), 50*1.5, 100*1.5);
      //println(mouseX);
      //box(5*1.5+5*easeInElastic(sin(TAU*(p-t))));
      pop();
    }
  }
  //println(mouseX);
  //if(frameCount <=50){
  //saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
}
