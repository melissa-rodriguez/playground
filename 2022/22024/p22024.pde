void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  colorMode(HSB);
  rectMode(CENTER);
}

int off; 
int render = 1; 
void draw() {
  //if (off == 40 || off == 50) {
  //  background(0);
  //} else {
  //  background(240);
  //}
  background(155+off, map(3, 0, 5, 0, 360), 50);
  translate(width/2, height/2);
  noStroke();
  fill(0);
  //println(mouseX);
  println(off); 

  int amt = 5; 



  for (int i = 0; i <= amt; i ++) {
    float x = map(i, 0, amt, -width/4, width/4);
    if (i == amt-2) {
      //highlight
      //println(i); 
      fill(0+off, map(i, 0, amt, 50, 255), 255);
    } else {
      //base
      fill(155+off, map(i, 0, amt, 50, 255), 255);
      //fill(map(i, 0, amt, 50, 255));
    }
    rect(x, 0, (width/2)/amt, width*0.15);
  }

//  if (off < 100) {
//    saveFrame("output/render"+str(render)+".png"); 
//    render++; 
//    off+=10;
//  }else{
//   exit();  
//  }
  
  
  
  //println(render); 
}

void mousePressed() {
  //saveFrame("render.png"); 
  off+=10;
}
