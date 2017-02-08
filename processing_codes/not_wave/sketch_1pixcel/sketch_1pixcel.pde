void setup(){
    background(255);
  size(550,500);
  rect(100,50,400,400);
  strokeWeight(2);
  noFill();
  //stroke(200);
  line(100,50,500,50);
  for(int i = 100; i<550; i += 50){
    line(100,i,500,i);
    line(i,50,i,450); //1px
  }
  line(40,50,40,450);
  tateue(40,50);
  tatesita(40,450);
  line(90,50,90,100);
  tateue(90,50);
  tatesita(90,100);
  
  line(100,40,150,40);
  yokomigi(150,40);
  yokohidari(100,40);
  fill(0,0,255,100);
      for(int j = 100; j< 500; j += 50 ){
      ellipse(125,j-25,50,50);
      ellipse(j+25,75,50,50);
      ellipse(j+25,125,50,50);
      ellipse(j+25,175,50,50);
      ellipse(j+25,225,50,50);
      ellipse(j+25,275,50,50);
      ellipse(j+25,325,50,50);
      ellipse(j+25,375,50,50);
      ellipse(j+25,425,50,50);
    }


}
  

  void yokomigi(int x,int y){
  line(x,y,x-10,y+5);
  line(x,y,x-10,y-5);
}
void yokohidari(int x,int y){
  line(x,y,x+10,y+5);
  line(x,y,x+10,y-5);
}

void tatesita(int x,int y){
  line(x,y,x-5,y-10);
  line(x,y,x+5,y-10);
}

void tateue(int x,int y){
  line(x,y,x-5,y+10);
  line(x,y,x+5,y+10);
}
  
