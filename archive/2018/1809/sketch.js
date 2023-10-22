function setup(){
createCanvas( 400, 400);

}

function draw(){
background(240);
noFill();
var circleX = constrain(mouseX, 190,210);
var circleY = constrain(mouseY,190,210);

var x = lerp(circleX,mouseX, 0.01);
ellipse(x, circleY, 150);
fill(240);
ellipse(width/2, height/2, 150);

console.log(mouseX, mouseY);
//make this an eye or camera that tracks
//mouse position
}
