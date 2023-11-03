// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Flow Field Following

class FlowField {

  // A flow field is a two dimensional array of PVectors
  PVector[][] field;
  int cols, rows; // Columns and Rows
  int resolution; // How large is each "cell" of the flow field
  
  float w, h, stop; //width, height, and stop angle of the arcs
  float sw; //strokeweight
  color col;

  FlowField(int r) {
    resolution = r;
    // Determine the number of columns and rows based on sketch's width and height
    cols = width/resolution;
    rows = height/resolution;
    field = new PVector[cols][rows];
    
    w = random(100);
    h = random(80);
    stop = random(0, PI);
    col = colorArray[int(random(colorArray.length))];
    
    //sw = random(0.5, 2);
    init();
  }

  void init() {
    // Reseed noise so we get a new flow field every time
    //noiseSeed((int)random(10000));
    noiseSeed(3);
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        
        //float theta = map(noise(xoff,yoff),0,1,0,TWO_PI);
        float x = map(i, 0, cols, 0, width);
        float y = map(j, 0, rows, 0, height/2);
        float theta = cos(radians(x))+sin(radians(y));
        sw = map(sin(theta), -1, 1, 0.5, 2);
        // Polar to cartesian coordinate transformation to get x and y components of the vector
        field[i][j] = new PVector(sin(theta),cos(theta));
        yoff += 0.1;
      }
      xoff += 0.1;
    }
  }

  // Draw every vector
  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        drawVector(field[i][j],i*resolution,j*resolution,resolution-2);
      }
    }

  }

  // Renders a vector object 'v' as an arrow and a position 'x,y'
  void drawVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    float arrowsize = 4;
    // Translate to position to render vector
    translate(x,y);
    stroke(255);
    noFill();
    strokeWeight(sw);
    //println(mouseX);
    
    // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
    rotate(v.heading2D());
    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*scayl;
    // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
    //line(0,0,len,0);
    arc(0, 0, w, h, 0, map(200, 0, width, 0, PI)); 
    //line(len,0,len-arrowsize,+arrowsize/2);
    //line(len,0,len-arrowsize,-arrowsize/2);
    popMatrix();
  }

  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution,0,cols-1));
    int row = int(constrain(lookup.y/resolution,0,rows-1));
    return field[column][row].get();
  }


}
