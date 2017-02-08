Incident_waves f_wave;
int angle = 40;
//float refractive_index = 1.7;


Elementary_waves[] elementary_waves_array;
boolean keyReleased = false;
boolean check_mode = false;
int number_wave_point = 0;
int size = 400; 
int point_regulation = 4;
int s_p = size/point_regulation;
int maximum_waves_number = 5; 
int create_point_flag = 0;
float point_width = 4.0;
float surface = size/5*3;

float[][] point = new float[s_p][s_p];
float[][] point_distance = new float[s_p*maximum_waves_number][s_p];
boolean[][] point_draw_flag  = new boolean[s_p][s_p];
boolean check = false;
boolean slider_dragged = false;
boolean draw_line_point = true;

float lambda = 50.0;
//float period = 3.0;
float record_lambda;
float framerate = 20.0;

float cross_line_x;
int cross_line_x_i;

float average_slope = 0;
int average_slope_count = 0;






float max_phase = 0;
int max_phase_x;
int max_phase_y;

float c;





void setup() {  
  colorMode(HSB, 360, 100, 100);
  size(size+200, size);
  frameRate(framerate);
  f_wave = new Incident_waves();
  f_wave.calculate_cross_line_x();
  elementary_waves_array = new Elementary_waves[maximum_waves_number];
  make_waves_instance(); //全ての点源のインスタンスを作成
  //calculate_refraction_angle();
}


void make_waves_instance() {
  for (int i = 0; i < elementary_waves_array.length; i++) {
    //Elementary_waves elementary_waves = new Elementary_waves(((-cross_line_x)+(float)point_width*(i-2)), surface, frameRate*f_wave.speed, f_wave.x); //点源５つなのでi-2している
    Elementary_waves elementary_waves = new Elementary_waves(((-cross_line_x)+(float)point_width*(i-2.0)), surface, f_wave.speed*framerate*15, 1.0*15);
    elementary_waves_array[i] = elementary_waves;
    //println(elementary_waves_array[i].center_x);
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
  //println(frameRate);
  background(255);
  strokeWeight(point_regulation);
  draw_wave();
}


void keyPressed() {
  if ((keyPressed == true) && keyReleased == true &&((key == 'c') ||  (key == 'C'))) {
    keyReleased = false;
    check_mode = true;
  }
  if ((keyPressed == true) && keyReleased == true && ((key == 'b') ||  (key == 'B'))) {
    keyReleased = false;
    check_mode = false;
  }
}

void keyReleased() {
  keyReleased = true;
}

float distance_calculate(float center_x, float center_y, float x, float y) {
  float a = dist(center_x, center_y, x, y);
  return a;
}

void draw_wave() { //波が一つのバージョン
  f_wave.draw_incident_waves();
  for (int i = cross_line_x_i; i < s_p; i++) {/////////
    for (int j = 0; j < s_p/5*3; j++) {
      for (int k = 0; k < number_wave_point; k++) {
        float range = elementary_waves_array[k].range_to_calculate();//現在の波の最先端の距離を計算
        float range2 = range - elementary_waves_array[k].lambda; //ここを消せば波が増える

        if (point_distance[i+s_p*k][j] < range && point_distance[i+s_p*k][j] > range2) { //クラス配列，各点と波ごとの距離と範囲を比較

          float y = elementary_waves_array[k].now_displacement_y(point_distance[i+s_p*k][j], 
          elementary_waves_array[k].lambda, elementary_waves_array[k].period, elementary_waves_array[k].created_time);
          point[i][j] += y;
        } else {
        }
      }//kはここまで
      point[i][j] += number_wave_point;


      //////////こっからmax_phase
      if (number_wave_point > 4) {
        if (max_phase > point[i][j]) {
          max_phase = point[i][j];
          max_phase_x = i;
          max_phase_y = j;
        }
      }


      if (number_wave_point != 0) {
        stroke(point[i][j]*(230.0/(number_wave_point*2.0)), 100, 100);
      } else {
        stroke(115, 100, 100);//波が一つも生まれてない時画面を緑にする
      }
      point[i][j] = 0;
      point(i*point_regulation, j*point_regulation);

      //ここまでjが回っている
    }
  }//ここまでi
  stroke(300, 100, 100);
  rect(0, surface, size, 2);
  stroke(0);


  f_wave.draw_line();

  strokeWeight(6);

  for (int a = 0; a < number_wave_point; a++) {
    point(elementary_waves_array[a].center_x, elementary_waves_array[a].center_y);
    text(a+1, elementary_waves_array[a].center_x-10, elementary_waves_array[a].center_y+30);
  }
  slider(size+20, 20, size-50, 30, 10.0, 200.0, 40);

  line(elementary_waves_array[maximum_waves_number/2+1].center_x, elementary_waves_array[maximum_waves_number/2+1].center_y, max_phase_x*point_regulation, max_phase_y*point_regulation);
  max_phase = maximum_waves_number*2;
  if(max_phase_x != 0 && max_phase_y*point_regulation < surface - 20 ) {
    average_slope += (float)max_phase_y/(float)max_phase_x;
    average_slope_count++;
    //println(average_slope);
  }
  //println(max_phase_y);
  
  if(angle < 40){
    if(max_phase_y < 3 && max_phase_x*point_regulation > -cross_line_x+10){
      stroke(300,100,100);
      float fuck = average_slope/(float)average_slope_count;
      println(average_slope);
      println(average_slope_count);
      println(fuck);
      stroke(300,100,100);
      //line(elementary_waves_array[maximum_waves_number/2+1].center_x, elementary_waves_array[maximum_waves_number/2+1].center_y,500, -(500*fuck-surface));
      stroke(0);
      noLoop();
    }
  }else{
    if(max_phase_x > s_p-3) noLoop();
  }

 /* line(elementary_waves_array[maximum_waves_number/2+1].center_x, elementary_waves_array[maximum_waves_number/2+1].center_y, max_phase_x*point_regulation, max_phase_y*point_regulation);
  max_phase = maximum_waves_number*2;
  average_slope += (float)max_phase_y/(float)max_phase_x;
  average_slope_count++;*/
}




class Incident_waves {
  float x, y;
  float speed;
  Incident_waves() {
    speed = 1.5;
    x =  (speed *(cos(radians(angle))))/ (sin(radians(angle)));
    c =  (cos(radians(angle)))/ (sin(radians(angle)));
    y = 0;
    //speed = 1.0;
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

  float now_displacement_y(float distance, float lambda, float period, float time_adjustment) {
    float time_phase_difference;
    time_phase_difference = ((millis()-time_adjustment)/1000.0)*(360.0 / period); //ここで時間差を計算している→変数で開始時刻を記録→これを代入すればいい．
    float a; 
    a = (distance%lambda)/lambda*(360.0);
    float y = sin(radians(-time_phase_difference+a));
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



