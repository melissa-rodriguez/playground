
Cloud cloud; 
boolean brushDown=true; 

void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  smooth(8);
  cloud = new Cloud(); 






  background(240);
  colorMode(HSB);

  //rectMode(CENTER);
}


void draw() {
  //brush.render(); 
  //brush.update();
  background(155,50,255); 
  for (int i = 0; i < 3; i++) {
    cloud.render();
  }


  //noLoop();
}

class Cloud {
  int amt = int(random(2, 10)); 
  float area = 800; //size of area you want subcanvases in 
  float w = area/amt; 
  float tallestH =  550; //size of tallest rect
  float x; 
  float y;


  ArrayList<subCanvas> canvases; 

  Cloud() {

    canvases = new ArrayList<subCanvas>();


    for (int i = 0; i < amt; i ++) {
      println(i); 
      float theta = map(i, 0, amt, 0, PI); 
      //float h = map(i, 0, amt, tallestH, tallestH/10); 
      float h = tallestH*map(sin(theta), -1, 1, 0, 1); 
      x = ((width-area)/2) + w*i; 
      y = (height/2-tallestH/2) + (tallestH-h); 
      PVector cpos = new PVector(x, y); 
      canvases.add(new subCanvas(cpos, w, random(h/2, h)));
    }
  }

  void render() {
    push();
    base(); 
    pop();
  }

  void base() {
    int count = 0; 
    for (subCanvas canvas : canvases) {
      //canvas.showSubCanvas();
      color col = color(155, 155, 20);
      canvas.render(col);
      count++;
    }
  }
}


class subCanvas {
  PVector posCanvas; 
  PVector posBrush; 
  float h; //height of mini canvas
  float w; // width of mini canvas
  ArrayList<Brush> brushes;
  int density = 100; //how many brushes circles are in a canvas


  subCanvas(PVector cpos, float w_, float h_) {
    w = w_;
    h = h_; 

    posCanvas = cpos; 
    brushes = new ArrayList<Brush>(); 

    //println(posCanvas.x); 

    for (int i = 0; i < density; i ++) {
      //println("here"); 
      posBrush = new PVector(posCanvas.x + random(0, w), posCanvas.y + random(0, h)); 
      brushes.add(new Brush(posBrush, w, h)); //every canvas has a new brush
    }
  }

  void render(color col) {
    //brush.render(); 
    //brush.update();

    for (Brush b : brushes) {
      b.render(col);
    }
  }


  void showSubCanvas() {
    push(); 
    strokeWeight(3); 
    stroke(0, 255, 255); 
    noFill(); 
    circle(posCanvas.x+w/2, posCanvas.y+h/2, 20); 
    //circle(posCanvas.x, posCanvas.y, 20); 
    rect(posCanvas.x, posCanvas.y, w, h); 
    pop();
  }
}


class Brush {
  PVector center; 
  float numPoints = 500;
  float r; 
  float size = 50; 
  float theta; 
  PVector move; 

  PVector gradientCenter; 
  PVector lightSource = new PVector(width/2, height/2+200); //used for dist func to calc gradient color
  PVector shaddowSource = new PVector(width/2, height/2 - 400); 

  ArrayList<PVector> points = new ArrayList<PVector>(); 

  Brush(PVector pos, float w, float h) {
    //center = new PVector(x, y);

    gradientCenter = new PVector(width/2, height/2); 

    center = new PVector(pos.x, pos.y); 
    //move = PVector.random2D(); 

    for (float i = 0; i < numPoints; i++) {
      r = size*sqrt(random(1)); 
      theta = random(TAU); 
      float xpos = r*cos(theta); 
      float ypos = r*sin(theta); 
      points.add(new PVector(xpos, ypos));
    }
  }

  void update() {
    //if (frameCount%5==0) {
    //  move = PVector.random2D();
    //}
    move = PVector.random2D(); 

    float rand = sqrt(random(1)); 
    move.mult(5); 
    center.add(move);
  }

  void render(color col) {
    for (PVector pt : points) { 
      if (brushDown) {
        //stroke(map(dist(ptx, pty, gradientCenter.x, gradientCenter.y), 0, width/2, 255, 155), 155, 255); 
        float d = dist(center.x+pt.x, center.y+pt.y, lightSource.x, lightSource.y);
        stroke(map(d, 0, 1200, 200, 100), 200, 255); 
        point(center.x+pt.x, center.y+pt.y); 


        //line(ptx, pty, ptx + 100*noise(ptx, pty), pty+100*noise(ptx,pty));
      }
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      brushDown = false;
    } else if (keyCode == DOWN) {
      println("here"); 
      brushDown = true;
    }
  }
}

void mousePressed() {
  saveFrame("output###.png");
}
