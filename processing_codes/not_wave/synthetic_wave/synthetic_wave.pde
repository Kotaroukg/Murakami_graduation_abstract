boolean check_mode = false;
boolean fmode = false;
void setup(){
  scale(2.0);
  frameRate(1);
  size(920,1000);
  background(255);
  strokeWeight(2);
  float a[] = new float[81];
  int count = 0;
  line(50,height/2, width-50, height/2);
  
    for(int i = 300; i < 480; i++){
      stroke(0);
  
  if(count > 100 && count < 180){
  stroke(200);
  point(i,height/2 + 70*-sin(radians(i-300)));
  a[count-100] += 70*-sin(radians(i-300));
  }else{
    point(i,height/2 + 70*-sin(radians(i-300)));
  }
  count++;
}
count = 0;
for(int j = 400; j < 580; j++){
  stroke(0);
 
  if(count < 80) {
    stroke(200);
    point(j,height/2 + 110*-sin(radians(j-400)));
  a[count] += 110*-sin(radians(j-400));
  }else{
     point(j,height/2 + 110*-sin(radians(j-400)));
  }
  count++;
}

stroke(0,0,255);
for(int k = 400; k < 480; k++){
  point(k,height/2 + a[k-400]);
}




}

void draw(){
  
  if(check_mode == true){
  background(255);
    stroke(0);
  for(int i = 150; i < 330; i++){
  point(i,height/2 + 70*-sin(radians(i-150)));
}

for(int j = 550; j < 730; j++){
  point(j,height/2 + 110*-sin(radians(j-550)));
}
 line(50,height/2, width-50, height/2);

  }
  
  if(fmode == true){
     background(255);
    stroke(0);
    check_mode = false;
      for(int i = 550; i < 730; i++){
  point(i,height/2 + 70*-sin(radians(i-550)));
}

for(int j = 150; j < 330; j++){
  point(j,height/2 + 110*-sin(radians(j-150)));
}
 line(50,height/2, width-50, height/2);

  }
  


}



void keyPressed(){
  if((keyPressed == true)&&((key == 'c') ||  (key == 'C'))){
    check_mode = true;
  }
  
    if((keyPressed == true)&&((key == 'f') ||  (key == 'F'))){
    fmode = true;
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

