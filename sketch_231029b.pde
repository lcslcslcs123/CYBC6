int num=200;
boolean showDot=true;
PVector gravity = new PVector(0, 0.1);
//PVector mouseVec;
String word;
Dot[] dots;
int Chang;
int Kuan;
int Jiao;
color c1=0;
PFont myfont;

PGraphics stringPattern, mask;








//声明调色盘参数
color[] pallette;// = {color(203, 37, 37), color(240, 211, 46), color(52, 108, 224), color(60, 180, 93), color(95, 79, 206)};
int numOfColor = 10;//色块数
float palletteWidth;//色块宽度
float palletteHeight;//色块高度
//声明调色盘参数


//建立一个调色盘
void generatePallette() {
  pallette = new color[numOfColor];//初始化调色盘
  for (int i = 0; i < pallette.length; i ++) {
    pallette[i] = color(random(255), random(255), random(255));//随机生成颜色并赋值到调色盘
  }
}
//建立一个调色盘








void setup() {
  size(800, 800);
  background(0);
 
  initiateData();

  stringPattern = createGraphics(width, height);
  mask = createGraphics(width, height);
  //println(PFont.list());
  myfont=createFont("微软雅黑",50);
  textFont(myfont);
  //创建第1个PGraphics对象，绘制hallo字符，并保存，以便后续读取其中的像素值
  word="Write your message:\n你好\nHallo,world.";
  Chang=word.length();
  Kuan=width/Chang;
  Jiao=height/2+Kuan/2;
  
  stringPattern.beginDraw();
  stringPattern.textFont(myfont);
  stringPattern.textSize(Kuan*2);
  stringPattern.fill(255);
  stringPattern.text(word, 0, Jiao);
  stringPattern.endDraw();

  //创建第2个PGraphics对象，即绘制一个遮罩，使得"hallo"字符所在位置之外全部被不透明的黑色rect覆盖，
  //这样可以实现后续生成的dots只在有字符的地方才能看见的效果
  mask.beginDraw();
  for (int i = 0; i < stringPattern.pixels.length; i ++) {
    if (brightness(stringPattern.pixels[i])<200) {
      mask.fill(0);
      mask.noStroke();
      mask.rect(i%width, i/width, 1, 1);
    }
  }
  mask.endDraw();

  //保存生成的PGraphics对象，测试用，不是必须的
  //stringPattern.save("stringPattern.png");
  mask.save("mask.png");








  //生成调色盘
  generatePallette();
  palletteWidth = width/pallette.length;
  palletteHeight = 150;
  //生成调色盘
}







void initiateData() {
  dots = new Dot[num];
  for (int idx = 0; idx < dots.length; idx ++) {
    float nd= random(10, 50);
    float nx = random(0, width);
    float ny = random(0, height);
    dots[idx] = new Dot(nx, ny, nd);
  }
}

void draw() {

  background(255);
   
  

  for (Dot n : dots) {
    n.move();

    n.edge();
    n.collision();
    if (showDot) {
      n.show();
    }
  }

  //显示遮罩,这样可以挡住前面绘制的那些dots
  image(mask, 0, 0);







  //绘制调色盘
  pushStyle();
  noStroke();
  for (int i = 0; i < pallette.length; i ++) {
    fill(pallette[i]);
    rect(palletteWidth*i, height-palletteHeight, palletteWidth, palletteHeight);
  }
  popStyle();
  //绘制调色盘
}

void mousePressed() {
  
  color cc = get(mouseX, mouseY);
  for (Dot n : dots) {
    n.c1 = cc;
   
  }
}
