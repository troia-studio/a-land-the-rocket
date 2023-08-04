void showInfo() {
  textSize(30);
  fill(255);
  PVector firstPPos = platforms[0].pos;
  text("\"R\" to restart", firstPPos.x - 370, firstPPos.y - 200);
  text("\"A\" to left", firstPPos.x - 370, firstPPos.y - 160);
  text("\"D\" to right", firstPPos.x - 370, firstPPos.y -120);
}

void showTargetArrow() {
  PVector tpPos = platforms[targetPlatformIndex].pos;

  float distToTarget = dist(tpPos.x, tpPos.y, rocket.pos.x, rocket.pos.y);

  if (distToTarget > width*0.3 ) {
    float a = getAngle(rocket.pos.x, rocket.pos.y, tpPos.x, tpPos.y);

    float r = 150;
    float arrowX = rocket.pos.x +  r * cos(a);
    float arrowY =  rocket.pos.y +  r * sin(a);
    //fill(200, 120, 20);

    noFill();
    strokeWeight(5);
    stroke(200, 120, 20);

    pushMatrix();
    translate(arrowX, arrowY);
    rotate(a);
    triangle( 0, 0, 0 - 30, 0 - 15, 0 - 30, 0 + 15);
    popMatrix();
  }
}

void showScore() {
  fill(255);
  textSize(60);
  text(score, 100, 100);
}

void showDead() {
  textSize(60);
  fill(100, 25, 25, 200);
  rect(0, 0, width, height);
  fill(255);
  text("WASTED", width*0.5 - 120, height*0.5);
  noLoop();
}

void showSucceed() {
  textSize(60);
  fill(25, 100, 25, 200);
  rect(0, 0, width, height);
  fill(255);
  text("COMPLETED", width*0.5 - 180, height*0.5);
  noLoop();
}


void showFuel() {
  stroke(255);
  noFill();
  strokeWeight(10);
  arc(width * 0.9, height * 0.1, 50, 50, 0, TWO_PI * rocket.fuel);
  strokeWeight(1);
  noStroke();
}
