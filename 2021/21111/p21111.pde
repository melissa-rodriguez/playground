import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 700);
  sphereDetail(5);
  //noiseSeed(5);
  noise = new OpenSimplexNoise();
}

float p, i, t, k = 1;
float radius = 200;
float numPoints = 40;
float numPoints2 = 80;
void draw() {
  background(0);
  //noFill();

  strokeWeight(3);
  //noStroke();
  t+=0.005;

  println(mouseX);
  rotateX(radians(137));
  rotate(radians(343));
  for (i = 0; i<k; i++) {
    p = (i+t)/k;   

    for (float a = 0; a < TAU; a += TAU/numPoints) {
      float xpos = radius*3*sin(a+p);
      float zpos = radius*cos(a+p);     
      for (float phi = 0; phi<TAU; phi+= TAU/numPoints2) {
        float n = (float) noise.eval(xpos*0.003, zpos*0.004);
        //stroke(255*map(xpos, 100, radius-10, 0, 1));
        stroke(255);
        fill(0);
        push();

        rotate(PI/2);
        rotateX(phi);
        //rotateY(radians(mouseX));
        translate(xpos, 0, zpos+radius*2);
        sphere(30);     
        //point(0, 0, 0);

        pop();

        //push();
        //stroke(255);
        //rotate(PI);
        //rotateX(phi);
        //translate(xpos+mouseX, 0, zpos+radius*2);
        //point(0, 0, 0);
        ////sphere(30);       
        //pop();
        
      }
    }
  }
  if(t>=2){
   t=0; 
  }
  //if(t<1){
  // saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
}
