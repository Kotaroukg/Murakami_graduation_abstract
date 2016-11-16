Elementary_waves e_wave_1, e_wave_2, e_wave_3;
Incident_waves f_wave;

int angle = 45;

void setup(){
  size(1000,1000);
  //scale(1,0.5);
  smooth();
  frameRate(20);
  line(0,height/2-100,width,height/2-100);
  set_elementary_waves_lotation();
  f_wave = new Incident_waves();


}

void draw(){
  background(255);
  noFill();
  if(e_wave_1.draw_flag == true){
    e_wave_1.create_elementary_wave();
    e_wave_1.display();
  }
  if(e_wave_2.draw_flag == true){
    e_wave_2.create_elementary_wave();
    e_wave_2.display();
  }
  if(e_wave_3.draw_flag == true){
    e_wave_3.create_elementary_wave();
    e_wave_3.display();
  }
  fill(255);
  rect(0,0,width,height/2-101);
  f_wave.draw_incident_waves();
  fill(0);
  
}

void set_elementary_waves_lotation(){
  float e_wave_1_x = width/2-100;
  float e_wave_1_y = height/2-100;
  float e_wave_2_x = width/2;
  float e_wave_2_y = height/2-100;
  float e_wave_3_x = width/2+100;
  float e_wave_3_y = height/2-100;

  
  e_wave_1 = new Elementary_waves(255,0,0,e_wave_1_x,e_wave_1_y,false); // RGB 初期座標xy １フレームごとの加速ピクセル
  e_wave_2 = new Elementary_waves(0,255,0,e_wave_2_x,e_wave_2_y,false);
  e_wave_3 = new Elementary_waves(0,0,255,e_wave_3_x,e_wave_3_y,false);
}


class Elementary_waves{
  int color_a, color_b, color_c;
  float coordinates_x, coordinates_y;
  int speed;
  //int radius;
  ArrayList elementary_wave;
  boolean draw_flag;

  Elementary_waves(int _color_a, int _color_b, int _color_c,
      float _coordinates_x, float _coordinates_y, boolean _draw_flag){
    color_a = _color_a;
    color_b = _color_b;
    color_c = _color_c;
    coordinates_x = _coordinates_x;
    coordinates_y = _coordinates_y;
    speed = 40; //　１フレームあたりの素元波のスピード
    elementary_wave = new ArrayList();
    draw_flag = _draw_flag;
  }

  void create_elementary_wave(){
    elementary_wave.add(new Elemntary_wave(0,speed)); 
  }
 

  void display(){
    stroke(color_a, color_b, color_c);
    pushMatrix();
    translate(coordinates_x,coordinates_y);
    for(int i = elementary_wave.size()-1; i>=0; i--){
      Elemntary_wave e = (Elemntary_wave)elementary_wave.get(i);
      if(e.update() == false)
      elementary_wave.remove(i);
      }
    popMatrix();
    stroke(0,0,0);//syokika
  }



}


class Elemntary_wave{
  int radius;
  int speed;
  Elemntary_wave(int _radius, int _speed){
    radius = _radius;
    speed = _speed;
  }

  boolean update(){                   // ここで素元波を描く
    radius += speed;
    ellipse(0,0,radius,radius);
    if(radius > width*3 || radius > height*3){
      return false;
    }
    return true;
  }
}
//

class Incident_waves{
  float x,y;
  int speed;
  Incident_waves(){
    x = 0;
    y = 0;
    speed = 5;
    
  }

  void draw_incident_waves(){
    if(angle != 0){
      x = (y * cos(radians(angle)))/ (sin(radians(angle)));
      line(0,y,x,0);
      //fill(255);
      //rect(0,height/2+101,width,height);
      //fill(0);  
      check_create_elementary_waves();
 
    }else{
       line(0,y,width,y); //angle == 0
       if(y > e_wave_1.coordinates_y) {e_wave_1.draw_flag = true; println("fsdaffsad");}
    }
   
    y += speed;
  }




 

  void check_create_elementary_waves(){
    float check_y_1 = y - (y / x) * e_wave_1.coordinates_x; 
    if(check_y_1 > e_wave_1.coordinates_y) {e_wave_1.draw_flag = true;}
    /*check_x = (-1)*(e_wave_2.coordinates_x - y) / (y/x);
    if(check_x > e_wave_2.coordinates_x) e_wave_2.draw_flag = true;
    check_x = (-1)*(e_wave_3.coordinates_x - y) / (y/x);
    if(check_x > e_wave_3.coordinates_x) e_wave_3.draw_flag = true;*/
  }

}
