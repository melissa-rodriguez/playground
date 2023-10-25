float a, b, c, d, p, q, x, y;
OpenSimplexNoise noise;
void setup()
{
  size(900, 900);
  clear();
  //a=1.374;
  ////a = sliderA;
  //b=-1.764;
  //c=1.582;
  //d=1.056;
  //x=1;
  //y=1.15;

  a=1.24;
  //b=-2.264;
  b=-TAU;
  c=TAU;
  d=1.456;
  x=1;
  y=1.15;
  noise = new OpenSimplexNoise();

  colorMode(HSB, 100);
  background(0, 0, 95);
}
void draw()
{
  //clear();
  //push();
  //background(0, 0, 95);
  translate(width/2, height/2);
  //rotate(radians(frameCount));
  rotate(radians(-90));
  //pop();
  for (int i=0; i<8e4; i++) {
    p=sin(a*y)+c*cos(a*x);
    q=sin(b*x)+d*cos(b*y);
    x=p;
    y=q;
    float n = (float) noise.eval(q, p);
    int dCol = int(map(i, 0, 8e4, 200, 0));
    stroke(70, 100, 100-dCol, i);
    point(x*150, y*100 - 100*n);
    point(x*150, 100*n+y*100);
  }
  a+=1e-3;
  //noLoop();
}

void mousePressed(){
 saveFrame("render###.png"); 
}
