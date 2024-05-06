float a, b, c, d, p, q, x, y;
OpenSimplexNoise noise;
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
  background(0,0,0);
}

//color[] colorArray = new int[]{#62C2C5, #7760A6, #FFFFFF, #62C2C5};
//color[] colorArray = new int[]{#F2BF27, #F2921D, #F26A1B, #59200B,#FFFFFF};
color[] colorArray = new int[]{#152659, #233D8C, #52D5F2, #F27405, #FFFFFF};
ArrayList<PVector> edgeVertices = new ArrayList<PVector>();
void draw()
{
  //clear();
  //push();
  //background(0,0,0);
  translate(width/2, height/2);
  //rotateY(mouseX *0.02);
  //rotateX(mouseY *0.02);
  //rotate(radians(frameCount));



  //pop();
  //rotate(radians(-90));
  for (int i=0; i<8e4; i++) {  
    p=sin(a*y)+c*cos(a*x);
    q=sin(b*x)+d*cos(b*y); 
    x=p;
    y=q;
    float n = (float) noise.eval(q, p);
    rotate(radians(-30));
    int colorind = floor(random(5));
    stroke(colorArray[colorind]);
  
    //stroke(#62C2C5);
    point(x*200, n*100);


    //point(x*200, n*100/y);
    //point(x*150, 100*n+y*100);
  }
  a+=1e-3;
  //noLoop();
}

void mousePressed() {
  saveFrame("render###.png");
}
