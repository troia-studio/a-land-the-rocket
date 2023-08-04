
void createPlatforms(int count) {
  
  platforms = new Platform[count];

  for (int i = 0; i < platforms.length; i++) {

    Platform prevP;
    if (i == 0) {
      prevP = new Platform(-1, new PVector(0, 0), 150, 50);
    } else {
      prevP = platforms[i-1];
    }

    float distFromPrevX = random(500, 800);
    float randomX = prevP.pos.x + distFromPrevX;
    float distFromPrevY = random(-300, 400);
    float randomY = prevP.pos.y + distFromPrevY;

    String id = str(i);
    platforms[i] = new Platform(i, new PVector(randomX, randomY), 150, 50);
  }
}

class Platform{
  int id;
  PVector pos;
  int w;
  int h;
  
  Platform(int id,  PVector pos, int w, int h) {
    this.id = id;
    this.pos = pos;
    this.w = w;
    this.h = h;
  }
  
  void show() {
    image(platformImg, pos.x, pos.y);
  }

}
