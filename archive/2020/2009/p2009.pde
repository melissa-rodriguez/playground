PFont myFont;

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2); 
  smooth(8);
  myFont = createFont("Anton-Regular.ttf", 120);
  textFont(myFont);
}

float z = 150;
float y = 0;
float x = 0;


float angle = 0;


void draw() {

  background(240);
  fill(0);
  textSize(120);
  translate(width/2, height/2, 0);
  //rotateY(radians(mouseX));



  rotateX(radians(388*.2));



  //draw ballot box
  pushMatrix();
  rectMode(CENTER);
  stroke(0);
  strokeWeight(5);
  fill(240);
  translate(0, 100, -85);
  box(400, 275, 200 );



  popMatrix();


  // display and rotate text 
  pushMatrix();

  rotateX(map(-tan(radians(frameCount*.25))*100, 0, height, -PI, PI)); 


  pushMatrix();
  fill(0);
  textAlign(CENTER, CENTER);
  rotateX(radians(-120));
  text("EVERY", x, y, z);
  pushMatrix();
  fill(240);
  translate(x, y+10, z-5);
  rect(0, 0, 270, 150);
  //box(200,200,0);
  popMatrix();

  popMatrix();

  pushMatrix();
  fill(0);
  textAlign(CENTER, CENTER);
  rotateX(radians(-240));
  text("COUNT", x, y, z);

  pushMatrix();
  fill(240);
  translate(x, y+10, z-5);
  rect(0, 0, 290, 150);
  //box(200,200,0);
  popMatrix();

  popMatrix();

  pushMatrix();
  fill(0);
  textAlign(CENTER, CENTER);
  rotateX(radians(-360));
  text("VOTE", x, y, z);
  //println(mouseX, mouseY);

  pushMatrix();
  fill(240);
  translate(x, y+10, z-5);
  rect(0, 0, 250, 150);
  //box(200,200,0);
  popMatrix();
  popMatrix();

  popMatrix();

  //draw ballot slip
  pushMatrix();
  noFill();
  translate(0, 150, 17);
  box(310, 30, 0);
  popMatrix();
  
 



  //pushMatrix();
  //fill(240);
  ////noStroke();
  //translate(0, 80, 300);
  //rotateX(radians(mouseY));
  //box(300, 100, 300);  
  //popMatrix();




}
