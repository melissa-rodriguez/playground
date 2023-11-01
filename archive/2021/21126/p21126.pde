float a, b, c, d, p, q, x, y,z;
OpenSimplexNoise noise;
void setup()
{
  size(1080, 1080, P3D);
  clear();
  //a=1.374;
  ////a = sliderA;
  //b=-1.764;
  //c=1.582;
  //d=1.056;
  //x=1;
  //y=1.15;

  a=-0.709;
  //b=-2.264;
  b=1.638;
  c=0.452;
  d=1.740;
  x=1;
  y=1.85;
  noise = new OpenSimplexNoise();

  //colorMode(HSB,100);
  //colorMode(HSB);
  //background(0,0,0);
  background(33,45,57);
}

//color[] colorArray = new int[]{#62C2C5, #7760A6, #FFFFFF, #62C2C5};
//color[] colorArray = new int[]{#152659, #233D8C, #52D5F2, #F27405,#FFFFFF};
color[] colorArray = new int[]{#212a37, #b7c8cb, #dde5dc, #91a4a8,#dde5dc};

void draw()
{
  //clear();
  //push();
  background(33,45,57);
  //background(#91a4a8);
  translate(width/2, height/2-100);
  rotate(PI);
  //rotateY(mouseX *0.02);
  //rotateX(mouseY *0.02);
  //rotate(radians(frameCount));
  //rotate(radians(-90));
  
  //pop();
  for (int i=0; i<8e4; i++) {
    p=sin(a*y)-cos(b*x);
    q=sin(c*x)-cos(d*y);
    x=p;
    y=q;
    //z = d*sin(a*x);
    float n = (float) noise.eval(q, p);
    //stroke(70, 100, 100-dCol, i);
    //stroke(15, random(100), i);
    int colorind = floor(random(5));
    stroke(colorArray[colorind], 200);
    //stroke(#62C2C5);
    //point(x*200, n*100);
    point(x*474*n, y*663*n);
    point(-x*474*n, y*663*n);
    //point(x*200, n*100/y);
    //point(x*150, 100*n+y*100);
  }
  a+=1e-3;
  //println(474, 663);
  //noLoop();
  
  if(frameCount == 3){
   saveFrame("output.png"); 
  }
}

void mousePressed(){
 saveFrame("render###.png"); 
}
