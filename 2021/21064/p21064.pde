import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;

void settings() {
  size(900, 900, P3D);
  pixelDensity(2);
  smooth(8);
}
void setup() {
  cam = new PeasyCam(this, 1000);
  noise = new OpenSimplexNoise();
}
float a, t, i, p, x, y,inc, k=100;
float[] goodNums = {33, 188, 282, 385, 553, 500};
boolean rec = false;
void draw() {
  sphereDetail(3);
  t+=.005;
  background(0);
  //lights();
  //option1
  //rotateY(radians(45));
  //rotateZ(radians(60));
  //rotateX(radians(-15));
  //translate(0, 0, 200);

  //option2
  //rotateY(radians(100));
  //rotateZ(radians(286));
  //rotateX(radians(-15));

  //option3
  //rotateY(radians(100));
  //rotateZ(radians(137));
  //rotateX(radians(-15));

  //rotateX(radians(67));
  //rotateY(radians(662));
  //rotateZ(radians(frameCount));
  println(mouseX, mouseY);
  //rotateY(map(inc, 0, width/2,0, radians(360) ));
  translate(-50, -70, 0);
  rotateX(radians(45));
  rotateY(radians(-70));
  translate(50, 50, 0);

  //strokeWeight(1.5);
  //inc +=2;
  //println(mouseX);
  for (a=0; a<TAU; a+=.09) {
    for (i=0; i<k; i++) {
      p=(i-t)/k;
      //option1
      //rotateY(radians(116*0.5));
      //rotateZ(radians(164*0.5));
      //rotateX(radians(-15));
      
      rotateY(radians(855*0.5));
      rotateZ(radians(181*0.5));
      rotateX(radians(-goodNums[0]));
      push();
      float x = (p)*width/2*cos(a);
      float y = (p)*width/2*sin(a);
      float n = (float) noise.eval(x*0.002, y*0.002);
      float z = 500-(p)*1e4;
      //float z = 500-(p*)*1e4;


      //translate(-width/2, -height/2, -height/2);
      translate(x, y, z);
      //rotateX(TAU*n*easeInElastic(sin(p-t)));

      stroke(255, 255*map(abs(sin(PI*(p))), 0, 1, 0.2, 0.8));
      fill(0);

      //noFill();
      //println(z);
      //noStroke();
      //stroke(255*map(z, -100, 10, 1, 0),100);
      //translate(300, 0, 0);
      //rotate(mouseX*TAU*(p));
      box(5*1.5, 5*1.5, 20*1.5+5*easeInElastic(sin(TAU*(p))));
      //println(mouseX);
      //box(5*1.5+5*easeInElastic(sin(TAU*(p-t))));
      pop();
    }
  }
  //println(mouseX);
  //if(frameCount > 500){
  //saveFrame("output3/gif###.png");
  //}
  //else if (frameCount > 200){
  // exit(); 
  //}
}

void mousePressed(){
 rec = true; 
}
