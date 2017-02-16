void setup(){
  size(1180,900);
  background(255);
  strokeWeight(2);
  
  for(int count = 50; count<760; count+= 30){
    line(460, 50+count, 460, count+65);
  }
  
   for(int count = 50; count<360; count+= 30){
    line(900, count, 900, count+15);
  }
  
     for(int count = 50; count<300; count+= 30){
    line(820, count+50, 820, count+65);
  }
    
   for(int count = 150; count<360; count+= 30){
    line(180, 380+count, 180, count+395);
  }
  
  
for(int i = 100; i < 1090; i++){
  point(i,height/2-200 + 80*-sin(radians(i-100)));
  if(i == 900){
    strokeWeight(10);
    stroke(255,0,0);
    point(i,height/2-200 + 80*-sin(radians(i-100)));
    strokeWeight(2);
    stroke(0);
    
    
  }
}
line(100,50,100,height-50);
line(50,height/2-200, width-50, height/2-200);
line(50,height/2+200, width-50, height/2+200);

for(int i = 100; i < 460; i++){
  point(i,height/2+200 + 80*-sin(radians(i-100)));
    if(i == 180){
    strokeWeight(10);
    stroke(255,0,0);
    point(i,height/2+200 + 80*-sin(radians(i-100)));
    strokeWeight(2);
    stroke(0);
    
    
  }
}

stroke(0,0,255);
line(100,height/2-380,895,height/2-380);
yokohidari(100,height/2-380);
yokomigi(895,height/2-380);

line(100,height/2-310,460,height/2-310);
yokohidari(100,height/2-310);
yokomigi(460,height/2-310);

line(460,height/2-310,820,height/2-310);
yokohidari(465,height/2-310);
yokomigi(815,height/2-310);


/*line(820,height/2-310,895,height/2-310);
yokohidari(820,height/2-310);
yokomigi(895,height/2-310);
*/




line(100,height/2+100,175,height/2+100);
yokohidari(100,height/2+100);
yokomigi(175,height/2+100);


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

