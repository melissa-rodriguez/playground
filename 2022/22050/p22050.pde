ArrayList<LineType> lines;

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  rectMode(CENTER); 
  colorMode(HSB); 
  lines = new ArrayList<LineType>(); 
  lines.add(new LineType(100, height/2));
}

void draw() {
  background(240); 

  for (LineType line : lines) {
    line.render();
  }
}

class LineType {
  float size = 50; 
  PVector pos; 
  int lineType; 
  String type = ""; 
  String prevType = ""; //store the previous type

  float startAngle = 0; 
  float endAngle = 0; 

  LineType(float x, float y) {
    pos = new PVector(x, y);
    lineType = int(random(1, 9)); //up to but not including 10
    //lineType = 8; //up to but not including 10
  }

  void render() {
    noFill(); 
    stroke(0); 

    type = type(lineType); 


    if (type == "TR") {           //top right
      startAngle = -PI/2; 
      endAngle = 0;
    } else if (type == "TL") {     //top left
      startAngle = PI; 
      endAngle = PI/2+PI;
    } else if (type == "TE") {      //top end
      startAngle = PI; 
      endAngle = TAU;
    } else if (type == "BR") {      //bottom right
      startAngle = 0; 
      endAngle = PI/2;
    } else if (type == "BL") {      //bottom left
      startAngle = PI/2; 
      endAngle = PI;
    } else if (type == "BE") {      //bottom end
      startAngle = 0; 
      endAngle = PI;
    } else if (type == "RE") {      //right end
      startAngle = -PI/2; 
      endAngle = PI/2;
    } else if (type == "LE") {      //left end
      startAngle = PI/2; 
      endAngle = PI/2+PI;
    }


    arc(pos.x, pos.y, size, size, startAngle, endAngle, OPEN); 

    push();
    stroke(0, 255, 255); 
    noFill(); 
    square(pos.x, pos.y, size); 
    pop();
    prevType = type;
  }

  String type(int lineType) {
    if (lineType == 1) {
      //top right corner
      type = "TR";
    } else if (lineType == 2) {
      //top left corner
      type = "TL";
    } else if (lineType == 3) {
      //top end
      type = "TE";
    } else if (lineType == 4) {
      //bottom right
      type = "BR";
    } else if (lineType == 5) {
      //bottom left
      type = "BL";
    } else if (lineType == 6) {
      //bottom end
      type = "BE";
    } else if (lineType == 7) {
      //right end
      type = "RE";
    } else if (lineType == 8) {
      //left end
      type = "LE";
    } else {
      return null;
    }

    return type;
  };
}

void mousePressed() {
  //for (LineType line : lines) {
  //  lines.add(new LineType());
  //}
  PVector prevPos  = new PVector(0, 0); 
  String lastType = ""; 
  float size; 

  LineType lastLine = lines.get(lines.size()-1); 
  prevPos = lastLine.pos; 
  lastType = lastLine.type;
  size = lastLine.size;

  println(lastType); 
  lines.add(new LineType(prevPos.x+size, prevPos.y));
  
  //saveFrame("output.png");
}
