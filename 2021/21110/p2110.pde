void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  background(240);
  //blendMode(DARKEST);
}

float speed=1;
float x;
void draw() {
  //clear();
  background(240);
  //x=0;
  fill(0);
  noStroke();

  translate(width/2, height/2);
  for (float i = -width; i<width*2; i+=50) {

    for (float j = -height; j<height*2; j+=50) {
      push();
      rotate(-PI/4);
      if (dist(i, j, 0, 0)<width/3) {
        circle(i, j, 10);
      } 
        if(x<=100){
        circle(i, j+x, 10);
        }
        else if(x>100&&x<=200){
         circle(i+x, j, 10);
        }
        else if(x>200&&x<=300){
         circle(i, j-x, 10);
        }
        else if(x>300&&x<=400){
         circle(i-x, j, 10);
        }else if(x>400){
         x=0; 
        }
      
      pop();
    }
    
  }
  x+=speed*2;
  //if(x<=400){
  //  saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
  //println(x);
}
