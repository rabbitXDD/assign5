class Ball{
    float x ;
    float y ;
     //how much the ball moves on each frame
    float xSpeed ;
    float ySpeed ;
    float size;
  
  Ball(){
     //how much the ball moves on each frame
     xSpeed = 5;
     ySpeed = 5;
     size = 20;
  }

  
  void move(){
    
      x = x + xSpeed; //move along x axis
      y = y + ySpeed; //move along y axis
     
      // note: the "||" means "or", so if either of those are true then the code block is entered.
      if (x > width- size/2 || x < size/2) { // are we out of bounds?
        xSpeed = xSpeed *-1; //reverse direction of x
      } 
      if (y < size/2) {// are we out of bounds?
        ySpeed = ySpeed *-1; //reverse direction of y

      }
      
        float bottom = y+size/2;
        float bl = bar.y - 10/2;
        float leftEdge = x-size/2;
        float rightEdge = x+size/2;
        float barLeft = bar.x - bar.Length/2;
        float barRight = bar.x + bar.Length/2;

        if(bottom > bl &&  barLeft < rightEdge && rightEdge < barLeft + size/2 ){
          x = mouseX - bar.Length/2 - size/2 - xSpeed;
          xSpeed = xSpeed * -1;
        }
        if(bottom > bl && barRight  - size/2 < leftEdge && leftEdge < barRight ){
          x = mouseX + bar.Length/2 + size/2 + xSpeed;
          xSpeed = xSpeed * -1;
        }
        if(bottom >= bl && x < barRight  && barLeft < x){
          y = bottom - size/2;
          ySpeed = ySpeed *-1;
        }
  }
  
  void display(){
    noStroke();
    colorMode(RGB); 
    fill(37,56,217);
    ellipse(x, y, size, size); //draw the ball
  }

}
