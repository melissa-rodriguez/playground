import peasy.*;
PeasyCam cam;
void setup(){
  size(1080, 1080, P3D);
  pixelDensity(2);
  cam = new PeasyCam(this, 3000);
}

float p,i,t,k=100;
void draw(){
  background(0);
  noStroke();
  /*
  M: 01001101
  R: 01010010
  */
  t+=0.01;
  p = (i+t)/k;
  float spacing = 300;
  translate(-width, 0);
  push();
  binNum(false,false); //0
  translate(spacing, 0, 0);
  binNum(true,false); //1
  translate(spacing, 0, 0);
  binNum(false,false); 
  translate(spacing, 0, 0);
  binNum(false,true); 
  translate(spacing, 0, 0);
  binNum(true,true); 
  translate(spacing, 0, 0);
  binNum(true,true); 
  translate(spacing, 0, 0);
  binNum(false,true); 
  translate(spacing, 0, 0);
  binNum(true,true); 
  pop();
  
 
  push();
  stroke(255);
  strokeWeight(5);
  line(-100, 200, 2200, 200);
  pop();
  i++;
  if(t>1){t=0; i = 0;}
  
  if(frameCount<101){
   //saveFrame("output/gif###.png");
  }
  else{
   //exit(); 
  }
  
}

void binNum(boolean one, boolean changeNum){
  float numPoints = 500;
  float radius = 100;
  for(float a = 0; a < TAU; a+=TAU/numPoints){
    //circle(radius*cos(a), radius*sin(a), 10); 
    push();
    if(one){
     rotateY(PI/2); 
    }
    if(changeNum){
    rotateY(map(easeInOutBack(sin(PI*p)), 0, 1, 0, PI/2));
    }
    translate(radius*cos(a), radius*sin(a));
    box(50);
    pop();
  }
}

//void one(){
//  float numPoints = 500;
//  float radius = 100;
//  for(float a = 0; a < TAU; a+=TAU/numPoints){
//    //circle(radius*cos(a), radius*sin(a), 10); 
//    push();
//    rotateY(PI/2);
//    rotateY(map(easeInBounce(sin(PI*p)), 0, 1, 0, PI/2));
//    translate(radius*cos(a), radius*sin(a));
//    box(10);
//    pop();
//  }
//}
