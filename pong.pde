import processing.sound.*;
//import gifAnimation.*;
//GifMaker fichero;
int count;
int px,py,vy,vx,jx,jy,jx2,jy2,vy2plus,vy2minus,vy1plus,vy1minus,score1,score2;
boolean menu;
boolean [] keys;
SoundFile sonido,sonidoGoal;
boolean left=true;
void setup(){
  //count=0;
  
  size(750,500);
  stroke(255);
  fill(0);
  textSize(30);
  strokeWeight(2);
  //fichero= new GifMaker(this,"demo.gif");
  //fichero.setRepeat(0);
  
  px=width/2;
  py=height/2;
  vx= int(random(-4,4));
  if(vx==0) vx=1;
  vy= int(random(-3,3));
  if(vy==0) vy=1;
  jx=width-50;
  jy=height/2;
  jx2=50;
  jy2=height/2;
  sonido = new SoundFile(this,"cong.mp3");
  sonidoGoal=new SoundFile(this,"greenscreen-wow.mp3");
  vy2plus=0;
  vy2minus=0;
  score1=0;
  score2=0;
  menu=true;
  keys = new boolean[4];
}

void draw(){
  background(0);
  if(menu){
    fill(255);
    textSize(30);
    text("PAUSA ",width/2-45,45);
    textSize(100);
    fill(125);
    text("PONG ",width/2-125,155);
    fill(255);
    text("PONG ",width/2-130,160);
    fill(255);
    textSize(15);
    text("Controles jugador1\n   Arriba: w\n   Abajo:s",width/4-60,height/2);
    text("Controles jugador2\n   Arriba: ↑\n   Abajo:↓",width*3/4-60,height/2);
    textSize(30);
    text("PULSA ENTER PARA CONTINUAR",width/2-220,height-45);
    textSize(30);
    fill(0);
  }else{
  
    line(width/2,0,width/2,height);
    ellipse(px,py,20,20);
  //jy=mouseY;
  
    if(jy<0){
      jy=0;
    }else if(jy+80>height){
      jy=height-80;
    }
    if(jy2<0){
      jy2=0;
    }else if(jy2+80>height){
      jy2=height-80;
    }
    
    px=px+vx;
  
    py=py+vy;
  
    if(px>width || px<0  ){
      if(px>width){
        score1++;
        thread("SuenaGoal");
        vx= int(random(1,4));
        vy= int(random(-3,3));
      }else{
        score2++;
        thread("SuenaGoal");
        vx= int(random(-4,-1));
        vy= int(random(-3,3));
      }
      px=width/2;
      py=height/2;
    
    }
    if(py>height-10 || py<10){
      vy=-vy;
      thread("Suena");
      if(py>height-10)py=height-10;
      if(py<10)py=10;
    }
  
    if(px <=jx+10 && px>=jx-10 && py<=jy+90 && py>=jy-10){
        if(px<jx+10){
          px=jx-17;
        }else{
          px=jx+17;
        }
        vx= -vx-1;
        if(vy1plus+vy1minus<=1){
          vy=vy1plus+vy1minus;
        }else{
          vy= (vy1plus+vy1minus)/2;
        }
        
        thread("Suena");
    }
    if(px <=jx2+20 && px>=jx2 && py<=jy2+90 && py>=jy2-10){
        vx= -vx+1;
        if(px<jx2+20){
          px=jx2+27;
        }else{
          px=jx2-7;
        }
        if(vy2plus+vy2minus<=1){
          vy=vy2plus+vy2minus;
        }else{
          vy= (vy2plus+vy2minus)/2;
        }
        
        thread("Suena");
    }
    if( keys[0]){
      vy2minus--;
      if(vy2minus<-8)vy2minus=-8;
      jy2=jy2-7;
      vy2plus=0;
    }
    if ( keys[1]){
      vy2plus++;
      if(vy2plus>8)vy2plus=8;
      jy2=jy2+7;
      vy2minus=0;

    }
    
    if( keys[2]){
      vy1minus--;
      if(vy1minus<-8)vy1minus=-8;
      jy=jy-7;
      vy1plus=0;
    }
    if (keys[3]){
      vy1plus++;
      if(vy1plus>8)vy1plus=8;
      jy=jy+7;
      vy1minus=0;
    }
    rect(jx,jy,10,80);
    rect(jx2,jy2,10,80);
    fill(255);
    text(score1,width/4,30);
    text(score2,width*3/4,30);
    fill(0);
  }
  //count++;
  //if(count==5){
  //  count=0;
  //  fichero.addFrame();
    
  //}
}

void keyPressed(){
    if(key == 'w' || keys[0]){
      keys[0]=true;
      
    }
    if (key == 's' || keys[1]){
      keys[1]=true;
    }
    
    if(keyCode ==UP || keys[2]){
      keys[2]=true;
      
    }
    if (keyCode == DOWN || keys[3]){
      keys[3]=true; 
    }  
    if(keyCode== ENTER){
      menu=!menu;
    }
    //if(key=='p'){
    //  fichero.finish();
    //}
}

void keyReleased(){
  
  if (key== 'w'){
    keys[0]=false;
     vy2minus=0;
    vy2plus=0;
  }
  if(key =='s'){
    keys[1]=false;
     vy2minus=0;
     vy2plus=0;
  }
  
  if(keyCode==UP){ 
    keys[2]=false;
    vy1minus=0;
    vy1plus=0;
  }
  if(keyCode==DOWN){
    keys[3]=false;
    vy1minus=0;
    vy1plus=0;
  }
 
  
}

void Suena(){
  sonido.play();
}

void SuenaGoal(){
  sonidoGoal.play();
}
