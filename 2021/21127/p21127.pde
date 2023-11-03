import peasy.*;
PeasyCam cam;
void settings(){
    size(1080, 1080, P3D);
    pixelDensity(2);
    smooth(8);
}
PFont font;
void setup(){
  cam = new PeasyCam(this, 800);
  blendMode(DIFFERENCE);
  font = createFont("Bebas.ttf", 300);
  textFont(font);
}


float xpos, ypos, r=125, a; 
void draw(){
  background(0);
  push();
  textSize(250);
  textAlign(CENTER, CENTER);
  fill(30);
  translate(0,0);
  text("f    cus", 0, 0);
  pop();
  
  push();
  translate(-100, 20);
  stroke(255);
  strokeWeight(3);
  fill(255);
  circle(0, 0, r);
  
  
  
  fill(0);
  xpos = r*0.5*cos(a);
  ypos = r*0.5*sin(a);
  //circle(xpos, ypos, r);
  //rectMode(CENTER);
  //rect(-xpos*0.2, -ypos*0.2, r,r,10);
  
  circle(-xpos*0.2, -ypos*0.2, r);
  pop();
  a+=0.03;
  
  //if(a<TAU){
  //saveFrame("output/gif###.png");
  //}
  
}
