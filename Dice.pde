boolean roll = false;
int numberOfDie = 54;
Die[] dCT = new Die[numberOfDie+1];

float radius = 50;
float angIncr = 0;
float ang = 0;
int cx = 350;
int cy = 350;
int numObj;
int numPerLayer = 9;
int space = 40;

void setup(){
  size(700,700);
  for (int i = 1; i <= numberOfDie; i++){
    dCT[i] =  new Die(30,30,5,false);
    dCT[i].roll();
  }
  totalRoll();
}

boolean singleClick = false;
int clickInc = 0;
void draw(){
  background(0,0,0);
  totalRoll();
  ang += angIncr;
 
  float oDX = 0;
  float oDY = 0;
  for (int n = 1; n <= numberOfDie; n++){
   int divF = ((numPerLayer-1)+n)/numPerLayer;
   float dX = cx + (cos(ang/divF - (space*n*PI/180)) * radius * divF);
   float dY = cy + (sin(ang/divF - (space*n*PI/180)) * radius * divF);
 
   if (oDX != 0 && oDY != 0){
     stroke(255,255,255);
     line(cx,cy,dX,dY);
     noStroke();
   }
   oDX = dX;
   oDY = dY;
   rotateObject(dX,dY,-(ang/divF * 180/PI * 3) + n);
   if (mousePressed == true)
      if (clickInc == 5)
        dCT[n].roll();
   dCT[n].render(0,0);
   popMatrix();
  }
 
  if (clickInc == 5)
    clickInc = 0;
 
  if (mousePressed == true){
    clickInc += 1;
    radius = clamp(radius + 2,50,200);
    angIncr = clamp(angIncr + PI/360,PI/360,40 * PI/180);
  }else if (mousePressed == false){
    radius = clamp(radius - 2,50,200);
    angIncr = clamp(angIncr - PI/360,PI/360,40 * PI/180);
  }
 
}
void mousePressed(){
  singleClick = true;
 
  for (int n = 1; n <= numberOfDie; n++){
    dCT[n].roll();
  }
  
}


class Die{
  int rot, sX, sY;
  boolean stroke;
  int nDots = 1;
  Die(int sXm, int sYm, int r, boolean strokeM){
    rot = r;
    sX = sXm;
    sY = sYm;
    stroke = strokeM;
  }
  void roll(){
    nDots = rand(1,6);
  }
  void render(float pX, float pY){
    float sXrE = sX * 0.17;
    float sYrE = sY * 0.17;
    if (!stroke)
      noStroke();
    else
      stroke(0,0,0);
    rect(pX - sX/2,pY - sY/2,sX,sY,10);
    fill(0,0,0);
    if (nDots == 1){
      ellipse(pX,pY,sXrE,sYrE);
    }else if(nDots == 2){
      ellipse((sXrE) + pX,pY,sXrE,sYrE);
      ellipse(-(sXrE) + pX, pY,sXrE,sYrE);
    }else if (nDots == 3){
      ellipse(pX,pY,sXrE,sYrE);
      ellipse(-(sXrE) + pX, (sYrE) + pY,sXrE,sYrE);
      ellipse((sXrE) + pX, -(sYrE) + pY,sXrE,sYrE);
    }else if(nDots == 4){
      ellipse(-(sXrE) + pX, -(sYrE) + pY,sXrE,sYrE);
      ellipse(-(sXrE) + pX, (sYrE) + pY,sXrE,sYrE);
      ellipse((sXrE) + pX, -(sYrE) + pY,sXrE,sYrE);
      ellipse((sXrE) + pX, (sYrE) + pY,sXrE,sYrE);
    }else if (nDots == 5){
      ellipse(pX,pY,sXrE,sYrE);
      ellipse(-(sXrE) + pX, -(sYrE) + pY,sXrE,sYrE);
      ellipse(-(sXrE) + pX, (sYrE) + pY,sXrE,sYrE);
      ellipse((sXrE) + pX, -(sYrE) + pY,sXrE,sYrE);
      ellipse((sXrE) + pX, (sYrE) + pY,sXrE,sYrE);
    }else{
      ellipse((sXrE) + pX,pY,sXrE,sYrE);
      ellipse(-(sXrE) + pX, pY,sXrE,sYrE);
      ellipse((sXrE) + pX,pY + sYrE,sXrE,sYrE);
      ellipse(-(sXrE) + pX, pY + sYrE,sXrE,sYrE);
      ellipse((sXrE) + pX,pY - sYrE,sXrE,sYrE);
      ellipse(-(sXrE) + pX, pY - sYrE,sXrE,sYrE);
    }
    fill(255,255,255);
  }
}

public int rand(int min, int max){
  return min + (int)(Math.random()*(1+(max-min)));
}

public void rotateObject(float x, float y, float angle){
  pushMatrix();
  translate(x,y);
  angle = angle * PI/180;
  rotate(angle);
}
 
public float clamp(float x, float min, float max){
  if (x < min){
    x = min;
  }else if (x > max){
    x = max;
  }
  return x;
}

public void totalRoll(){
  int sum = 0;
  for (int n = 1; n <= numberOfDie; n++){
    sum += dCT[n].nDots;
  }
  textSize(30);
  text("T O T A L : "+sum,30,675);
}
