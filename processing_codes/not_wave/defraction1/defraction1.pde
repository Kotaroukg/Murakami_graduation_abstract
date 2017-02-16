//上から描写していく
//先に円から描写して,下を四角で囲む

void setup(){
  size(1100,800);
  background(255);




  stroke(0,0,255);
  noFill();
  strokeWeight(2);
    for(int i4 = 270; i4 <= 360; i4+= 30){
    //point(500-200*sin(i),500-200*sin(i));
     ellipse(700+50*cos(radians(i4)),650+50*sin(radians(i4)),100,100);
     //point(500+200*cos(radians(i)),400+200*sin(radians(i)));

  }

  for(int i5 = 180; i5 <= 270; i5+= 30){
    //point(500-200*sin(i),500-200*sin(i));
     ellipse(400+50*cos(radians(i5)),650+50*sin(radians(i5)),100,100);
     //point(500+200*cos(radians(i)),400+200*sin(radians(i)));

  }

  for(int i6= 0; i6 < 7; i6++){
  ellipse(400+50*i6, 600,100,100);
}



fill(255);
noStroke();
ellipse(400,650,140,140);
ellipse(700,650,140,140);
rect(400,570,300,240);





  
  
 fill(0); 
rect(0,650,400,60);
rect(700,650,1100,60);


  strokeWeight(6);
  stroke(255,0,0);

  for(int i = 270; i <= 360; i+= 30){
    //point(500-200*sin(i),500-200*sin(i));
     point(700+50*cos(radians(i)),650+50*sin(radians(i)));
     //point(500+200*cos(radians(i)),400+200*sin(radians(i)));

  }

  for(int i2 = 180; i2 <= 270; i2+= 30){
    //point(500-200*sin(i),500-200*sin(i));
     point(400+50*cos(radians(i2)),650+50*sin(radians(i2)));
     //point(500+200*cos(radians(i)),400+200*sin(radians(i)));

  }

for(int i3= 0; i3 < 7; i3++){
  point(400+50*i3, 650);
  point(400+50*i3,600);
}



stroke(255,0,0);//波書く
strokeWeight(3);
    for(int i4 = 270; i4 <= 360; i4+= 1){
    //point(500-200*sin(i),500-200*sin(i));
     point(700+100*cos(radians(i4)),650+100*sin(radians(i4)));
     //point(500+200*cos(radians(i)),400+200*sin(radians(i)));

  }

  for(int i5 = 180; i5 <= 270; i5+= 1){
    //point(500-200*sin(i),500-200*sin(i));
     point(400+100*cos(radians(i5)),650+100*sin(radians(i5)));
     //point(500+200*cos(radians(i)),400+200*sin(radians(i)));

  }

line(400,550,700,550);


stroke(180);
for(int i10 = 0; i10 < 300; i10+= 30){
  line(400,450+i10,400,465+i10);
}
for(int i = 0; i < 300; i+= 30){
  line(700,450+i,700,465+i);
}


strokeWeight(4);
stroke(0);
line(400,500,700,500);
yokohidari(400,500);
yokomigi(700,500);





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


