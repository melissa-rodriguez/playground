OpenSimplexNoise noise;

void setup() {
  //size(900, 1200);
  size(1080, 1080);
  pixelDensity(2);
  background(240);
  //background(0);
  noise = new OpenSimplexNoise();
  colorMode(HSB);
}

float len = 0;
float speed;
float xoff;
float zoff = 0;
boolean lineDown = false;
void draw() {
  translate(width/2, height/2);
  noFill();
  stroke(0);
  //stroke(255);
  speed = frameCount* 2;
  //rotate(radians(-25));
  //lineDown = map(sin(radians(frameCount)), -1, 1, round(0), round(100));
  for (float i = 0; i < 2000; i++) {
    float t = 5*radians(i);
    float x = 5*t * cos(t);
    float y = t * sin(t);
    float n = (float) noise.eval(xoff*0.002, y*0.002, zoff); //play around with a small scale factor 
    //println(speed);
    //if (x<= width/2+100) {

    beginShape();
    float bright = map(i, 0, 20000, 10, 100);
    //stroke(180,33, bright);
    //point(x+speed*n, y*n);
    point(y*pow(n, 1), x+speed*n);
    //vertex(x, y*n);
    //vertex(x*n, y);
    //vertex(x, y*n);
    //line(0,0,x,y);
    endShape(CLOSE);
    xoff += 0.05;

    //}
  }
  zoff+= 0.005;
  //noLoop();
}

void mousePressed() {
  saveFrame("renders/img###.png"); 
  println("captured");
}

//void rescale(){

//}
