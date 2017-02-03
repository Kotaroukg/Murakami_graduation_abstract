//Test AppInfoLoader class
private final String TARGET_CLASS_NAME = "AppInfoLoader";
private final String SOME_TROUBLE = TARGET_CLASS_NAME + " : "
                                  + "Some trouble happend.";
void setup(){
  test();
}

void test(){
  noLoop();
  println("Test Start.");
  assert AppInfoLoader.CLASS_NAME.equals(TARGET_CLASS_NAME)
       : SOME_TROUBLE;
  AppInfoLoader ail = new AppInfoLoader();
  assert ail.CLASS_NAME.equals(TARGET_CLASS_NAME);
  println("All Test Done.");
  exit();
}
