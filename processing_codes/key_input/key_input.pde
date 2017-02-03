String typekey;
String presskey;
import java.applet.Applet;
import java.awt.Graphics;
import java.awt.event.KeyListener;
import java.awt.event.KeyEvent;
import java.awt.event.InputEvent;

void setup(){
  size(300,300);
}
void draw(){
  
  if(typekey != null)text(typekey, 100,100);
}
  public void keyPressed(KeyEvent e){
    int keycode = e.getKeyCode();
    presskey = e.getKeyText(keycode);

    int mod = e.getModifiersEx();

    if ((mod & InputEvent.SHIFT_DOWN_MASK) != 0){
      presskey += " +SHIFT";
    }

    if ((mod & InputEvent.ALT_DOWN_MASK) != 0){
      presskey += " +ALT";
    }

    if ((mod & InputEvent.CTRL_DOWN_MASK) != 0){
      presskey += " +CTRL";
    }
  }
  
  
  public void keyTyped(KeyEvent e){
    char key = e.getKeyChar();
    typekey += key;
  }

