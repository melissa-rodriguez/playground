PFont font;
void setup() {
  size(1080, 1080, P2D); 
  pixelDensity(2);
  background(240);
  font = createFont("rocksalt.ttf", 35);
  textAlign(CENTER, CENTER);
  textFont(font);
  //colorMode(HSB, 100);
}

float ypos;
float xpos=360;
int weight;
void draw() {
  noiseSeed(2);

  text("cirlce", width/2, height/2-10);
  pushMatrix();
  fill(0);

  if (xpos < 720) {
    point(xpos, 720 - ypos);
    point(xpos, 360 + ypos);
    point(360+ypos,xpos);
    point(720-ypos,xpos);
  }


  strokeWeight(weight);
  xpos+=(ypos)/10;
  ypos=map(noise(tan(radians(frameCount))), 0, 1, 0, 30);
  weight=int(map(noise(tan(radians(frameCount))), 0, 1, 0, 10));
  popMatrix();



}
