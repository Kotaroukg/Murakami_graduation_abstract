void setup(){
  background(255);
  size(600,500);
  translate(100,30);
  rect(50,50,400,400);
  strokeWeight(2);
  fill(0,0,255,100);
  
      for(int j = 50; j< 400; j += 100 ){
      ellipse(100,j+50,100,100);
      ellipse(j+50,100,100,100);
      ellipse(j+50,200,100,100);
      ellipse(j+50,300,100,100);
      ellipse(j+50,400,100,100);
    }
    
  stroke(200);
  for(int i = 50; i<500; i += 50){
    line(50,i,450,i);
    line(i,50,i,450); //1px
  }
  stroke(0);
  for(int i = 50; i<500; i += 100){
    line(50,i,450,i);
    line(i,50,i,450); 
  }
    
   
    
    
    line(40,50,40,100);
    tateue(40,50);
    tatesita(40,100);
    
    line(50,40,100,40);
    yokomigi(100,40);
    yokohidari(50,40);
    
    
    line(-10,50,-10,150);
    tateue(-10,50);
    tatesita(-10,150);
    
    line(50,0,150,0);
    yokomigi(150,0);
    yokohidari(50,0);
  


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
  
  


