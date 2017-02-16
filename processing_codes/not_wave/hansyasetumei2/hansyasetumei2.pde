void setup(){
  background(255);
  size(1100,800);
  translate(0,200); 
  //最初の素元波の長さは244
  
  
  //angle
  strokeWeight(3);

  
  
  strokeWeight(3);
  line(0,height/2,width,height/2);
  
  
  
  
  
  
  
  
  
  
    for(int count = 50; count<520; count+= 30){
    line(300, 50+count, 300, count+65);
  }
  
  
  stroke(255,0,0);
  line(100,60,300,400);
 
  
  //line(100,0,500,400);
 
  
  line(600,60,800,400);
 
  
  
  //line(300,400,500,60);//反射波
  //line(800,400,1000,60);//反射波

stroke(0);
  line(300,400,675,190);
  //line(422,189,800,400);
stroke(0,255,0);
  //line(300,400,422,189);
  
  //line(675,190,800,400);
  

  
  
  stroke(0,0,255);
  noFill();
  strokeWeight(4);
  for(int i4 = 180; i4 < 360; i4++){
    angle(300,400,i4,244);
  }
    for(int i4 = 180; i4 < 360; i4++){
    //angle(500,400,i4,146 );
  }

  stroke(0);
    for(int i4 = 240; i4 < 270; i4++){
    angle(300,400,i4,50);
  }
    for(int i4 = 270; i4 < 300; i4++){
    //angle(300,400,i4,50 );
  }
      for(int i4 = 332; i4 < 360; i4++){
    angle(300,400,i4,50);
  }
  
  strokeWeight(2);
  //line(285,345,288,355);
  //line(310,345,309,355);
  
  
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


