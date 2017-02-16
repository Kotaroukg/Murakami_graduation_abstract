void setup(){
  background(255);
  strokeWeight(3);
  size(600,700);
  
  translate(100,150);
  line(0,0,400,0);
  line(0,400,400,400);
  line(0,0,0,400);
  line(400,0,400,400);
  line(200,0,200,400);
  line(0,200,400,200);
  
  
  stroke(0,0,255);
  strokeWeight(15);
  for(int i = 0; i < 500; i += 200){
    point(0,i);
    point(i,0);
    point(200,i);
    point(i,200);
    point(400,i);
    point(i,400);
  }
  
  stroke(255,0,0);
  point(330,140);
  
  
  
  
  
  
  strokeWeight(5);
  stroke(255,0,0,70);
  line(400,200,-60,480);
  
}









void yokomigi(int x,int y){
  line(x,y,x-20,y+10);
  line(x,y,x-20,y-10);
}
void yokohidari(int x,int y){
  line(x,y,x+20,y+10);
  line(x,y,x+20,y-10);
}

void tatesita(int x,int y){
  line(x,y,x-10,y-20);
  line(x,y,x+10,y-20);
}

void tateue(int x,int y){
  line(x,y,x-10,y+20);
  line(x,y,x+10,y+20);
}

