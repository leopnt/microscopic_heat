import com.hamoid.*;
Grid jointsGrid;

int frame = 0;
int gifFramerate = 10;

VideoExport videoExport;
boolean recording = false;

void setup() {
  size(512, 512);
  background(0);
  frameRate(30);
  jointsGrid = new Grid(15, 15);
  
  videoExport = new VideoExport(this, "heat.mp4");
  videoExport.startMovie();
}

void draw() {
  background(23, 19, 36);
  jointsGrid.randomHammer();
  jointsGrid.process();
  
  if (recording) {
    //frame++;
    //if (frame % gifFramerate == 0) {
    videoExport.saveFrame();
      //frame = 0;
    //}
  }
}

void mouseClicked() {
  jointsGrid.onMouseClicked();
}

void keyPressed() {
  if(key == 'r' || key == 'R') {
    recording = !recording;
    println("Recording is " + (recording ? "ON" : "OFF"));
  }
  if (key == 'q') {
    videoExport.endMovie();
    exit();
  }
}
