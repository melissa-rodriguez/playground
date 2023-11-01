
import peasy.*;
PeasyCam cam;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 1200);
}

float p, i, t, k =1;
float a = 0;
void draw() {
  background(0);
  t+=0.01;

  for (i = 0; i < k; i++) {
    p = (i+t)/k; 

    for (float x = -width/2; x < width/2; x+=10) {
      for (float y = -height/2; y < height/2; y+=10) {
        push();
        float d = dist(x, y,0, 0);
        if (d < 400) {
          translate(x, y, -100*sin(PI*p)*cos(a));
          circle(0, 0, 3);
        } else {
          translate(x, y, 0);
          circle(0, 0, 3);
        }
        pop();
        a+=0.001;
        if (a > TAU) {
          a=0;
        }
      }
    }
  }
  if (t>1) {
    t=0;
  }
  
  //if(t<1){
  // saveFrame("output/gif###.png"); 
  //}
  //else{
  // exit(); 
  //}
}
