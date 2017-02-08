Wave wave_1;
Wave wave_2;
boolean wave_2_draw = false;
boolean keyReleased = false;
boolean exist_wave_2 = false;
boolean check_mode = false;
int number_wave_point = 1;
int size = 600; 
int point_regulation = 2;
float make_time_wave_2;
float[][] point = new float[size/point_regulation][size/point_regulation];
float[][] point_distance_1 = new float[size/point_regulation][size/point_regulation];
float[][] point_distance_2 = new float[size/point_regulation][size/point_regulation];

void setup()
{  
  colorMode(HSB, 360,100,100);
  size(size,size);
  frameRate(30);
  wave_1 = new Wave(width/2-50,size/2,5.0,30.0,0);

  for(int i = 0; i < size/point_regulation; i++)
  {
    for(int j = 0; j < size/point_regulation; j++)
    {
      point_distance_1[i][j] = distance_calculate(width/2-50,size/2,i*point_regulation,j*point_regulation);
      point_distance_2[i][j] = distance_calculate(width/2+50,size/2,i*point_regulation,j*point_regulation);
    }
  }
}

void draw(){  
  background(255);
  //println(frameRate);
  strokeWeight(point_regulation);
  
  if(wave_2_draw == true)
  {
    draw_two_wave();
  }else if(check_mode == true)
  {
    draw_check();
  }else
    {
    draw_one_wave();
  }
}



void keyPressed()
{
  if(keyReleased == true && exist_wave_2 == false)
  {
    if((keyPressed == true) && ((key == 'n') ||  (key == 'N')))
    {
      make_time_wave_2 = millis();
      wave_2 = new Wave(width/2+50,size/2,50.0,5.0,make_time_wave_2);
      wave_2_draw = true;
      number_wave_point = 2;
      println(make_time_wave_2);
      keyReleased = false;
      exist_wave_2 = true;
    }
    if((keyPressed == true) && ((key == 'c') ||  (key == 'C')))
    {
      keyReleased = false;
      check_mode = true;
    }
    if((keyPressed == true) && ((key == 'b') ||  (key == 'B')))
    {
      keyReleased = false;
      check_mode = false;
    }
  }
}

void keyReleased() 
{
  keyReleased = true;
}

float distance_calculate(int center_x, int center_y,int x, int y)
{
  float a = dist(center_x,center_y,x,y);
  return a;
}

void draw_one_wave()
{
  for(int i = 0; i < size/point_regulation; i++)
  {
    for(int j = 0; j < size/point_regulation; j++)
    {
      float y = wave_1.now_displacement_y(point_distance_1[i][j],wave_1.lambda, wave_1.period, wave_1.time_adjustment);
      point[i][j] += y+number_wave_point;
      stroke(230-point[i][j]*(230/(number_wave_point*2)),100,100);
      point(i*point_regulation,j*point_regulation);
      point[i][j] = 0;

    }
  } 
  stroke(300,100,100);
  strokeWeight(20);
  point(wave_1.center_x, wave_1.center_y); 
}

void draw_two_wave()
{
  for(int i = 0; i < size/point_regulation; i++)
  {
    for(int j = 0; j < size/point_regulation; j++)
    {
      float y = wave_1.now_displacement_y(point_distance_1[i][j],wave_1.lambda, wave_1.period, wave_1.time_adjustment);
      point[i][j] += y+number_wave_point;
      y = wave_2.now_displacement_y(point_distance_2[i][j],wave_2.lambda,wave_2.period, wave_2.time_adjustment);
      point[i][j] += y; 
      stroke(230-point[i][j]*(230/(number_wave_point*2)),100,100);
      point(i*point_regulation,j*point_regulation);
      point[i][j] = 0;
    }
  }
  stroke(300,100,100);
  strokeWeight(20);
  point(wave_1.center_x, wave_1.center_y);
  point(wave_2.center_x, wave_2.center_y);
}

void draw_check()
{
    for(int i = 0; i < size/point_regulation; i++)
  {
    for(int j = 0; j < size/point_regulation; j++)
    {
      float y = wave_1.now_displacement_y(point_distance_1[i][j],wave_1.lambda, wave_1.period, wave_1.time_adjustment);
      //point[i][j] += y+number_wave_point;
      //stroke(230-point[i][j]*(230/(number_wave_point*2)),100,100);
      //point(i*point_regulation,j*point_regulation);
      point[i][j] = 0;
      if(j==150) point(i*point_regulation,150+y*20);
    }
   
  } 
}

class Wave
{
  int center_x;
  int center_y;
  float lambda;
  float period;
  float time_adjustment;

  Wave(int _center_x, int _center_y, float _lambda, float _period, float _time_adjustment)
  {
    center_x = _center_x;
    center_y = _center_y;
    lambda = _lambda;
    period = _period;
    time_adjustment = _time_adjustment;
  }

  float now_displacement_y(float distance, float lambda, float period, float time_adjustment)
  {
    float time_phase_difference;
    //time_phase_difference = ((millis()-time_adjustment)/1000.0)*(360.0 / period); //ここで時間差を計算している→変数で開始時刻を記録→これを代入すればいい．
    float a; 
    println(distance);
    a = (distance%lambda)*(360.0);
    //float y = sin(radians(-time_phase_difference+a));
    float y = sin(radians(a));
    return y;
  }
}


