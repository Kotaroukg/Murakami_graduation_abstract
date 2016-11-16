int i;
void setup(){
  size(500,500);
  frameRate(24);
  


}

void draw(){
  background(255);
  fill(0);
  rect(0,0,500,150);
  ellipse(100,150,5*i,5*i)
  i++;

}