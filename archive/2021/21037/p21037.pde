OpenSimplexNoise noise;
float i, n, a, p, x, y, t, k=100;
float a_, b_, c_, d_;
void setup() {
  size(1080, 1080);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
  a_=1.40;
  b_=1.56;
  c_=1.40;
  d_=-6.56;
  y = 1.85;
  x = 1;
}

float zoff = 0;
void draw() {
  t+=.01;
  background(0);
  translate(width/2, height/2);
  //noFill();
  //stroke(255);
  //beginShape();
  for (n=350; n>0; n-=25) { // circle size
    float xoff = 0;
    for (i=0; i<k; i++) { //amount of dots
    float yoff = 0;
      p=(i+t)/k;
      float pert = map(sin(radians(frameCount)), 0, 1, 0, TAU)*sin(radians(TAU*x)*t) - sin(radians(TAU*y));
      float qert = map(cos(radians(frameCount)), 0, 1, 0, TAU)*cos(radians(TAU*x)) + cos(radians(TAU*y));
      x = 50*pert;
      y = 50*qert;
      float sn = (float) noise.eval(x, y, zoff);
      //stroke(0,0,128+128*sin(TAU*t-.06*dist(abs(x),abs(y),y, y)));
      //fill(128+128*sin(TAU*t-.06*dist(abs(x),abs(y),y, y)));
      
      //stroke(0,0,128+128*sin(TAU*t-.06*dist(abs(x),abs(y),y, y)));
      //noFill();
      stroke(255*sin(TAU*t-.06*dist(abs(x),abs(y),y, y)));
      fill(255*sin(TAU*t-.06*dist(abs(x),abs(y),y, y)));
      
      circle(x, y, 10*sn);
      //if(dist(abs(x), abs(y), 0, 0) > 100){
      //curveVertex(x, y);

      //}

      yoff += 0.02;
    }
    xoff += 0.02;
  }
  zoff +=0.001;
  //endShape();
  //if(frameCount < 360){
  //saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
}
