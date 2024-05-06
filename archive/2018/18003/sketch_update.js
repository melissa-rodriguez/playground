//UPDATES MADE: Added stars to appear at night using Stars function and gross conditional in moon class
// don't forget that index.html is calling the sketch_update file, not sketch.js

let sun;
let moon;
let xspeed;
let skycolor_g;
let skycolor_b;
let stars = [];


function setup() {
  createCanvas(400, 400);
  sun = new Sun();
  moon = new Moon(0, height / 2, 50);
  stars = new Star(150, 140, 2);
  
  
}

function draw() {
  //background(0, 191, 255, 30);
  sun.display();
  sun.face();
  moon.display();
  moon.face();
  moon.move();
  
}

//this is an update
function Stars(xpos, ypos) {
    fill(255,255,255, random(10,100));
    ellipse(xpos, ypos, 10);
    ellipse(xpos, ypos, 10/2)
    
}

class Sun {
  constructor() { // constructor is like the class's "setup()"
    this.r = 100;
  }
  display() {
    //background(0, 191, 255, 30);
    fill(255, 255, 102);
    noStroke();
    ellipse(width / 2, height / 2, this.r);
  }
  
  face(){
  noFill();
  stroke(0)
  strokeWeight(3);
	arc(190, 200, 10, 10, PI, 0, OPEN);
  arc(210, 200, 10, 10, PI, 0, OPEN);
  arc(200, 210, 20, 20, 0, PI, OPEN);
  
  noStroke();
  fill(255,192,203);
  ellipse(175, 210, 15);
  ellipse(225, 210, 15); 
  }
}

class Moon {
  constructor(x, y, r) {
    this.x = x;
    this.y = y;
    this.r = r;
  }
  display() {
    fill(165);
    noStroke();
    ellipse(this.x, this.y, this.r * 2, this.r * 2);   

  }
  

  move() {
    
    if (this.x < width / 2) {
      xspeed = map(this.x, 0, width / 2, 4, 1 / 16);
      skycolor_g = map(this.x, 0, width/2, 191, 85);
      skycolor_b = map(this.x, 0, width/2, 255, 125)

    }

    if (this.x > width / 2) {
      xspeed = map(this.x, width / 2, width, 1 / 16, 4);
      skycolor_g = map(this.x, width/2, width+100, 85, 191);
      skycolor_b = map(this.x, width/2, width+100, 125, 255);
    }

    //this is an update
    if (this.x > (width/2)-50 && this.x < (width/2)+50){
      for (let i= 50; i < width-20; i += 50){
        for (let j = 50; j < height-20; j += 50){  // make sure the stars do not lie on the sun
          // console.log(i,j)
          if (i > (width/2)-52 && i < (width/2)+52){
            if (j > (height/2)- 52 && j < (height/2)+52)
            continue;
          }

          //scatter the stars around; this is gross is there a better way?
          if ((i == 50 && j==50) || (i == 350 && j == 350) 
          || (i == 50 && j ==350) || ( i == 350 && j == 50)
          || (i == 50 && j == 250) || (i == 150 && j == 100) 
          || (i == 100 && j == 200) || ( i == 300 && j == 250)
          || (i == 250 && j == 100) || (i == 200 && j == 50)
          || (i == 150 && j == 350) || (i == 50 && j == 300)
          || (i == 300 && j == 300) || (i == 200 && j == 300)
          || (i == 250 && j == 350) || (i == 100 && j == 300)
          || (i == 50 && j == 150) || (i == 100 && j == 100)
          || (i == 300 && j == 150) || (i == 250 && j == 50)
          || (i == 350 && j == 100) || (i == 350 && j == 200)
          || (i == 350 && j == 100) || (i == 200 && j == 350)){
            continue;
          }
          Stars(i, j);
          
        }
      }
    }
    
    if (this.x > width+100){
      setup();
    }
    this.x = this.x + xspeed;
    background(0, skycolor_g, skycolor_b, 30);
    //console.log(skycolor_g, skycolor_b);
    }

   face(){
	fill(0);
  noStroke();
	ellipse(this.x-10, this.y, 10, 10);
  ellipse(this.x+10, this.y, 10, 10, PI, 0, OPEN);
  arc(this.x, 211, 20, 20, 0, PI, OPEN);
  
  fill(255, 0, 0);
  arc(this.x, 219, 10, 8, PI, 0, OPEN);
  
  noStroke();
  fill(255,192,203);
  ellipse(this.x-25, 210, 15);
  ellipse(this.x+25, 210, 15);
  }
}

class Star {
  constructor(xStar, yStar, r){
  // constructor(){
    this.x = xStar;
    this.y = yStar;
    this.r = r;
    
	}
  
  display() {
    fill(255);
    noStroke();
    ellipse(this.x, this.y, this.r*2);
    
    fill(255, 255, 255, 10);
    noStroke();
    ellipse(this.x, this.y, (this.r*2)+7);
    
  }
}

