class Rocket {
  PImage body;
  PImage fireLeft;
  PImage fireRight;
  PVector pos;
  PVector vel;
  PVector acc;
  int w = 100;
  int h = 165;
  boolean isFireLeft = false;
  boolean isFireRight = false;
  float speed = 0.03;
  float fuel = 1;

  boolean isDead = false;
  boolean isLanded = false;
  boolean isSucceed = false;

  Rocket() {
    pos = new PVector(width * 0.5, height * 0.5);

    body = loadImage("data/new_rocket.png");
    body.resize(w, h);
    fireLeft = loadImage("data/fire_left.png");
    fireRight = loadImage("data/fire_right.png");

    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void show() {
    image(body, pos.x, pos.y);

    int fireH = 66;
    int fireW = 44;
    float fireLeftX = pos.x - w*0.5;
    float fireRightX = pos.x + w*0.5;
    float fireY = pos.y + h*0.5 + fireH * 0.4;

    if (isFireLeft && fuel > 0) {
      image(fireLeft, fireLeftX, fireY, fireW, fireH);
    }
    if (isFireRight&& fuel > 0) {
      image(fireRight, fireRightX, fireY, fireW, fireH);
    }
  }

  void applyForce() {
    if (isFireLeft && fuel > 0) {
      acc.add(speed, -speed * 2);
      fuel -= 0.001;
      isLanded = false;
    }

    if (isFireRight && fuel > 0) {
      acc.add(-speed, -speed * 2);
      fuel -= 0.001;
      isLanded = false;
    }

    if (isLanded == false) {
      acc.add(0, speed * 1.5);
    } else {
      vel = new PVector(0, 0);
    }
  }

  void move() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
}
