OpenSimplexNoise noise;
PFont font;
void setup() {
  size(1080, 1080);
  noise = new OpenSimplexNoise();
  font = createFont("train.ttf", 200);
  textFont(font);
  textSize(50);
}

int k = 100;
float numFrames = 20;
void draw() {
  float t = 1.0*(frameCount-1)%numFrames/numFrames;
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float scale = 2;
      
      float a = map(x, 0, width, -scale, scale);
      float b = map(y, 0, height, -scale, scale);
      
      float ca = a;
      float cb = b;
      int n=0;
      float z = 0;
      
      while(n < k){
        float p = 1.0*(n+t)/k;
        float aa = a*a - b*b;
        float bb = 2*a*b;
        
        a = aa+ca;
        b = bb+cb;
        
        if(abs(a + b) > 16){
          break;
        }
        
        n++;
      }
      
      /*
       swap the brightness values to invert filling mandelbrot/background
      */
      float bright = 0;
      if(n == k){
        bright = pixelColor(x,y,n,t);
      }
      
      int pix = (x + y * width);
      pixels[pix] = color(bright);
    }
  }
  updatePixels();

  push();
  println(mouseX);
  textAlign(CENTER, CENTER);
  text("mandelbrot",860, height/2-textAscent()/4);
  pop();
  
  //if(frameCount <= 100){
  // saveFrame("output/gif###.png"); 
  //}
  //else{
  // println("done");
  // exit();
  //}
 
}

float pixelColor(int x, int y, float n, float t){
  float offset = t+scalar_field_offset(x,y);
  float result = ease(map(sin(TWO_PI*(offset)),-1,1,0,1),3.0);
  return 255*result;
}

float ease(float p, float g) {
  if (p < 0.5)
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float scalar_field_offset(float x,float y){
  float scale = 0.003;
  float result = 40*noise(scale*x,scale*y);
  return result;
}
