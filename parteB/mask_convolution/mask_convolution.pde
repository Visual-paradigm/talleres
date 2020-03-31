/*
Mascara de convolución
Parte de este codigo fue extraido de https://processing.org/examples/convolution.html
*/

PImage img;
PImage img2;
int w = 512;

// It's possible to convolve the image with many different 
// matrices to produce different effects. This is a high-pass 
// filter; it accentuates the edges. 
boolean toggle;
float[][] matrix = { { -1, -1, -1 },
                     { -1,  9, -1 },
                     { -1, -1, -1 } }; 

void setup() {
  size(1024, 512);
  img = loadImage("Lenna.png"); 
  img2 = loadImage("Lenna.png");

}

void draw() {
  // We're only going to process a portion of the image
  // so let's set the whole image as the background first
  background(50);
  image(img, 0, 0);  
  textSize(30);
  text("click on the image", 128, 500);
  fill(255, 255,255);

    if(toggle)
      image(img2, 512, 0);
  
  // Calculate the small rectangle we will process
  
  
 
}

void drawFilter(){
  int xstart = 0;
  int ystart = 0;
  int xend = 512;
  int yend = 512;
  
  int matrixsize = 3;
  loadPixels();
  // Begin our loop for every pixel in the smaller image
  for (int x = xstart; x < xend; x++) {
    for (int y = ystart; y < yend; y++ ) {
      color c = convolution(x, y, matrix, matrixsize, img);
      int loc = x + y*img.width;
      img2.pixels[loc] = c;
    }
  }
  updatePixels();
}

color convolution(int x, int y, float[][] matrix, int matrixsize, PImage img)
{
  float rtotal = 0.0;
  float gtotal = 0.0;
  float btotal = 0.0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j= 0; j < matrixsize; j++){
      // What pixel are we testing
      int xloc = x+i-offset;
      int yloc = y+j-offset;
      int loc = xloc + img.width*yloc;
      // Make sure we haven't walked off our image, we could do better here
      loc = constrain(loc,0,img.pixels.length-1);
      // Calculate the convolution
      rtotal += (red(img.pixels[loc]) * matrix[i][j]);
      gtotal += (green(img.pixels[loc]) * matrix[i][j]);
      btotal += (blue(img.pixels[loc]) * matrix[i][j]);
    }
  }
  // Make sure RGB is within range
  rtotal = constrain(rtotal, 0, 255);
  gtotal = constrain(gtotal, 0, 255);
  btotal = constrain(btotal, 0, 255);
  // Return the resulting color
  return color(rtotal, gtotal, btotal);
}


void mouseClicked() {
  drawFilter();
  toggle = !toggle;
}
