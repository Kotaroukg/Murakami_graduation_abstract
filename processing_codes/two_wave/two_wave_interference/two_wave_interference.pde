Wave wave_1;
Wave wave_2;
int number_wave_point = 2;
int size = 500; 
int point_regulation = 4;
float[][] point = new float[size/point_regulation][size/point_regulation];


void setup(){  
  colorMode(HSB, 360,100,100);
  size(size,size);
  frameRate(3);
  //strokeWeight(point_regulation);
  wave_1 = new Wave(200,250,1000.0,5.0);
  wave_2 = new Wave(400,250,1000.0,5.0);
}



void draw(){  
  background(255);
  strokeWeight(point_regulation);
  for(int i = 0; i < size/point_regulation; i++){
    for(int j = 0; j < size/point_regulation; j++){
      float distance = wave_1.distance_calculate(i*point_regulation,j*point_regulation);
      float y = wave_1.now_displacement_y(distance,wave_1.lambda, wave_1.period);
      point[i][j] += y+number_wave_point;
      
      distance = wave_2.distance_calculate(i*point_regulation,j*point_regulation);
      y = wave_2.now_displacement_y(distance,wave_2.lambda,wave_2.period);
      point[i][j] += y; 
      //println(color_regulation);
      
      
      //stroke(color_regulation*64,0,360 - color_regulation*64);
      stroke(230-point[i][j]*(230/(number_wave_point*2)),100,100);
      point(i*point_regulation,j*point_regulation);
      //println("i = "+i + "  j =" + j + "  point = " +point[i][j]);
      point[i][j] = 0;

    }
  } 
  stroke(300,100,100);
  strokeWeight(20);
  point(wave_1.center_x, wave_1.center_y);
  point(wave_2.center_x, wave_2.center_y);

}

class Wave{
  int center_x;
  int center_y;
  float lambda;
  float period;

  Wave(int _center_x, int _center_y, float _lambda, float _period){
    center_x = _center_x;
    center_y = _center_y;
    lambda = _lambda;
    period = _period;
    //conversion_angle = 360/period;
  }

  float distance_calculate(int x, int y){
    float a = dist(center_x,center_y,x,y);
    return a;


  }

  float now_displacement_y(float distance, float lambda, float period){
    float time_phase_difference;
    time_phase_difference = (millis()/1000.0)*(360.0 / period); //周期は4秒
    //println("timephase =" + time_phase_difference);
    float a; 
    a = (distance%lambda)*(360.0 / period);
    //println("a = " + a);
    float y = sin(radians(-time_phase_difference+a));
    //println("y = " + y);
    return y;
  }


}






//ポイントごとにあらかじめsetupで距離を計算させ，各配列に記憶させておくことにより，毎回
//計算を呼び出さなくても済むのではないか？








