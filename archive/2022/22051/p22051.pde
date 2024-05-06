ArrayList<LineType> lines;

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  rectMode(CENTER); 
  colorMode(HSB); 
  lines = new ArrayList<LineType>(); 
  //lines.add(new LineType(width/2, height/2));

  float grid_w = width; 
  float grid_h = height; 

  int ires = 50; 
  int jres = 50; 

  for (int i = 0; i <= ires; i++) {
    for (int j = 0; j <= jres; j++) {
      float x = map(i, 0, ires, 0, grid_w); 
      float y = map(j, 0, jres, 0, grid_h); 
      float rand = sqrt(random(1)); 
      if (rand <1) {
        lines.add(new LineType(width/2 - grid_w/2 + x, height/2 - grid_h/2 + y, 
                                ires, jres, grid_w, grid_h));
      }
    }
  }
}

void draw() {
  background(240); 

  for (LineType line : lines) {
    line.render();
  }
  
  saveFrame("output.png"); 
}

class LineType {
  //float size; 
  PVector pos; 
  int lineType; 
  String type = ""; 
  String prevType = ""; //store the previous type

  float startAngle = 0; 
  float endAngle = 0; 
  float sizeX, sizeY; 
  color col; 

  LineType(float x, float y, float ires, float jres, float grid_w, float grid_h) {
    pos = new PVector(x, y);
    lineType = int(random(1, 5)); //up to but not including 5
    sizeX = grid_w/ires; 
    sizeY = grid_h/jres; 
    println(sizeX); 
    //lineType = 4;
    //col = color(random(155, 180), 155, 255);
    col = color(0, 0, 0); 
  }

  void render() {
    noFill(); 
    //fill(col); 
    stroke(0); 
    strokeWeight(2);
    float alpha = 70; 
    color lineColor = color(0, 0, 0, alpha); 

    type = type(lineType); 


    if (type == "TR") {           //top right
      startAngle = -PI/2; 
      endAngle = 0;
      arc(pos.x-sizeX/2, pos.y+sizeY/2, sizeX*2, sizeY*2, startAngle, endAngle, OPEN); 
      arc(pos.x-sizeX/2, pos.y+sizeY/2, sizeX, sizeY, startAngle, endAngle, OPEN);
      arc(pos.x-sizeX/2, pos.y+sizeY/2, sizeX/2, sizeY/2, startAngle, endAngle, OPEN);
      
      //push();
      //stroke(lineColor); 
      //line(pos.x - sizeX/2, pos.y - sizeY/2, pos.x - sizeX/2-sizeX, pos.y-sizeY/2); 
      //line(pos.x + sizeX/2, pos.y + sizeY/2, pos.x + sizeX/2, pos.y+sizeY/2+sizeY);
      //pop(); 
    } else if (type == "TL") {     //top left
      startAngle = PI; 
      endAngle = PI/2+PI;
      arc(pos.x+sizeX/2, pos.y+sizeY/2, sizeX*2, sizeY*2, startAngle, endAngle, OPEN); 
      arc(pos.x+sizeX/2, pos.y+sizeY/2, sizeX, sizeY, startAngle, endAngle, OPEN); 
      arc(pos.x+sizeX/2, pos.y+sizeY/2, sizeX/2, sizeY/2, startAngle, endAngle, OPEN);
      
      //push();
      //stroke(lineColor);
      //line(pos.x - sizeX/2, pos.y + sizeY/2, pos.x - sizeX/2, pos.y+sizeY/2+sizeY); 
      //line(pos.x + sizeX/2, pos.y - sizeY/2, pos.x + sizeX/2+sizeX, pos.y-sizeY/2);
      //pop(); 
    } else if (type == "BR") {      //bottom right
      startAngle = 0; 
      endAngle = PI/2;
      arc(pos.x-sizeX/2, pos.y-sizeY/2, sizeX*2, sizeY*2, startAngle, endAngle, OPEN);
      arc(pos.x-sizeX/2, pos.y-sizeY/2, sizeX, sizeY, startAngle, endAngle, OPEN);
      arc(pos.x-sizeX/2, pos.y-sizeY/2, sizeX/2, sizeY/2, startAngle, endAngle, OPEN);
      
      //push();
      //stroke(lineColor);
      //line(pos.x - sizeX/2, pos.y + sizeY/2, pos.x - sizeX/2-sizeX, pos.y+sizeY/2); 
      //line(pos.x + sizeX/2, pos.y - sizeY/2, pos.x + sizeX/2, pos.y-sizeY/2-sizeY);
      //pop(); 
    } else if (type == "BL") {      //bottom left
      startAngle = PI/2; 
      endAngle = PI;
      arc(pos.x+sizeX/2, pos.y-sizeY/2, sizeX*2, sizeY*2, startAngle, endAngle, OPEN); 
      arc(pos.x+sizeX/2, pos.y-sizeY/2, sizeX, sizeY, startAngle, endAngle, OPEN);
      arc(pos.x+sizeX/2, pos.y-sizeY/2, sizeX/2, sizeY/2, startAngle, endAngle, OPEN);
      
      //push();
      //stroke(lineColor);
      //line(pos.x - sizeX/2, pos.y - sizeY/2, pos.x - sizeX/2, pos.y-sizeY/2-sizeY); 
      //line(pos.x + sizeX/2, pos.y + sizeY/2, pos.x + sizeX/2+sizeX, pos.y+sizeY/2);
      //pop(); 
    } 




    push();
    stroke(0, 255, 255); 
    noFill(); 
    //rect(pos.x, pos.y, sizeX, sizeY); 
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
      type = "BR";
    } else if (lineType == 4) {
      //bottom right
      type = "BL";
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
  float sizeX, sizeY; 

  LineType lastLine = lines.get(lines.size()-1); 
  prevPos = lastLine.pos; 
  lastType = lastLine.type;
  sizeX = lastLine.sizeX;
  sizeY = lastLine.sizeY;

  //lines.add(new LineType(mouseX, mouseY));
  //saveFrame("output.png");
}
