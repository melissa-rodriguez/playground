OpenSimplexNoise noise;
void setup() {
  size(900, 900, P3D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
}
float t, i, p, x, y, k=60;
void draw() {
  t+=.005;
  background(0);
  for (i=0; i<k; i++) {
    p=(i-t)/k;
    for (x=0*1.5; x<=600*1.5; x+=100*1.5) {
      for (y=200*1.5; y<=400*1.5; y+=200*1.5) {
        push();
        translate(x, y, 500-p*1e4);
        rotate(3*TAU*p*easeInElastic(sin(TAU*(p+t))));
        
        fill(0);
        stroke(255*(1-p));
        box(5*1.5, 100*1.5, 90*1.5);
        pop();
      }
    }
  }
  
  //if(frameCount <=100){
  //saveFrame("output/gif###.png");
  //}
}
