OpenSimplexNoise noise;
void setup() {
  size(1080, 1080);
  pixelDensity(2); 
  noise = new OpenSimplexNoise();
}
float t, p, s, k = 500;
void draw() {
  t+=.005;
  background(0);
  noStroke();
  //for (int i=0; i<width; i+=1) {
  //  for (int j=0; j<height; j+=1) {
  //    if ((i^j)%20==0) {
  //      square(i, j, 5+6*sin(PI*t-dist(i, j, width/2, height/2)*.02));
  //    }
  //  }
  //}
  float space = 0;
  for (int i= 0; i < k; i++) {
    //if(pow(i,k) % 9 ==0){
    p = 1.0*(i+t)/k;
    float xpos = width/2;
    float ypos = width*p;
    float scale = 0.002;
    float n = noise(xpos*scale, ypos*scale);
    float size = 70*sin(TAU*(p-t)-dist(xpos*sin(TAU*(p-t)), ypos*n, width/2, height/2)*.02);
    push();
    translate(p*easeInOutCubic(sin(TAU*(p-t))), 0);
    rectMode(CENTER);
    float off = easeInOutCubic(map(sin(TWO_PI*(t+offset(xpos, ypos))), -1, 1, 0, 1));
 
    stroke(255, 100*off);
    //noFill();
    //rect(xpos, ypos, size+300*sqrt(p)*map(sin(TWO_PI*(t+0.05*ypos)),-1,1,0,1), size * 0.02);
    rect(xpos, ypos, size+300*sqrt(p)*off - 10*sin(TAU*exp(p*t))*pow(cos(TAU*p), 2), size * 0.02);
    pop();
    //square(xpos+200, ypos, size+30);

    if (xpos > width) {
      xpos = 20;
    }
    //}
  }
  
  //if(frameCount <= 100){
  // saveFrame("output/gif###.png");
  //}
  //else{
  // println("done");
  // exit();
  //}
}

float offset(float x, float y) {
  float distance = dist(x, y, width/2, height/2);
  float perlin_noise_intensity = easeInOutCubic(constrain(map(distance, 0, .05*height, 1, 0), 0, 1));

  float scale = 0.002;
  float result = -0.05*y -0.05*x + 60*(noise(scale*x, scale*y)-0.5)*perlin_noise_intensity;
  return result;
}

//float ease(t){
//  t *= 2;
//    if (t < 1) {
//      return 0.5 * t * t * t;
//    }
//    t -= 2;
//    return 0.5 * (t * t * t + 2);
//  }
//}
