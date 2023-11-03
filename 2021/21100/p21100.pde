import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 1000);
}

float p, i, t, k = 100;
void draw() {
  background(0);

  //noStroke();
  stroke(255);
  strokeWeight(2);
  t+=0.01;
  //prototyping
  //first make a circle of n points 
  for (int n = 1; n < 4; n++) {
    for (float a = 0; a <= TAU; a+=0.05) {
      float x =  (300-20*n)*cos(a);
      float y = (300-20*n)*sin(a);
      push();
      //float m = map(y+99*tan(TAU*t+mag(y,y))
      float m  = map(dist(x, y, 0, 0), 0, 300, 0, 1);
      stroke(255*m);
      fill(255*m);
      translate(x, y+99*tan(TAU*t+mag(y, y)));
      line(0, 0, 0, 30*noise(x, y));
      circle(0, 30*noise(x, y), 10*noise(x*0.002, y*0.002));
      pop();
      //circle(x, y+99*tan(TAU*t+mag(y,y)), 10);
    }
  }

  //if(t<1){
  //  saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
 
}
