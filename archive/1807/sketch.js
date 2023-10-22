let gifLength = 300;
let canvas;

var circle;
var angle = 0;
var angleSpeed = 1;

function setup(){
  var p5Canvas = createCanvas(400, 400);
  canvas = p5Canvas.canvas;


  circle1 = new Circle(36);
  circle2 = new Circle(96);
  circle3 = new Circle(200)
  circle4 = new Circle(220);
  circle5 = new Circle(256);

  angleMode(DEGREES);

  // capturer.start();

}

function draw(){
background(240);
noFill();


strokeWeight(1)
circle1.show();
circle2.show();
circle3.show();
circle5.show();


push();  //new drawing state 1
translate(200,200);
rotate(angle);
fill(240);
ellipse(46, -10, 15);  //inner orbit
ellipse(-109, 65, 15);   //outer oribit
angle=angle+angleSpeed;
if (angle > 90 || angle< -90){  //switch directions
  angleSpeed = -angleSpeed;
}

//slash
push();  //new drawing state 2
strokeWeight(5);
line(0,0, 78,-105);
line(0,0, -78,105);
pop(); //exit to drawing state 1
pop(); //exit drawing state draw()


strokeWeight(5); // bolded circle
circle4.show();

// if (frameCount < gifLength){
//     capturer.capture(canvas);
//   } else if (frameCount == gifLength) {
//     capturer.stop();
//     capturer.save();
//   }

}

function mousePressed(){  //switch directions when mouse is pressed
  angleSpeed = -angleSpeed;
}

class Circle{
  constructor(d){
    this.d = d;
    this.x = width/2;
    this.y = height/2;
  }

  show(){
    ellipse(this.x, this.y, this.d);
  }
}
