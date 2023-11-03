ArrayList<Arc> arcs; 
int ires = 10; 
int jres = 10; 


void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);

  arcs = new ArrayList<Arc>(); 
  float rightMargin = width*0.10; 
  float leftMargin = width-rightMargin; 

  float topMargin = rightMargin; 
  float bottomMargin = height - rightMargin; 

  for (int i = 0; i <= ires; i++) {
    for (int j = 0; j <= jres; j++) {
      float x = map(i, 0, ires, leftMargin, rightMargin);
      float y = map(j, 0, jres, topMargin, bottomMargin); 
      //point(x, y); 
      //arc(x, y, width/ires, height/jres, PI/6, PI/6 + PI); 
      arcs.add(new Arc(x, y));
    }
  }
}

void draw() {
  background(240); 


  //strokeWeight(1); 
  noFill(); 

  for (Arc a : arcs) {
    a.render();
  }
  //circle(width/2, height/2, 200);
}

class Arc {
  PVector pos; 
  float size; 
  float startAngle, endAngle; 
  int amt; //amt of arcs drawn at each point

  Arc(float x, float y) {
    pos = new PVector(x, y); 
    size = ((width - width*0.10) - width*0.10)/ires; 
    //startAngle = random(TAU); 
    startAngle = TAU*randomGaussian(); 
    endAngle = startAngle+PI;
    
    amt = int(20*sqrt(random(1)));
  }

  void render() {
    stroke(0); 
    strokeWeight(5);
    //for (int i = 0; i < amt; i++) {
    //  stroke(map(i, 0, amt, 0, 220)); 
    //  arc(pos.x + 10*i, pos.y, size, size, startAngle, endAngle);
    //}
    
    for (int i = 0; i < amt; i++) {
      stroke(map(i, 0, amt, 0, 230)); 
      arc(pos.x, pos.y+2.5*i, size, size, startAngle, endAngle);
    }
     
    //arc(pos.x, pos.y, size, size, startAngle, endAngle);
  }
}

void mousePressed(){
 saveFrame("output###.png");  
}
