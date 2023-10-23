import peasy.*;
PeasyCam cam;


OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P2D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
  //cam = new PeasyCam(this, 500);
}

float noiseMax = 0.7;
float phase = 0;
void draw() {
  background(0); 
  //strokeWeight(2);
  translate(width/2, height/2);
  noFill();

  for (float yHeight = 0; yHeight < 5; yHeight += 0.01) {
    drawCircle(yHeight);
  }

  //if(frameCount<=180){
  // saveFrame("gif/img###.png"); 
  //}
   //rec();
}
float thick = 4;
void drawCircle(float yHeight) {
  stroke(255);
  beginShape();
  for (float a = 0; a< TWO_PI; a += 0.1) {
    float xoff = map(cos(a+phase), -1, 1, 0, noiseMax);
    float yoff = map(sin(a), -1, 1, 0, noiseMax);

    float n = (float) noise.eval(xoff, yoff);
    float r = map(n, 0, 1, height/4, height/2);
    float x = r*cos(a);
    float y = r*sin(yHeight);
    float pos = (float) noise.eval(tan(radians(x))*r, tan(radians(y))*r); 
    //point(x,y);  
    float xMax = 200;
    float xMin = -xMax;
    float yMax = 450;
    float yMin = -yMax;

    //float d = dist(tan(radians(x))*r, tan(radians(y))*r, 0, 0);
    //float d = dist(tan(radians(x))*r, tan(radians(y))*r, 0, 0);
    //if (tan(radians(x))*r<xMax && tan(radians(x))*r > xMin && tan(radians(y))*r < yMax && tan(radians(y))*r > yMin){
    // strokeWeight(1); 
    //}
    //else{
    //strokeWeight(1.5); 
    //}

    //point(pow(acos(radians(x)), PI)*r, tan(radians(y))*r);

    float morph = map(sin(radians(frameCount*5)), -1, 1, -PI/18, TAU);
    point(pow(sin(radians(x)), morph)*r+5, cos(radians(x))*r);
    point(-pow(sin(radians(x)), morph)*r-5, cos(radians(x))*r);


    //vertex(cos(radians(x))*r,y);
  }
  endShape(CLOSE);
  phase+=0.05;
}

//x y values for point variations
//point(cos(radians(x))*r,cos(radians(y))*r);
//point(cos(radians(x))*r,sin(radians(y))*r);
//point(tan(radians(x))*r,y);
//point(cos(radians(x))*r,y);
