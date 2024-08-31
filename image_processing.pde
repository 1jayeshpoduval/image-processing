PImage originalImage;
PImage blurredImage;
float grayAmount;
int blurStrength = 0;


void setup() {

  originalImage = loadImage("neon-desert.jpg");

  size(600, 900);

  int imageAspectRatio = originalImage.width / originalImage.height;
  int windowAspectRatio = width / height;
  int newImageWidth, newImageHeight;

  if (imageAspectRatio > windowAspectRatio) { // Scale based on width
    newImageWidth = width;
    newImageHeight = int(width / imageAspectRatio);
  } else { // Scale based on height
    newImageWidth = int(height * imageAspectRatio);
    newImageHeight = height;
  }

  originalImage.resize(newImageWidth, newImageHeight); // Resize the image
}


void draw() {
  blurredImage = originalImage.copy();
  loadPixels();

  for (int i = 0; i < blurredImage.pixels.length; i++) {
    color c = blurredImage.pixels[i];
    //println(c);
    float grayValue = red(c) * 0.299 + green(c) * 0.587 + blue(c) * 0.114;
    float r = lerp(red(c), grayValue, grayAmount);
    float g = lerp(green(c), grayValue, grayAmount);
    float b = lerp(blue(c), grayValue, grayAmount);
    blurredImage.pixels[i] = color(r, g, b);
  }
  updatePixels();
  blurredImage.filter(BLUR, blurStrength);
  image(blurredImage, 0, 0);
  
  text("Move mouse horizontally to convert image to grayscale", 220, 30);
  text("MouseX: " + mouseX, 500, 60);
  text("Keyup to blur image", 450, 110);
  text("Keydown to unblur image", 412, 130);
  text("Blur Strength: " + blurStrength, 480, 160);
  textSize(16);
  
}

void mouseMoved() {
  grayAmount = map(mouseX, 0, width, 0, 1);
}

void keyPressed() {
  if (keyCode == UP) {
    blurStrength += 1;
  } else if (keyCode == DOWN) {
    blurStrength -= 1;
  }
}
