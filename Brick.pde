class Rect{
  int brickWidth;
  int brickHeight;
  int x;
  int y;
  int Num;
  int totalNum;
  boolean gone = false;
  boolean blue = false;
  boolean red = false;
  Rect(int x,int y,int Num,int totalNum){
    
    brickWidth = 40;
    brickHeight = 40;
    this.x = x;
    this.y = y;
    this.Num = Num;
    this.totalNum = totalNum;
  }
  
  void display(){
    noStroke();
    colorMode(HSB,255);
    fill(60,255-(255/totalNum)*Num,250);
    rect(x,y,brickWidth,brickHeight);
  }
    void display_blue(){
    noStroke();
    colorMode(RGB); 
    fill(25,41,222);
    rect(x,y,brickWidth,brickHeight);
  }
  void display_red(){
    noStroke();
    colorMode(RGB); 
    fill(222,25,93);
    rect(x,y,brickWidth,brickHeight);
  }
}
