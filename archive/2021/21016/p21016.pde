OpenSimplexNoise noise;

void setup() {
  size(1080, 1080);
  background(240);
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

  speed = frameCount* 2;
  //rotate(radians(-25));
  //lineDown = map(sin(radians(frameCount)), -1, 1, round(0), round(100));
  for (float i = 0; i < 20000; i++) {
    
    float t = radians(i);
    float x = t * cos(t);
    float y = t * sin(t);
    float n = (float) noise.eval(xoff, y, zoff);
    //println(speed);
    //if (x<= width/2+100) {

    beginShape();
    float bright = map(i, 0, 20000, 10, 100);
    //stroke(180,33, bright);
    //vertex(x+speed*n, y);
    //vertex(x, y*n);
    //vertex(x*n, y);
    //vertex(x, y*n);
    line(0,0,x,y);
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
