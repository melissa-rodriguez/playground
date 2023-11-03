import peasy.*;
PeasyCam cam;
OpenSimplexNoise noise;
void settings(){
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
}

void setup() {
  cam = new PeasyCam(this, 975);
  noise = new OpenSimplexNoise();
}
float t, i, h=100, a,d, speed = 0.005, k=100;
int click = 0;;
int[] goodNumsY = {1,4,8,15,23,30,45,46,60,69,92,125,176,314,330,345,352,357,368};
void draw() {
  t+=.05;
  background(0);
  //lights();
  //rotateX(radians(75));
  
  //println(mouseX);
  
  for (float x = -40; x < width+40; x += 25) {
    for (float y = -40; y < height+40; y += 25) {
      if (i<k) {
        float p = (i+t)/k;
        //if (mousePressed) {
        // d = dist(x, y, -mouseX, -mouseY);
        //  //a+=0.005;
          
        //}
        float n = (float) noise.eval(x,y,t);
        d = dist(x, y, width/2, height/2);
        float d2 = dist(x, y, width/2, height/2+200);
          a+=0.002;
        
        float offset = 200*((sin(radians(a-d))));
        float mapdist = map(d, 0, width/2, offset, 5);
        float bright = n > 0 ? 255 : 0;
        //float bright = map(n, -1, 1, 5, 50);
        //fill(255*p);
        //y += sqrt(p)*cos(TAU*p);

        //if(d < 100){
        // h = 100; 
        //}else{h=40;}
        //println(offset);
        rotateY(radians(goodNumsY[2]));
        //rotateX(radians(3));
        fill(0);
        stroke(255*map(d, 0, width/2, 0, 1));
        //println(goodNumsY[click]);
        push();
        translate(x-width/2, y-height/2, 0 );
        //rotate(TAU*p);
        box(20, 20, h+mapdist);

        pop();
      } 
      
      else {
        i = 0;
      }
    }
  }
  //i++;
  
  //if(frameCount<=98){
  //saveFrame("output/gif###.png");
  //println(frameCount);
  //}
  //else{exit();}
}

void mousePressed(){
 click ++; 
}
