import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;
PFont font;

void settings(){
 smooth(8);
 pixelDensity(2);
 size(900, 900, P3D);
}
void setup() {
  cam = new PeasyCam(this, 2000);
  noise = new OpenSimplexNoise();
  font = createFont("Russo.ttf", 50);
}

float p, i, t, k = 1;
float size = 10, len = 300;
void draw() {
  //clear();
  t += 0.01;
  rotateX(PI/2);
  strokeWeight(2);
  //println(mouseY);
  //350 370
  
  
  float rot = map(mouseX, 0, width, 350, 370);
  if (count%2==0) {
    background(0);
    stroke(255);
    fill(0);
    rotateX(radians(350));
    push();
    fill(255);
    textFont(font);
    textAlign(CENTER, CENTER);
    //text("wavy.", 0, 630-height);
    pop();
  } else {
    background(240);
    stroke(0);
    fill(240);
    rotateX(radians(370));
    push();
    fill(0);
    textFont(font);
    textAlign(CENTER, CENTER);
    rotate(radians(180));
    //text("wavy.", 0, 630-height);
    pop();
  }
  //println(mouseX);
  for (i = 0; i < k; i++) {
    p = (i+t)/k;
    for (float x = -width/2; x < width/2; x += size+5) {
      beginShape();
      noFill();
      for (float z = -1000; z < 1000; z += size+5) {
        push();
        translate(x, 0, z);
        float scale = 0.005;
        float n = (float) noise.eval(x*scale, z*scale, t*4);
        float d = dist(x, 0, z, 0, 0, 0);
        float md = map(d, 0, width, 10, 400);
        rotateY(TAU*n);
        curveVertex(x,len*n, z);
        //box(size, len*n, size);
        pop();
      }
      endShape();
    }
  }

  push();
  stroke(255);
  rectMode(CENTER);
  translate(0, height/2, 0);
  //fill(0);
  //rect(0, 0, width+70, 3000);
  pop();
  //if(t>1){
  // t = 0; 
  //}
  
  //if(t <1){
  // saveFrame("output/gif###.png");
  //}
  //else{exit();}
}
int count = 0;
void mousePressed(){
 //saveFrame("output.png");
 //count++; 
}
