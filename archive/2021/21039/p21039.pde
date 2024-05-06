void setup() {
  size(1080, 1080);
  pixelDensity(2);
}
float i, n, a, p, x, y, t, k=10;
float zoff = 0;
void draw() {
  t+=.01;
  background(0);
  strokeWeight(1.5);
  translate(width/2, height/2);
  beginShape();
  for (n=250; n>0; n-=25) {
    float xoff = 0;
    for (i=0; i<k; i++) {
      float yoff = 0;
      p=(i+t)/k;
      //float tmap = map(t, 0, 100, 0, 1.4);
      //println(sin(t));
      x=n*sin(TAU*p)+sin(radians(x)*sin(t))*50;
      y=n*cos(TAU*p)+cos(radians(y)*sin(t))*50;
      //noStroke();
      //fill(128+128*sin(TAU*t-.06*dist(abs(x), abs(y), n, n)));
      //circle(x, y, 15);
      noFill();
      stroke(255);
      //strokeWeight(0.5);
      curveVertex(x,y);

      yoff += 0.02;
    }
    xoff +=0.02;
  }
  zoff += 0.001;
  endShape();
}
