class Bar{
  int x;
  int y;
  int thickness = 10;
  int Length;
  
  Bar(int Length){
    this.Length = Length;
  }
  
  void move(){
    x = mouseX;
    y = height -10;
  }
  
  void display(){
    colorMode(RGB);
    fill(37,56,217);
    rect(x,y,Length,thickness);
  }
}  
