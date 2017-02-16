void setup(){
  size(1180,900);
  background(255);
  
  strokeWeight(2);
    line(100,50,100,height-50);
line(50,height/2-200, width-50, height/2-200);
line(50,height/2+200, width-50, height/2+200);

stroke(255,0,0);

  /*for(int count = 50; count<760; count+= 30){
    line(530, 50+count, 530, count+65);
  }

  for(int count = 50; count<760; count+= 30){
    line(530, 50+count, 530, count+65);
  }*/




for(int i = 100; i < 1090; i++){//t0_t1
  point(i,height/2+200 + 80*-sin(radians(i-100)));

}  

stroke(150); 
   

/*for(int count = 50; count<760; count+= 30){//tennsenn
    line(280, 50+count, 280, count+65);
  }

for(int count = 50; count<760; count+= 30){//tennsenn
    line(370, 50+count, 370, count+65);
  }*/
   
for(int count = 50; count<760; count+= 30){//tennsenn
    line(190, 50+count, 190, count+65);
  }   

for(int count = 50; count<760; count+= 30){//tennsenn
    line(460, 50+count, 460, count+65);
  }   

for(int count = 50; count<760; count+= 30){//tennsenn
    line(550, 50+count, 550, count+65);
  }   




for(int i = 30; i < 1090; i++){
  point(i,height/2+200 + 80*-sin(radians(i-190)));

}


  strokeWeight(4);
  


 
for(int i = 30; i < 1090; i++){
  point(i,height/2-200 + 80*-sin(radians(i-100)));
  
}


 stroke(0,0,255); 



for(int i = 30; i < 1090; i++){
  point(i,height/2+200 + 80*-sin(radians(i-100)));

}


    stroke(255,0,0);
    strokeWeight(20);
    /*point(530,height/2-200 + 80*-sin(radians(530-100)));
    point(530,height/2+200 + 80*-sin(radians(530-100)));
    point(620,height/2+200 + 80*-sin(radians(530-100)));*/
    point(100,height/2-200);
    point(100,height/2+200);
    
    stroke(0,0,255);
    strokeWeight(4);






line(105,height/2+90, 185,height/2+90);
yokomigi(185,height/2+90);
yokohidari(105,height/2+90);

line(465,height/2+90, 545,height/2+90);
yokomigi(545,height/2+90);
yokohidari(465,height/2+90);


strokeWeight(6);
stroke(255,0,0);
line(width-250,150,width-100,150);
yokomigi(width-100,150);



stroke(150); 
   
/*strokeWeight(2);
    for(int count = 0; count<90; count+= 10){
    line(530+count, height/2+120, 535+count, height/2+120);
  }*/   

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

