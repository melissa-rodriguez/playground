//to capture for gif
let gifLength = 300;
let canvas;

let img;
function preload(){
  img = loadImage('assets/booty.png')
}
function setup(){
    var p5Canvas = createCanvas(400, 400);
    canvas = p5Canvas.canvas;
  
    // capturer.start();
    
  }
  

  let speed = 1;
  let pos = -200;
  function draw(){
    background(240);
    imageMode(CENTER);

    for (let i = -400; i<width+400; i+= 100){
      for(let j = 0; j<height+100; j+=100){
        // ------ OPTION ONE ------- 
        if(j == width/2-100){
          image(img, i-pos, j);
          // console.log(i-pos);
          if (i-pos < 1000 || (i-pos) < -300 ){
            speed*=-1;
          }
        }

        else if(j == width/2+100){
          image(img, i+pos, j);
          if (i+pos > 800 || (i+pos) < -300 ){
            speed*=-1;
          }
        }

        else{
        image(img, i, j);
        }

        //----- OPTION TWO ------
        // image(img,i,j);
      }
    }
    pos += speed;


    // ------ OPTION THREE -------
    // frameRate(15);
    // for (let i = 100; i<width; i+= 100){
    //   for(let j = 100; j<height; j+=100){
    //     if (j == height/2 && i == width/2){
    //       image(img, i+pos+200,j);
    //       speed *=-1;
    //     }
    //     else{
    //     image(img,i,j);
    //     }
    //   }
    // }




  //   if (frameCount < gifLength){
  //   capturer.capture(canvas);
  // } else if (frameCount == gifLength) {
  //   capturer.stop();
  //   capturer.save();
  // }
    
    
  }

  function keyTyped() {
    if (key === 's') {
      saveCanvas(canvas, "myCanvas", "png");
    }
  }

  

 
