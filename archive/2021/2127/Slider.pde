import controlP5.*;
ControlP5 cp5;

float damping = 0.1;
float freq = 0.1;

void slider_init() {
  cp5 = new ControlP5(this);
  // add a horizontal slider
  cp5.addSlider("damping")
    .setPosition(100, 305)
    .setSize(200, 40)
    .setRange(-1.5, 1.5)
    ;

  cp5.addSlider("freq")
    .setPosition(100, 305 + 50)
    .setSize(200, 40)
    .setRange(0, 5)
    ;
}
