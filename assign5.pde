
Ball ball;
Bar bar;
Rect [] rectArray;
boolean shoot = false;

//Game Status
final int GAME_START   = 0;
final int GAME_PLAYING = 1;
final int GAME_PAUSE   = 2;
final int GAME_WIN     = 3;
final int GAME_LOSE    = 4;
final int down = 5;
final int up = 6;
final int left = 7;
final int right = 8;
int status;              //Game Status
int point;               //Game Score
/*--------Put Variables Here---------*/
int ix = 130;
int iy = 60;
int spacingX = 45;
int spacingY = 45;
int rowNum = 10;
int totalNum = 50;
int life =3;
int direction;
int bumpCount;
int blueRect1;
int blueRect2;
int blueRect3;
int redRect1;
int redRect2;
int redRect3;


final int start = 5;
final int pause = 6;
final int win = 7;
final int lose = 8;

void setup() {
  status = GAME_START;
  size(640,480);
  smooth();
  ellipseMode(CENTER);
  rectMode(CENTER); 
  noStroke();
  
  rectArray = new Rect[100];
  bar = new Bar(100);
  ball = new Ball();

  reset();

}
void draw() {
background(0);
  switch(status) {

  case GAME_START:
    reset();
    printText(start);
    break;

  case GAME_PLAYING:
    drawScore();
    drawLife();
    drawRect();
    drawBall();
    shootBall();
    checkCollision();
    checkDead();
    checkWin_Lose();
    /*---------Call functions---------------*/
    bar.move();
    bar.display();

    break;

  case GAME_PAUSE:
    printText(pause);
    break;

  case GAME_WIN:
    /*---------Print Text-------------*/
    printText(win);
    /*--------------------------------*/
    break;

  case GAME_LOSE:
    printText(lose);
    break;
  }
}
void keyPressed(){
  statusCtrl();
}

void mousePressed(){
    
  if(mouseButton==RIGHT && status == GAME_PLAYING){
      shoot = !shoot; 
  }
}

void drawScore() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(23);
  text("SCORE:"+point, width/2, 16);
}

void rectMaker(int totalNum,int rowNum) {
  blueRect1 = int(random(1,10));
  redRect1 = blueRect1 + int(random(3,6));
  blueRect2 = redRect1 + int(random(4,8));  
  redRect2 = blueRect2 + int(random(6,8));
  blueRect3 = redRect2 + int(random(1,7));
  redRect3 = blueRect3 + int(random(1,8));
  for(int i = 0; i < totalNum ;i++){ 
      int row = int(i/rowNum);
      int col = int(i%rowNum);
      int x = ix + col*spacingX;
      int y = iy + row*spacingY;
      rectArray[i]= new Rect(x,y,i,totalNum);
  }
}

void drawRect(){
  for (int i=0; i<totalNum; i++) {
    Rect rect = rectArray[i];
    rect.display(); //Draw rect
  }
  Rect BlueRect1 = rectArray[blueRect1];
  BlueRect1.display_blue();
  rectArray[blueRect1].blue = true;
  Rect BlueRect2 = rectArray[blueRect2];
  BlueRect2.display_blue();
  rectArray[blueRect2].blue = true;
  Rect BlueRect3 = rectArray[blueRect3];
  BlueRect3.display_blue();
  rectArray[blueRect3].blue = true;
  Rect RedRect1 = rectArray[redRect1];
  RedRect1.display_red();
  rectArray[redRect1].red = true;
  Rect RedRect2 = rectArray[redRect2];
  RedRect2.display_red();
  rectArray[redRect2].red = true;
  Rect RedRect3 = rectArray[redRect3];
  RedRect3.display_red();
  rectArray[redRect3].red = true;
}  

void checkCollision(){
  for(int i = 0 ; i<totalNum ; i++ ){
    Rect rect = rectArray[i];
    if(rect.x - rect.brickWidth/2 + abs(ball.xSpeed) >= ball.x + ball.size/2 && ball.x + ball.size/2 >= rect.x - rect.brickWidth/2){
       direction = left;
    }
    if(rect.x + rect.brickWidth/2 - abs(ball.xSpeed) <= ball.x - ball.size/2 && ball.x - ball.size/2 <= rect.x + rect.brickWidth/2){
       direction = right;
    }
    if(rect.y + rect.brickHeight/2 - abs(ball.ySpeed) <= ball.y - ball.size/2 && ball.y - ball.size/2 <= rect.y + rect.brickHeight/2){
       direction = down;
    }
    if(rect.y - rect.brickHeight/2 + abs(ball.ySpeed) >= ball.y + ball.size/2 && ball.y + ball.size/2 >= rect.y - rect.brickHeight/2){
       direction = up;
    }
    /*if(ball.x + ball.size/2 < ix - rect.brickWidth/2 && 
       iy + spacingY*4 + rect.brickHeight/2 > ball.y - ball.size/2 && ball.y + ball.size/2 > iy - rect.brickHeight/2){
       direction = left;
    }
    if(ball.x - ball.size/2 > ix + spacingX*9 + rect.brickWidth/2 && 
       iy + spacingY*4 + rect.brickHeight/2 > ball.y - ball.size/2 && ball.y + ball.size/2 > iy - rect.brickHeight/2){
       direction = right;
    }
    if(ix - rect.brickWidth/2 < ball.x + ball.size/2 && ball.x - ball.size/2 < ix + spacingX*9 + rect.brickWidth/2 && 
       ball.y - ball.size/2 > iy + spacingY*4 + rect.brickHeight/2){
       direction = down;
    }
    if(ix - rect.brickWidth/2 < ball.x + ball.size/2 && ball.x - ball.size/2 < ix + spacingX*9 + rect.brickWidth/2 && 
       ball.y + ball.size/2 < iy - rect.brickHeight/2){
       direction = up;
    }*/
    switch(direction){
      case down:
        if(rect.x + rect.brickWidth/2 > ball.x && ball.x > rect.x - rect.brickWidth/2 && 
           rect.y + rect.brickHeight/2 -ball.size <= ball.y - ball.size/2 && ball.y - ball.size/2 <= rect.y + rect.brickHeight/2){
          //println("rect.x:"+rect.x);
          //println("rect.y:"+rect.y);
          //println("ball.x:"+ball.x);
         // println("ball.y:"+ball.y);
          removeRect(rect);
          ball.ySpeed = ball.ySpeed * -1;
         // println("down");
        }
        break;
      case up:
        if(rect.x + rect.brickWidth/2 > ball.x && ball.x > rect.x - rect.brickWidth/2 && 
           rect.y - rect.brickHeight/2 + ball.size >= ball.y + ball.size/2 && ball.y + ball.size/2 >= rect.y - rect.brickHeight/2){
          //println("rect.x:"+rect.x);
          //println("rect.y:"+rect.y);
         // println("ball.x:"+ball.x);
          //println("ball.y:"+ball.y);
          removeRect(rect);
          ball.ySpeed = ball.ySpeed * -1;
         // println("up");
        }
        break;
      case left:
        if(rect.x + rect.brickWidth/2  >= ball.x + ball.size/2 && ball.x + ball.size/2 >= rect.x - rect.brickWidth/2 && 
           rect.y + rect.brickHeight/2 >= ball.y && ball.y >= rect.y - rect.brickHeight/2){
          //println("rect.x:"+rect.x);
         // println("rect.y:"+rect.y);
         // println("ball.x:"+ball.x);
         // println("ball.y:"+ball.y);           
           removeRect(rect);
           ball.xSpeed = ball.xSpeed * -1;
          /// println("left");
        }
        break;
      case right:
        if(rect.x - rect.brickWidth/2 <= ball.x - ball.size/2 && ball.x - ball.size/2 <= rect.x + rect.brickWidth/2 && 
           rect.y + rect.brickHeight/2 >= ball.y && ball.y >= rect.y - rect.brickHeight/2){
         // println("rect.x:"+rect.x);
          //println("rect.y:"+rect.y);
         // println("ball.x:"+ball.x);
          //println("ball.y:"+ball.y);           
           removeRect(rect);
           ball.xSpeed = ball.xSpeed * -1;
           //println("right");
        }
        break;
    }
  }
}
  
void drawBall(){
  if(shoot == false){
    ball.x = mouseX;
    ball.y = height - 26;
  }  
  ball.display();
}

void shootBall(){
  if(shoot == true){
    ball.move();
  }
}

void drawLife() {
  fill(230, 74, 96);
  text("LIFE:", 36, 455);
  /*---------Draw Ship Life---------*/
  for(int i = 0; i<life ; i++){
    colorMode(RGB);
    fill(222,35,25);
    ellipse(78+i*25,459,15,15);  
  }
}

void removeRect(Rect obj) {
  obj.gone = true;
  obj.x = 2000;
  obj.y = 2000;
  bumpCount ++;
  point++;
  if(obj.blue == true){
    bar.Length = bar.Length*2;
   // println(obj.blue);
  }
  if(obj.red == true){
    bar.Length = bar.Length * 1/2;
  }
}

void checkDead(){
  if (ball.y >= height){
    life--;
    ball.x = mouseX;
    ball.y = height - 26;
    shoot = false;
  }
}

void checkWin_Lose(){
    if(life==0){
      status=GAME_LOSE;
    }
    if(bumpCount==totalNum){
      status=GAME_WIN;
    }
}

void printText(int status){
    /*---------Print Text-------------*/
    textAlign(CENTER);

    switch (status){
      case start:
        textSize(60);
        fill(95, 194, 226);
        text("GALIXIAN", width/2, 240);
        textSize(20);
        text("Press ENTER to Start", width/2, 280); // replace this with printText
        break;
    
      case pause:
        /*---------Print Text-------------*/
        textSize(40);
        fill(95, 194, 226);
        text("PAUSE", width/2, 240);
        textSize(20);
        text("Press ENTER to Resume", width/2, 280);
        /*--------------------------------*/
        break;
    
      case win:
        /*---------Print Text-------------*/
        fill(95, 194, 226);
        textSize(40);
        text("WINNER", width/2, 310);
        textSize(20);
        text("SCORE:", width/2-10, 350);
        text(point, width/2+45, 350);
        /*--------------------------------*/
        break;
    
      case lose:
        /*---------Print Text-------------*/
        textAlign(CENTER);
        fill(95, 194, 226);
        textSize(40);
        text("BOOOOM", width/2, 240);
        textSize(20);
        text("You are dead!!", width/2, 280);
        /*--------------------------------*/
        break;
      }
}
/*---------Reset Game-------------*/
void reset() {
  for (int i=0; i<rectArray.length-1; i++) {
    rectArray[i] = null;
  }

  point = 0;
  bumpCount = 0;

  /*--------Init Variable Here---------*/
  life = 3;
  bar.Length = 100;
  /*-----------Call Make Alien Function--------*/
  rectMaker(totalNum,rowNum);
}


void statusCtrl() {
  if (key == ENTER) {
    switch(status) {
/*-----------add things here--------*/
    case GAME_START:
      status = GAME_PLAYING;
      break;
    
    case GAME_PLAYING:
      status = GAME_PAUSE;
      break;
      
    case GAME_PAUSE:
      status = GAME_PLAYING;
      break;
      
    case GAME_WIN:
      reset();
      status = GAME_PLAYING;
      break;      
 
    case GAME_LOSE:
      reset();
      status = GAME_PLAYING;
      break;  
    }
  }
}

  
