OpenSimplexNoise noise;
boolean recFrames = false;
void setup() {
  size(1080, 1080, P2D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
}
float t, x, y, i, p, a, k=800;
void draw() {
  t+=.005;
  translate(width/2, height/2);
  background(0);
  strokeWeight(2);
  beginShape();
  curveTightness(0);
  for (i=0; i<k; i++) {
    p=1.0*(i+t)/k;
    float m = map(sin((p-t))*cos(p-t), -1, 1, 0, 1.14);
    float sn = (float) noise.eval(500*p*cos(TAU*(p-t +pow(i, 3))), 500 *p*a);
    float mou = map(sin(radians(mouseX)), -1, 1, 0, 255);

    a=sin(TAU*(p-t))-cos(TAU*(p-t));

    //noStroke();
    //println(a);

    //println(m);
    //float xpos = 400*p*cos(TAU*(p-t +pow(i,1.14)));
    //float ypos = 300 *p*a*sin(TAU*(p-t +pow(i, 1.14)));

    float xpos = 400*p*cos(TAU*(p-t +pow(i, m)));
    float ypos = 300 *p*a*sin(TAU*(p-t +pow(i, m)));
    //fill(255);
    stroke(255*sin(radians(frameCount*0.6)), 50);
    noFill();
    //circle(xpos, ypos, 4*a);
    //strokeWeight(4*a);
    //point(xpos, ypos);
    curveVertex(xpos, ypos);
  }
  endShape();

  //if(frameCount <=100){
  //if (recFrames) {
    //saveFrame("output/gif###.png");
  //}
  //}
  //else{
  // exit(); 
  //}
  //rec();

  //saveFrame("output/gif###.png");
}

void mousePressed(){
 recFrames = true; 
}
