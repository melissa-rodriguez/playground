ArrayList<Rect> roundRects; 
OpenSimplexNoise noise; 
void setup() {
  size(1080, 1080, P3D);
  pixelDensity(2);
  smooth(8);
  
  colorMode(HSB); 

  noise = new OpenSimplexNoise(); 

  rectMode(CENTER);

  roundRects = new ArrayList<Rect>(); 

  int ires = 10; 
  int jres = 10; 
  float h = height/jres; 
  float w = h/2; 


  for (int i = 0; i <= ires; i++) {
    for (int j = 0; j <= jres; j++) {
      float x = map(i, 0, ires, -width/2, width/2); 
      float y = map(j, 0, jres, -height/2, height/2);
      PVector pos = new PVector(x, y); 

      roundRects.add(new Rect(pos, w, h));
    }
  }
}

void draw() {
  background(0);
  //background(#0101A3); 
  translate(width/2, height/2);

  for (Rect r : roundRects) {
    r.show();
  }
}

class Rect {
  PVector pos; 
  float w, h; 
  int ires, jres; 
  float cornerR; 
  float angle; 
  Rect(PVector p, float rectWidth, float rectHeight) {
    pos = p; 
    ires = int(20*sqrt(random(1)) + 1); 
    jres = int(20*sqrt(random(1)) + 1);
    w = rectWidth; 
    h = rectHeight;
    cornerR = rectWidth;

    float n = (float)noise.eval(pos.x*0.0003, pos.y*.0003); 
    float a = map(n, -1, 1, -PI, TAU);   
    angle = map(dist(pos.x, pos.y, -width/2, -height/2), 0, height, 0, a);
    
    //float a = round(5*(sqrt(random(1))));
    //if(a == 1){
      
    //}else if(a == 2){
    //  angle = 0; 
    //}else if(a ==3){
    //  angle = PI/2; 
    //}else{
    //  angle = PI/4;
    //}
  }

  void show() {

    noFill();
    stroke(255); 
    strokeWeight(3); 

    push(); 
    translate(pos.x, pos.y); 
    rotate(angle); 

    rect(0, 0, w, h, w); //outer rect

    for (int i = 0; i <= ires; i++) {
      for (int j = 0; j <= jres; j++) {
        float x = map(i, 0, ires, -w/2.2, w/2.2);
        float y = map(j, 0, jres, -h/2, h/2);  

        float d = dist(x, y, 0, -h/2+w/2); 
        float d2 = dist(x, y, 0, h/2-w/2); 
        
        
        if (d <= w/2 || d2 <= w/2) {
          point(x, y);
        }


        //point(x,y);
        //point(w/2*cos(a), mouseX+(w/(2))*sin(a));
      }
    }

    pop();
  }
}


void mousePressed(){
 saveFrame("output.png");  
}
