class Dot {
  color c1=0;
  PVector pos;
  //float xS, yS;
  PVector speed;
  float dotD;
  color filledColor;
  
  
  Dot(float dx, float dy, float dd) {
    pos = new PVector();
    speed = new PVector();
    pos.x = dx;
    pos.y = dy;
    dotD = dd;
    
    //filledColor = color(random(255), random(255), random(255));
    //speed.x = random(-1, 1);
    //speed.y = random(-1, 1);
    //c1=get(mouseX,mouseY);
    
    //filledColor=color(c1);
   
    
    speed = PVector.random2D();
  }

  
  void move() {
    //dotX = dotX + xS;
    //dotY = dotY + yS;
    speed.add(gravity);
    pos.add(speed);
    speed.limit(5);
  }
////mouseAttraction
//  void mouseAttraction() {
//    for (Dot dt : dots) {
//      //计算鼠标向量与目标对象之间的距离
//      float d = dist(mouseVec.x, mouseVec.y, this.pos.x, this.pos.y);
//      //创建吸引力向量ma
//      PVector ma = PVector.sub(mouseVec, pos);
//      //对ma进行归一化
//      ma.normalize();
//      //控制ma的长度，使得ma与对象的dotD值成正比，与鼠标向量与目标对象之间的距离成反比
//      ma.mult(dotD/(d*100));//*100用于控制吸引力向量ma的作用强度
//      //将ma加给speed
//      speed.add(ma);
//    }
//  }
  
 
  
  
  
  void collision() {
    for (Dot dt : dots) {
      if (dt != this) {
        
        float d = dist(dt.pos.x, dt.pos.y, this.pos.x, this.pos.y);
        
        if (d < dt.dotD/2 + this.dotD/2) {
        
          PVector force = PVector.sub(this.pos, dt.pos);
          
          float cd = dt.dotD/2 + this.dotD/2 - d;
          
          force.normalize();
          
          force.mult(cd*10/dotD);
          speed.add(force);
        }
      }
    }
  }

  
  void edge() {
    if (pos.x-dotD/2 < 0) {
      pos.x = dotD/2;
      speed.x = speed.x*-1;
    }
    if (pos.y-dotD/2 < 0) {
      pos.y = dotD/2;
      speed.y *= -1;
    }
    if(pos.x+dotD>width){
      pos.x=dotD/2;
      speed.x*=-1;
     
    }
    if (pos.y+dotD/2 >height) {
      pos.y = dotD/2;
      speed.y *= -1;
    }
  }

  
  void show() {
    
    fill(c1);
    noStroke();
    ellipse(pos.x, pos.y, dotD, dotD);
  }
} 
