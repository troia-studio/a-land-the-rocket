import processing.sound.*;

// TODO: auto-pilot, barriers, fuel images
// TODO: animate to center on land, show max score

PFont font;

int score;
Rocket rocket;

Platform[] platforms;

PImage platformImg;


int targetPlatformIndex;

PImage bg;


  void setup() {
  size(800, 800);
  frameRate(60);
  imageMode(CENTER);
  font = createFont("data/Ubuntu-Bold.ttf", 80);
  textFont(font);

  bg = loadImage("data/bg.jpg");
  bg.resize(width, height);

  platformImg = loadImage("data/platform.png");
  platformImg.resize(150, 50);
  
  createPlatforms(3);
  targetPlatformIndex = platforms[1].id;

  rocket = new Rocket();
  rocket.pos = new PVector(platforms[0].pos.x, platforms[0].pos.y - platforms[0].h * 0.2 - rocket.h * 0.5);
}

void draw() {
  image(bg, width * 0.5, height * 0.5);
  showFuel();
  showScore();
  deadFromFalling();


  pushMatrix();
  translate(-rocket.pos.x + width * 0.5, -rocket.pos.y + height * 0.5);
  showInfo();

  for (int i = 0; i < platforms.length; i++) {
    platforms[i].show();
  }

  rocket.applyForce();
  rocket.move();
  rocket.show();

  for (int i = 0; i < platforms.length; i++) {
    isTLandedOnP(platforms[i]);
    isHitFromBottom(platforms[i]);
  }

  showTargetArrow();

  popMatrix();

  if (rocket.isDead) {
    showDead();
  } else if(rocket.isSucceed) {
    showSucceed();
  }
}


float getAngle(float pX1, float pY1, float pX2, float pY2) {
  return atan2(pY2 - pY1, pX2 - pX1);
}


void isHitFromBottom(Platform usingP) {
  boolean isLeftInside = usingP.pos.x - usingP.w*0.5 < rocket.pos.x + rocket.w*0.3;
  boolean isRightInside = usingP.pos.x + usingP.w*0.5 > rocket.pos.x - rocket.w*0.3;
  int targetY = round (usingP.pos.y + usingP.h * 0.5 + rocket.h * 0.5);
  boolean isCollidedWithPlatform = rocket.pos.y + rocket.h  > targetY && rocket.pos.y  < targetY&&isLeftInside&&isRightInside;
  if (isCollidedWithPlatform) {
    rocket.isDead = true;
  }
}

void deadFromFalling() {
  if (rocket.pos.y > platforms[targetPlatformIndex].pos.y + 1000) {
    rocket.isDead = true;
  }
}


void isTLandedOnP(Platform usingP) {
  boolean isLeftInside = usingP.pos.x - usingP.w*0.5 < rocket.pos.x + rocket.w*0.5;
  boolean isRightInside = usingP.pos.x + usingP.w*0.5 > rocket.pos.x - rocket.w*0.5;

  float targetY = usingP.pos.y - usingP.h * 0.2 - rocket.h * 0.5;
  boolean isYCorrect = rocket.pos.y  > targetY && rocket.pos.y - 5 < targetY;

  if (isYCorrect && isLeftInside && isRightInside) {
    if (rocket.vel.y < 2 ) {
      if ( targetPlatformIndex == usingP.id) {
        rocket.fuel = 1;
        targetPlatformIndex++;
        if(targetPlatformIndex == platforms.length) {
          rocket.isSucceed = true;
          targetPlatformIndex = platforms.length-1;
        }
        score++;
      }
      rocket.isLanded = true;
    }

    if (rocket.vel.y >= 2) {
      rocket.isDead = true;
    }
  }
}



void keyPressed() {
  if (key == 'a') {
    rocket.isFireLeft = true;
  }
  if (key == 'd') {
    rocket.isFireRight = true;
  }
}

void keyReleased() {
  if (key == 'a') {
    rocket.isFireLeft = false;
  }
  if (key == 'd') {
    rocket.isFireRight = false;
  }
}
