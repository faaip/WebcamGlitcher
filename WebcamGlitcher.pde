import processing.video.*; 
Capture video;

PImage img1;
int w=640, h=480;

boolean bright;
int shiftAmount = 0;
int grid = 1;


void setup() {
  size(w, h);
  video = new Capture(this, w, h); 
  video.start();
}

void draw() { 
  loadPixels();

  for (int y = 0; y< h; y++)
  {
    for (int x = 0; x< w; x++)
    {
      color c = video.pixels[y*video.width+x]; 

      int a = (c >> 24) & 0xFF;
      int r = (c >> 16) & 0xFF;  
      int g = (c >> 8) & 0xFF;  
      int b = c & 0xFF; 

      if (bright)
      {
        if (r+g+b > 100*3) {
          if(y %grid == 0){
          pixels[y*w+x] = c << shiftAmount;
          }
        }
      }
      
       if (!bright)
      {
        if (r+g+b < 100*3) {
          if(y %grid == 0){
          pixels[y*w+x] = c << shiftAmount;
          }
        }
      }
    }
  }
  updatePixels();
}

void captureEvent(Capture c) { 
  c.read();
}

void keyPressed()
{
  if (keyCode == UP)
  {
    shiftAmount++;
  }
  if (keyCode == DOWN)
  {
    shiftAmount--;
  }
    if (keyCode == LEFT)
  {
    if(grid > 1)
    {
    grid--;
    }
  }
    if (keyCode == RIGHT)
  {
    grid++;
  }
  
  
  if(keyCode == TAB)
  {
    if(bright){bright = false;}
    if(!bright){bright = true;}
    
    println(bright);
  }
  
  
}

