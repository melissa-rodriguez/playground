OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
}

float p, i, t, k =1;
float a = 0;
void draw() {
  background(0);
  t+=0.01;
  
  for (i = 0; i < k; i++) {
    p = (i+t)/k; 

    for (float x = 0; x < width; x+=10) {
      for (float y = 0; y < height; y+=10) {
        float n = map((float)noise.eval(x*0.03, y*0.03,t*10),0,1,0.2,1);
        fill(255*(1-n));
        push();
        float d = dist(x, y, width/2, height/2);
        if (d < 400) {
          translate(x, y, y*cos(a)*sin(PI*p/12));
          circle(0, 0, 5);
        } else {
          translate(x, y, 0);
          circle(0, 0, 5);
        }
        pop();
        a+=0.001;
        if (a > TAU) {
          a=0;
        }
        
      }
    }
  }
  if(t>1){
   t=0; 
  }
  
  
}
