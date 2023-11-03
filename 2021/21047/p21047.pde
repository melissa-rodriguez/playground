OpenSimplexNoise noise;
void setup() {
  size(1080, 1080, P2D);
  pixelDensity(2);
  noise = new OpenSimplexNoise();
}
float t, x, y, i, p, a, k=5000;
void draw() {
  t+=.005;
  translate(width/2, height/2);
  background(0);
  for (i=0; i<k; i++) {
    p=1.0*(i+t)/k;
    float m = map(mouseX, 0, width, 0, 5);
    a=sin(2*TAU*(p-t)) - pow(cos(TAU*(p-t)), 0.15);
    float sn = (float) noise.eval(500*p*cos(TAU*(p-t +pow(i, 3))), 500 *p*a);
    noStroke();
    
    
    //println(m);
    //float xpos = 400*p*cos(TAU*(p-t +pow(i,1.14)));
    //float ypos = 300 *p*a*sin(TAU*(p-t +pow(i, 1.14)));
    
    float xpos = 400*p*cos(TAU*(p-t +pow(i,PI/10)));
    float ypos = 300 *p*a*sin(TAU*(p-t +pow(i, PI/10)));
    fill(255, 100);
    circle(xpos, ypos, 4*a);
  }
  
  //if(frameCount <=100){
  //saveFrame("output/gif###.png");
  //}
  //else{
  // exit(); 
  //}
}
