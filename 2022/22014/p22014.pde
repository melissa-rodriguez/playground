import peasy.*;
PeasyCam cam;

Box box; 

ArrayList<Tile> tiles = new ArrayList<Tile>(); 


void setup() {
  size(1080, 1080, P3D); 
  pixelDensity(2);
  cam = new PeasyCam(this, 800);
  rectMode(CENTER); 
  int numBoxes = 1; 
  smooth(8);
  box = new Box();
}

void draw() {
  background(0);
  //circle(0, 0, 200);
  //push(); 
  //noFill(); 
  //square(0, 0, 400); 
  //pop();

  box.show(); 
  box.update();
  
  for(Tile t : tiles){
   t.showTile();  
  }
  
}


class Box {
  PVector pos, vel, acc; 
  int size; 
  float theta; 
  float speed = 3; 
  int count = 1;

  Box() {
    size = 50;
    pos = new PVector(0, 0, 0);
    vel = new PVector(0, 0, 0); 
    acc = new PVector(0, 0, 0);
  }

  void show() {
    stroke(255); 
    strokeWeight(3); 
    fill(0); 
    noFill(); 

    push();
    translate(pos.x, pos.y, pos.z); 

    if (count < 6) {
      rotateX(-theta);
    } else if (count < 12 && count >= 6) {
      rotateY(theta);
    } else {
      rotate(-theta);
    }
    box(size); 
    pop();
  }

  void update() {
    pos.add(vel); 
    vel.add(acc); 
    theta+=radians(speed);





    if (theta >= PI/2) {
      count++; 
      theta = 0;
    }




    if (count < 3) {
      vel.x = 0; 
      vel.y = 0;
      vel.z = speed;
    } else if (count == 3) { 
      vel.x = 0; 
      vel.y = speed;
      vel.z = 0;
    } else if (count == 6) {
      vel.x = speed; 
      vel.y = 0; 
      vel.z = 0;
    } else if (count == 9) {
      vel.x = 0; 
      vel.y = 0; 
      vel.z = -speed;
    } else if (count == 12) {
      vel.x = 0; 
      vel.y = -speed; 
      vel.z = 0;
    } else if (count == 15) {
      vel.x = -speed; 
      vel.y = 0; 
      vel.z = 0;
    } else if (count == 18) {
      count = 1; 
      theta = 0;
    }


    ////reset
    //  if (count > 1 && pos.x < 0) {
    //    pos.x=0; 
    //    count = 1;
    //    theta=0;
    //  }
  }
}

class Tile {
  PVector tilePos; 
  float size; 
  Tile(PVector p, float s) {
    tilePos = p;
    size = s; 
  }
  
  void showTile(){
   push();
   translate(tilePos.x, tilePos.y, tilePos.z); 
   box(size, 10, size); 
   pop();
  }
}
