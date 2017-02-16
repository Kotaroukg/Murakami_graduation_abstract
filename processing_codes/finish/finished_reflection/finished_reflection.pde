//反射のプログラム

Incident_waves f_wave;
int angle = 25;

Elementary_waves[] elementary_waves_array;
boolean keyReleased = false;
boolean check_mode = false;
int number_wave_point = 0;
int size = 400; 
int point_regulation = 4;
int s_p = size/point_regulation;
int maximum_waves_number = 5; 
int create_point_flag = 0;
float point_width;
float surface = size/5*3;

float[][] point = new float[s_p][s_p];
float[][] point_distance = new float[s_p*maximum_waves_number][s_p];
boolean[][] point_draw_flag  = new boolean[s_p][s_p];
boolean check = false;
boolean slider_dragged = false;
boolean draw_line_point = true;

//float lambda = 300.0;
//float period = 3.0;
float record_lambda;
float cross_line_x;
int cross_line_x_i;

float average_slope = 0;
int average_slope_count = 0;


float max_phase = 0;
int max_phase_x;
int max_phase_y;

float y_to_x;

float max_line_flag;

float wave_period = 5.0;


float incident_x_speed;


void setup() {  
  colorMode(HSB, 360, 100, 100);
  size(size+200, size);
  frameRate(10);
  //println(frameRate);
  f_wave = new Incident_waves();
  f_wave.calculate_cross_line_x();
  elementary_waves_array = new Elementary_waves[maximum_waves_number];
  make_waves_instance(); //全ての点源のインスタンスを作成
  //calculate_refraction_angle();
}


void make_waves_instance() {
  for (int i = 0; i < elementary_waves_array.length; i++) {
    
    Elementary_waves elementary_waves = new Elementary_waves(((-cross_line_x)+(float)point_width*(i-2.0)), surface, f_wave.speed*cos(radians(angle))*frameRate*wave_period, wave_period);
    elementary_waves_array[i] = elementary_waves;
    int s_p_n = s_p * i;
    for (int j = 0; j < s_p; j++) {
      for (int k = 0; k < s_p; k++) {
        point_distance[j+s_p_n][k] = distance_calculate(elementary_waves_array[i].center_x, //ここはs
        elementary_waves_array[i].center_y, j*point_regulation, k*point_regulation);
      }
    }
  }
}


void draw() {  
  background(255);
  strokeWeight(point_regulation);
  draw_wave();
}




float distance_calculate(float center_x, float center_y, float x, float y) {
  float a = dist(center_x, center_y, x, y);
  return a;
}

void draw_wave() { //波が一つのバージョン
  f_wave.draw_incident_waves();
  int number_wave_point2 = number_wave_point*2;
  for (int i = cross_line_x_i; i < s_p; i++) {/////////
    for (int j = 0; j < s_p/5*3; j++) {
      for (int k = 0; k < number_wave_point; k++) {
        float range = elementary_waves_array[k].range_to_calculate();//現在の波の最先端の距離を計算
        float range2 = range - (elementary_waves_array[k].lambda); //ここを消せば波が増える

        if (point_distance[i+s_p*k][j] < range && point_distance[i+s_p*k][j] > range2) { //クラス配列，各点と波ごとの距離と範囲を比較

          float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j], 
            elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
          point[i][j] += y;
        } else {
        }
      }//kはここまで

      point[i][j] += number_wave_point;
      if (number_wave_point != 0) {
        stroke( (number_wave_point2- point[i][j])*(230/number_wave_point2),100,100);
      } else {
        stroke(115, 100, 100);//波が一つも生まれてない時画面を緑にする
      }

      //max_phaseの計算
      if(number_wave_point>4){//全ての波源が動作し始めてから.
        if(max_phase < point[i][j])
        {
          max_phase = point[i][j];
          max_phase_x = i;
          max_phase_y = j;
        }
      }


      point[i][j] = 0;//初期化
      point(i*point_regulation, j*point_regulation);

      //ここまでjが回っている
    }
  }//ここまでi


  stroke(0);
  rect(0, surface, size, 2);
  stroke(0);
  f_wave.draw_line();

  strokeWeight(6);
  for (int a = 0; a < number_wave_point; a++) {
    point(elementary_waves_array[a].center_x, elementary_waves_array[a].center_y);
  }
  slider(size+20, 20, size-50, 30, 10.0, 200.0, 40);


    if(max_phase_y!=0 &&max_phase_y*point_regulation < surface-20  ){//yの最高座標が表面離れたら,average計算して描写　
      int max_phase_x_p = max_phase_x*point_regulation;
      int max_phase_y_p = max_phase_y*point_regulation;
      average_slope += (surface-(float)max_phase_y_p)/(max_phase_x_p-elementary_waves_array[2].center_x);
      average_slope_count++;
      line(elementary_waves_array[maximum_waves_number/2].center_x, surface,
        max_phase_x_p, max_phase_y_p);
    
    float a = average_slope/(float)average_slope_count;
    //println(a);
    stroke(300,100,100);
    line(elementary_waves_array[2].center_x,elementary_waves_array[2].center_y,
      elementary_waves_array[2].center_x+500,elementary_waves_array[2].center_y-500*a);
    stroke(0);
  //println(max_phase_y);
}
  
  if(angle < 35){
    if(max_phase_y < 3 && max_phase_x*point_regulation > -cross_line_x+10){
      stroke(300,100,100);
      float a = average_slope/(float)average_slope_count;
      //println(average_slope);
      //println(average_slope_count);
      line(elementary_waves_array[2].center_x,elementary_waves_array[2].center_y,
        elementary_waves_array[2].center_x+500,elementary_waves_array[2].center_y-500*a);
      for(float count = 1.0; count < 90.0; count+=0.1){
        if( tan(radians(count)) > a ){
          println(90-count-0.1);
          break;
        }
        
      }
      noLoop();
      stroke(0);
      
    }
  }else{//35度以上
    if(max_phase_x > 97 && max_phase_x*point_regulation > -cross_line_x+10) {
      stroke(300,100,100);
      float a = average_slope/(float)average_slope_count;
      //println(a);
      //println(average_slope);
      //println(average_slope_count);
      line(elementary_waves_array[2].center_x,elementary_waves_array[2].center_y,
      elementary_waves_array[2].center_x+500,elementary_waves_array[2].center_y-500*a);
      
      for(float count = 0.1; count < 90.0; count+=0.1){
        if( tan(radians(count)) > a ){
          println(90-count-0.1);
          break;
        }
      }
      stroke(0);
      noLoop();
    }
  }
  max_phase = 0;
}




class Incident_waves {
  float x, y;
  float speed;
  Incident_waves() {
    speed = 4.0;
    y_to_x =  (cos(radians(angle)))/ (sin(radians(angle)));
    x =  (speed * y_to_x);
    y = 0;
    incident_x_speed = x;
    point_width = incident_x_speed; 
  }

  void draw_line() {
    if (angle != 0) {
      //x = (y * cos(radians(angle)))/ (sin(radians(angle)));
      //line(0,y,x,0);
      if (y >= surface)check_create_elementary_waves(x, y);
      line(-cross_line_x, 0, -cross_line_x, size);//垂線
      //line(-cross_line_x,size/2, -cross_line_x + size/2 * tan(radians(refraction_angle)),size);
      fill(255);
      noStroke();
      //rect(0,size/2, size,size/2+10);
      rect(size, 0, width-size+5, height+10);
      draw_incident_line();
    } else {
    }
    y += speed;
    //check_create_elementary_waves();
  }

  void draw_incident_waves() {
    if (angle != 0) {
      x = (y * cos(radians(angle)))/ (sin(radians(angle)));
      line(0, y, x, 0);

    } else {
    }
  }

  void check_create_elementary_waves(float x, float y) {

    for (int i = 0; i < elementary_waves_array.length; i++) {
      float collision_x = (((y-surface)/y) * x);
      //println(i + "   " + collison_x);
      strokeWeight(12);
      point(elementary_waves_array[i].center_x, elementary_waves_array[i].center_y);
      strokeWeight(point_regulation);
      if (collision_x > elementary_waves_array[i].center_x && elementary_waves_array[i].collision_check_flag == false) {
        elementary_waves_array[i].created_time = millis();
        elementary_waves_array[i].collision_check_flag = true;
        number_wave_point++;
        create_point_flag++;
      }
    }
  }


  void calculate_cross_line_x() {
    float a = tan(radians(angle));
    float b = (-1.0) / a; //接線の方程式のためにa*bが-1になるように調整
    cross_line_x = surface/b;
    //println(cross_line_x);
    cross_line_x_i = (int)((-cross_line_x)/point_regulation + 1);
  }

  void draw_incident_line() {
    stroke(0);
    line(0, 0, -cross_line_x, surface);
    line(-cross_line_x, surface, -2*cross_line_x, 0);
  }
}



class Elementary_waves {
  float center_x;
  float center_y;
  float lambda;
  float period;
  float created_time;
  float range_to_calculate;
  boolean draw_flag;
  boolean collision_check_flag;

  Elementary_waves(float _center_x, float _center_y, float _lambda, float _period) {
    center_x = _center_x;
    center_y = _center_y;
    lambda = _lambda;
    period = _period;
    created_time = 0; //とりあえず代入している
    draw_flag = false;
    collision_check_flag = false;
  }

  float now_displacement_y(float distance, float lambda, float period, float time_adjustment){
    float time_phase_adjustment;
    time_phase_adjustment = ((millis()-time_adjustment)/1000.0)*(360.0 / period); //ここで時間差を計算している→変数で開始時刻を記録→これを代入すればいい．
    float distance_lambda_adjustment = (distance%lambda)/lambda*(360.0);
    float y = sin(radians(time_phase_adjustment - distance_lambda_adjustment));
    return y;
  }


  float range_to_calculate() {
    float a = (millis()-created_time)*lambda/period/1000.0;
    return a;
  }
}




void slider(int position_x, int position_y, int slider_height, int slider_width, float min, float max, int number_tickmarks) {

  int num_separator = (int)map(elementary_waves_array[0].lambda, min, max, 0, number_tickmarks-1); //temper=グローバル min~maxの範囲を０からnumber_tickmarksに変換
  float cordinate_y = position_y + slider_height - ((float)slider_height / (number_tickmarks-1))*num_separator;
 

  text( "lambda="+nf(elementary_waves_array[0].lambda, 1, 1), position_x, position_y + slider_height + 20);

  //nf = 数値のフォーマット　今回の場合は小数点以上１，小数点以下１
  if (mousePressed==false) slider_dragged=false;
  if (mouseX >= position_x & mouseX <= position_x + slider_width & mouseY<=cordinate_y+10 & mouseY>= cordinate_y-10) {
    if (mousePressed) {
      slider_dragged= true;
    }
  }

}



