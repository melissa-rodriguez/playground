//TODO: have thank you's overlap like in image:
// https://ipaksupply.com/wp-content/uploads/2016/07/tshirt-thankyou-bag.jpg

var words = ["THANK YOU", "GRACIAS", "HAVE A NICE DAY"]

function setup() {
  createCanvas(400, 400);
}

function draw() {
  background(240);
  textAlign(LEFT, TOP);


  for (var y = 0; y < height - 10; y += 30) {
    if (second() % 5 == 0) {
      textAlign(CENTER);
      textSize(12);
      fill(255, 0, 0);
      text(words[2], width / 2, height / 2);
      break;
    }
    if (second() % 2 == 0) {
      textSize(32);
      noFill();
      stroke(255, 0, 0);
      if (y == 330) {
        fill(255, 0, 0);
      }
      text(words[0], width / 2, y);
    }
    if (second() % 2 == 1) {
      textSize(32);
      noFill();
      stroke(255, 0, 0);
      if (y == 330) {
        fill(255, 0, 0);
      }
      text(words[1], 10, y);
    }
  }
}
