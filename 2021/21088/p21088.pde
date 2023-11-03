import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 700);
  //blendMode(DIFFERENCE);
}

float k = 200, t, numPoints = 10;
float[] goodNums = {1,11,33,51,57,89,98,99,101,133,233,251,266,267,299,301,343,367,399,401,499, 667,767,
799};
void draw() {
  background(0);
  t += 0.0001;
  //circle(0, 0, 200);
  //noFill();
  fill(0);
  strokeWeight(2);

  for (int i=0; i<k; i++) {
    float p = (i+25*t)/k;
    stroke(255*p);
    for (float a=0; a<TAU; a+=TAU/numPoints) {
      float x = 1000*cos(a);
      float y = 300*sin(a);
      push();
      rotateX(33*TAU*(p-t));
      //rotateY(TAU*(p-t));
      //translate(0, 0, -100*t);
      circle(x*p,y*p,500*p);
      pop();
    }
  }
  //if(t<1){
  // saveFrame("output6/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
  if (t>1)t=0;
 
}

int count = 0;
void keyPressed(){
  if(keyCode == LEFT){
   count--; 
  }
  if(keyCode == RIGHT){
   count++;
  }
  println(count);
}
