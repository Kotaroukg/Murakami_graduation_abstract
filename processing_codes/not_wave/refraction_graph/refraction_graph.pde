void setup(){
  background(255);
  size(1000,800);
  
  
  //angle
  strokeWeight(3);
  for(int i = 225; i < 270; i++){
    angle(300,400,i,70);
  }
  
    for(int i2 = 68; i2 < 90; i2++){
    angle(300,400,i2,70);
    angle(300,400,i2,90);
  }
  
  
      for(int i2 = 158; i2 < 180; i2++){
    angle(800,400,i2,70);
    angle(800,400,i2,90);
  }
  
      for(int i2 = 317; i2 < 360; i2++){
    angle(300,400,i2,60);
  }
  

  
  
  strokeWeight(3);
  line(0,height/2,width,height/2);
  
  
  
  
  
  
  
  
  
  
    for(int count = 50; count<520; count+= 30){
    line(300, 50+count, 300, count+65);
  }
  
  
  stroke(255,0,0);
  line(0,100,300,400);
  line(300,400,472,800);
  
  line(100,0,500,400);
  line(500,400,672,800);
  
  line(400,0,800,400);
  line(800,400,972,800);
  
  
  line(300,400,550,150);
  
  
  
  
  
  
  
  
  
  stroke(0,255,0);
  line(380,585,800,400);
  
  
  
  stroke(0,0,255);
  noFill();
  strokeWeight(4);
  for(int i4 = 0; i4 < 180; i4++){
    angle(300,400,i4,200);
  }
    for(int i4 = 0; i4 < 180; i4++){
    angle(500,400,i4,120);
  }
  
  
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


void angle(int x, int y,float i,int radius){
  point(  x +radius*cos(radians(i)),   y + radius*sin(radians(i))  );
  
}

  
