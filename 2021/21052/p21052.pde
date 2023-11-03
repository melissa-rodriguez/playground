OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
  noiseSeed(12345);
}

float t, z,a=0;
void draw() {
  background(0);
  int k = 20; //number of objects in the queue
  t += 0.005;
  float xPointRes = 10;
  float yPointRes = 20;
  //for(int i = 0; i < k; i++){
  // float p = 1.0*(i+t)/k;
  // drawThing(p);
  //}
  
  
  noFill();
  translate(width/2, height/2);
  
  //rotateX(mouseX*0.002);
  strokeWeight(2);
 println(mouseX);
  float inc = radians(mouseX);
  for (float y = -height; y < height; y += yPointRes) {
    beginShape();
    for (int x = -width; x < width; x += xPointRes) {
      //circle(x, 0, 10);  
      
      if( (x >= - width/3 && x <= width/3) && (y>=-height/3 && y <= height/3)){
       stroke(255); 
      }
      else{stroke(0);}
      if(dist(x,y, 0, 0)<250){
       //y = 10*noise(x,y,t);
      

      curveVertex(x, y+easeInOutBounce(sin(-TAU*((a-t)))));
      a+=inc;
      
      }else{
   
      curveVertex(x, y);
      }
      
    }
    endShape();
    
  }
  
  rectMode(CENTER);
  strokeWeight(10);
  stroke(255);
  square(0-10, 0, 732);
  
  //saveFrame("output/gif###.png");
  
}

void drawThing(float p) {
  //draw something depending on p
}
