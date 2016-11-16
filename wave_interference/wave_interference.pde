Wave wave_1,wave_2;
float color_regulation = 0;
int size = 500; 
float[][] point = new float[size/4][size/4];

void setup(){  
  colorMode(RGB);
  size(size,size);
  frameRate(6);
  wave_1 = new Wave(200,250,80);
  wave_2 = new Wave(400,250,80);
}

void draw(){  
  background(255);
  for(int i = 0; i < size/4; i++){
    for(int j = 0; j < size/4; j++){
      float distance = wave_1.distance_calculate(i*4,j*4);
      float y = wave_1.now_displacement_y(distance,wave_1.lambda);
      point[i][j] += y;
      /*distance = wave_2.distance_calculate(i*4,j*4);
      y = wave_2.now_displacement_y(distance,wave_2.lambda);
      point[i][j] += y;
      */
      color_regulation = y+1.0;
      
      //stroke(color_regulation*64,0,360 - color_regulation*64);
      fill(color_regulation*123,0,360 - color_regulation*123);
      rect(i*4,j*4,i+2,j+2);
      println(color_regulation);
      

    }
  } 
  
}

class Wave{
  int center_x;
  int center_y;
  int lambda;

  Wave(int _center_x, int _center_y, int _lambda){
    center_x = _center_x;
    center_y = _center_y;
    lambda = _lambda;
  }

  float distance_calculate(int x, int y){
    float a = dist(center_x,center_y,x,y);
    return a;


  }

  float now_displacement_y(float distance, int lambda){
    float omega;
    omega = millis()/4000 * 360; //周期は4秒
    float a; 
    a = distance/lambda * 360;
    //float y = sin(omega+a);
    float y = degrees(sin(omega+a));
    
    return y;
  }


}


