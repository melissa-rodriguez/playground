PImage img;
PFont font;

void setup(){
 size(1080,1080, P3D);
 img = loadImage("coin.png");
 img.resize(1080/10, 1080/10);
 pixelDensity(2);
 font = createFont("RobotoSlab-Medium.ttf", 256);
 textFont(font, 32);
}


float amount = 1;
String coin = "c  in";
void draw(){
 background(240);
 fill(0);
 
 push(); 
   textAlign(CENTER, CENTER);
   textSize(400);
   text(coin, width/2, height/2);
   
   push();
     translate(width/2, height/2+500);
     rotateX(radians(543));
     fill(0,0,0,45);
     text(coin, 0, 0);
   pop();
   
 pop();
 
 
 translate(width/2-87, height/2+114);
 //println(mouseY);
 imageMode(CENTER);

 
 
 
 
 
 rotateY((radians(frameCount)));
 
 for(float i = 1; i <= 2; i ++){
   rotateY(PI/i);
   //println(PI/i);
   image(img, 0, sin(radians(frameCount))*30, 1080/6, 1080/6+50);
   
   push();
   tint(255, 45);
   image(img, 0, -sin(radians(frameCount))*30 + 300, 1080/6, 1080/6+50);
   pop();
 }
   
 

  //rec();
 }

 
 
 //push();
 //rotateY(PI/2);
 //image(img, 0, 0, 1080/2, 1080/2);
 //pop();
 
 
