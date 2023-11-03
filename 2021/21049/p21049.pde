//first ever tunnel gif :))))))
OpenSimplexNoise noise;
int numFrames = 115;
void setup() {
  size(1080, 1080);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
}
float t, i, p,rot, x, y, a,n, ringSize = 1500, dotSize = 50, d, k=100;
float zoff;
void draw() {
  t+=.005;
  background(0);
  
  beginShape();
  translate(width/2, height/2);

  for (a=0; a<TAU; a+=.1) {
    float xoff = 0;
    for (i = 0; i < k; i +=0.5) {
      float yoff = 0;
     push();
     float l = lerp(0, ringSize*p, p);
     rotate(TAU/3*p);
     translate(map(cos(TAU*(p-t)), -1, 1, -500, 100), map(sin(TAU*(p-t)), -1, 1, - 300, 200));
      p=1.0*(i+t)/k;
      x = p*ringSize* cos(a);
      y = p*ringSize * sin((a));

      n = (float) noise.eval(x,y, zoff);
      float mn = map(n, -1, 1, 0, 2);
      
      noStroke();
      //fill(0);
      //circle(150 + x, y, dotSize*p*mn*sin(4*TAU*(p-t))+10);
      fill(255, 255*p*10);
      //rotate(p*radians(p*(p*p-t)));
      //circle(x, y, dotSize*p*n*sin(2*TAU*(p-t)));
        //rotate(radians(frameCount));
      circle(150+x, y, dotSize*p*mn*sin(4*TAU*(p-t)));
      pop();
      yoff += 0.02;
    }
    xoff += 0.02;
  }
  zoff += 0.01;
  
  //saveFrame("output2/gif###.png");
  
  //if(frameCount<=numFrames)
  //{
  //  saveFrame("output/gif###.png");
  //}
  //if(frameCount==numFrames)
  //{
  //  println("All frames have been saved");
  //  exit();
  //}
}
