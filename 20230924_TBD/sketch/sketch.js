let shape; 

function setup(){
  createCanvas(1000, 1000); 

  shape = new CornerSquare(); 
}

function draw(){
  background(240); 

  shape.show();
}

class CornerSquare{
  constructor(){
    this.pos = createVector(width/2, height/2); 
    this.w = 200; 
    this.h = 200; 

    this.uLeft_pos = createVector(this.pos.x - this.w/2, this.pos.y - this.h/2); //upper left pos
    this.uRight_pos = createVector(this.pos.x + this.w/2, this.pos.y - this.h/2); //upper right pos
    this.lLeft_pos = createVector(this.pos.x - this.w/2, this.pos.y + this.h/2); //lower left pos
    this.lRight_pos = createVector(this.pos.x + this.w/2, this.pos.y + this.h/2); //lower right pos

    this.uLeft_fill = false;
    this.uRight_fill = false; 
    this.lLeft_fill = false; 
    this.lRight_fill = false; 

    let corner = ["uLeft", "uRight", "lLeft", "lRight"]; 

    //pick a start point (random)
    //if point lies on diagonal, don't look for more points
    //else look at the other untouched points
  }

  show(){
    strokeWeight(10); 
    stroke('red'); 
    point(this.uLeft_pos.x, this.uLeft_pos.y);
    point(this.uRight_pos.x, this.uRight_pos.y);
    point(this.lLeft_pos.x, this.lLeft_pos.y);
    point(this.lRight_pos.x, this.lRight_pos.y);
  }
}