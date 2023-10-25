OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P2D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
}
float t, x, y, i, p, a, k=5000;
void draw() {
  t+=.005;
  translate(width/2, height/2);
  background(0);
  for (i=0; i<k; i++) {
    p=1.0*(i+t)/k;
    a=sin(TAU*(p-t))-cos(TAU*(p-t));
    float sn = (float) noise.eval(500*p*cos(TAU*(p-t +pow(i, 3))), 500 *p*a);
    noStroke();
    //println(a);
    float m = map(sin((p-t)), -1, 1, 0, 1.14);
    //println(m);
    //float xpos = 400*p*cos(TAU*(p-t +pow(i,1.14)));
    //float ypos = 300 *p*a*sin(TAU*(p-t +pow(i, 1.14)));
    
    float xpos = 400*p*cos(TAU*(p-t +pow(i,m)));
    float ypos = 300 *p*a*sin(TAU*(p-t +pow(i, m)));
    fill(255);
    circle(xpos, ypos, 8*sqrt(p)*sn);
  }
  
  //saveFrame("output/gif###.png");
}
