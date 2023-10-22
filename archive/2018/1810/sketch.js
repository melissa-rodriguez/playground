var xPos;
var yPos;
var cirlce;
var isNearCircle;

function setup(){
    createCanvas(400,400);

    xPos = random(100,300);
    yPOs = random(100, 300);

    circle1 = new Circle(290, 150, 45, 45);
    circle2 = new Circle(100, 100, 15, 15);
    circle3 = new Circle(130, 190, 20, 20);
    circle4 = new Circle(155, 215, 10, 10);
    circle5 = new Circle(200, 350, 5, 5);
    circle6 = new Circle(320, 250, 5, 5);
}

function draw(){
  background(240);


  circle1.avoid();
  circle1.draw();

  circle2.avoid();
  circle2.draw();

  circle3.avoid();
  circle3.draw();

  circle4.avoid();
  circle4.draw();

  circle5.avoid();
  circle5.draw();

  circle6.avoid();
  circle6.draw();

}

class Circle{
  constructor(xPos, yPos, r){
    this.x = xPos;
    this.y = yPos;
    this.r = r;
  }

  draw(){
    fill(0);
    for(var amount = 1; amount > 7; amount ++){
      this.x = random(100, 300);
      this.y = random (100, 300);
    }
    ellipse(this.x, this.y, this.r*2, this.r*2);
  }

  avoid(){
    var speed = .5;
    var distance = dist(mouseX, mouseY, this.x, this.y);
    if(distance < this.r+70){
      isNearCircle = true;
    }
    else{
      isNearCircle = false;
    }

    if(isNearCircle == true){
      if(mouseX > this.x&&mouseY > this.y){
      this.x = this.x - speed;
      this.y = this.y - speed;
    }
    else if (mouseX < this.x && mouseY < this.y){
      this.x = this.x + speed;
      this.y = this.y + speed;
    }
    else if (mouseX < this.x && mouseY > this.y){
      this.x = this.x + speed;
      this.y = this.y - speed;
    }
    else if (mouseX > this.x && mouseY < this.y){
      this.x = this.x - speed;
      this.y = this.y + speed;
    }
    }
    else{
      this.x = random(this.x -.5, this.x+.5);
      this.y = random (this.y - .5, this.y + .5);
    }


  }
}
