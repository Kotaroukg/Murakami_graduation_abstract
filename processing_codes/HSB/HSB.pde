void setup(){  
  colorMode(HSB, 360,100,100,100);
  size(300,900);
  strokeWeight(2);
  for(int i = 360; i > -1; i--){
    stroke(abs(i),100,100,100);
    line(50,90+abs(i-360)*2, 250, 90+abs(i-360)*2);
    fill(0);
    if(i % 10 == 0)text(i, 260,90+abs(i-360)*2);
    
  }

}


