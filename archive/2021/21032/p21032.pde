float a, b, c, d, p, q, x, y;
OpenSimplexNoise noise;

int totalFrames = 180;
int counter = 0;
boolean record = false;
void setup()
{
  size(900, 900);
  pixelDensity(2); 
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
  b=-2.1;
  c=1.08;
  d=1.956;
  x=1;
  y=1.85;
  noise = new OpenSimplexNoise();

  char c;
  c = 'H';
  PFont font = createFont("Arial", 96, true);
  PShape shape = font.getShape(c);
  for (int i = 0; i < shape.getVertexCount(); i++) {
    edgeVertices.add(shape.getVertex(i));
  }
  //background(240);
  //colorMode(HSB,100);
  colorMode(HSB);
  background(0, 0, 0);
}

//color[] colorArray = new int[]{#62C2C5, #7760A6, #FFFFFF, #62C2C5};
color[] colorArray = new int[]{#F2BF27, #F2921D, #F26A1B, #59200B, #FFFFFF};
//color[] colorArray = new int[]{#152659, #233D8C, #52D5F2, #F27405, #FFFFFF};
ArrayList<PVector> edgeVertices = new ArrayList<PVector>();
float zoff = 0;
float n;

void draw()
{
  float percent = 0;
  if (record) {
    percent = float(counter)/totalFrames;
  } else {
    percent = float(counter%totalFrames)/totalFrames;
  }
  background(0);
  //translate(width/2, 0);
  //rotateY(radians(frameCount*.2));
  render(percent);
  println(percent);
  if (record) {
    saveFrame("output2/gif-" + nf(counter, 3) + ".png");
    //rec();
    if (counter == totalFrames-1) {
      exit();
    }
  }
  counter++;
}

void render(float percent) {
  float angle = map(percent, 0, 1, 0, TWO_PI);
  float uoff = map(cos(angle), -1, 1, 0, 2);
  float voff = map(sin(angle), -1, 1, 0, 2);
  //clear();
  //push();
  background(0, 0, 0);
  translate(width/2, height/2);
  //rotateY(mouseX *0.02);
  //rotateX(mouseY *0.02);
  //rotate(radians(frameCount));



  //pop();
  //rotate(radians(-90));
  for (int i=0; i<12e4; i++) {  
    p=sin(a*y)+c*cos(a*x);
    q=sin(b*x)+d*cos(b*y); 
    x=p;
    y=q;
    //float n = (float) noise.eval(q*p, p, zoff);
    if (record) {
      n = (float) noise.eval(q*p, p, uoff, voff);
    }
    n = (float) noise.eval(q*p, p, zoff);
    rotate(radians(-30));
    float d = dist(x*100, n*50-200, 0, 0);
    float mapcol = map(d, 0, x * 100, 100, 0);
    int colorind = floor(random(5));
    //stroke(colorArray[colorind]);
    stroke(#ffffff);
    //stroke(0, 0, mapcol);

    //stroke(#62C2C5);
    point(x*100, n*50-200);



    //point(x*200, n*100/y);
    //point(x*150, 100*n+y*100);
  }
  a+=1e-3;
  zoff += 0.1;
  //saveFrame("output/gif###.png");
  //noLoop();
}

void mousePressed() {
  saveFrame("render###.png");
}
