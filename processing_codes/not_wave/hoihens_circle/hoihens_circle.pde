//上から描写していく
//先に円から描写して,下を四角で囲む

void setup(){
  size(1000,800);
  background(255);
  
  
  
  
 /* for(int i = 0; i < 360; i+= 10){
    //point(500-200*sin(i),500-200*sin(i));

     ellipse(500+300*cos(radians(i)),400+300*sin(radians(i)),200,200);

  }*/


stroke(0,0,255);
noFill();
    for(int i = 0; i <= 360; i+= 15){
    //point(500-200*sin(i),500-200*sin(i));

     ellipse(500+200*cos(radians(i)),400+200*sin(radians(i)),200,200);

  }

   fill(255);
  noStroke();
  ellipse(500,400,550,550);
  noFill();
  stroke(0,0,255);

    for(int i = 0; i <= 360; i+= 30){
    //point(500-200*sin(i),500-200*sin(i));
     ellipse(500+100*cos(radians(i)),400+100*sin(radians(i)),200,200);
 
  }

     fill(255);
  noStroke();
  ellipse(500,400,350,350);
  noFill();
  stroke(0,0,255);





  strokeWeight(6);
  stroke(255,0,0);

  for(int i = 0; i < 360; i+= 30){
    //point(500-200*sin(i),500-200*sin(i));
     point(500+100*cos(radians(i)),400+100*sin(radians(i)));
     //point(500+200*cos(radians(i)),400+200*sin(radians(i)));

  }
  
    for(int i = 0; i < 360; i+= 15){
    //point(500-200*sin(i),500-200*sin(i));

     //point(500+200*cos(radians(i)),400+200*sin(radians(i)));

  }
strokeWeight(2);

ellipse(500,400,200,200);
  ellipse(500,400,400,400);
  ellipse(500,400,600,600);

strokeWeight(10);
point(500,400);


stroke(0,0,255);
strokeWeight(5);

 



}


