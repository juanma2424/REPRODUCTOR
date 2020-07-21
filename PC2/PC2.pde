///////////////////////////////////////////////////////////////////////////////////////
//import ddf.minim.analysis.*;
//import ddf.minim.*;
//Minim minim;
//AudioPlayer jingle;
//FFT fft;
//AudioInput in;
//float[] angle;
//float[] y, x;
 
//void setup()
//{
//  size(800,800, P3D);
//  //  size(1280,768,P3D);
//  minim = new Minim(this);
//  jingle = minim.loadFile("song.mp3");
//  in = minim.getLineIn(Minim.STEREO, 2048, 192000.0);
//  fft = new FFT(in.bufferSize(), in.sampleRate());
//  y = new float[fft.specSize()];
//  x = new float[fft.specSize()];
//  angle = new float[fft.specSize()];
//  frameRate(240);
//}
 
//void draw()
//{
//  background(0);
//  fft.forward(in.mix);
//  doubleAtomicSprocket();
//}
 
//void doubleAtomicSprocket() {
//  noStroke();
//  pushMatrix();
//  translate(width/2, height/2);
//  for (int i = 0; i < fft.specSize() ; i++) {
//    y[i] = y[i] + fft.getBand(i)/100;
//    x[i] = x[i] + fft.getFreq(i)/100;
//    angle[i] = angle[i] + fft.getFreq(i)/2000;
//    rotateX(sin(angle[i]/2));
//    rotateY(cos(angle[i]/2));
//    //    stroke(fft.getFreq(i)*2,0,fft.getBand(i)*2);
//    fill(fft.getFreq(i)*2, 0, fft.getBand(i)*2);
//    pushMatrix();
//    translate((x[i]+50)%width/3, (y[i]+50)%height/3);
//    box(fft.getBand(i)/20+fft.getFreq(i)/15);
//    popMatrix();
//  }
//  popMatrix();
//  pushMatrix();
//  translate(width/2, height/2, 0);
//  for (int i = 0; i < fft.specSize() ; i++) {
//    y[i] = y[i] + fft.getBand(i)/1000;
//    x[i] = x[i] + fft.getFreq(i)/1000;
//    angle[i] = angle[i] + fft.getFreq(i)/100000;
//    rotateX(sin(angle[i]/2));
//    rotateY(cos(angle[i]/2));
//    //    stroke(fft.getFreq(i)*2,0,fft.getBand(i)*2);
//    fill(0, 255-fft.getFreq(i)*2, 255-fft.getBand(i)*2);
//    pushMatrix();
//    translate((x[i]+250)%width, (y[i]+250)%height);
//    box(fft.getBand(i)/20+fft.getFreq(i)/15);
//    popMatrix();
//  }
//  popMatrix();
//}
 
//void stop()
//{
//  // always close Minim audio classes when you finish with them
//  jingle.close();
//  minim.stop();
 
//  super.stop();
//}

import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer groove;
AudioMetaData meta;
AudioInput in;
BeatDetect beat;

//---------------------------//
FFT fft;
boolean flag = true;
boolean flagStop = true;
float scoreB = 3;
float angle = 0.0;
float X= 100;
float Y= 70;
float speedX = 0.0;
float speedY = 0.0;
float gravity = 0.1;
float diam = 120;
int  tipeShape = 0;
float R =0.0;
float G = 0.0;
float B = 0.0;
float scalar = 0.0;
int CB,RR,GG,BB,rr,gg,bb = 0;
//---------------------------//


void setup()
{
   size(1000, 500,P3D);
   tipeShape = 1; 

   CB =1;
   RR=1;
   GG= 10;
   BB= 220;
   
   rr=220;
   gg= 120;
   bb= 20;
   selectSound(1);
   
}




void Color(){
   R = map(scalar,CB,scoreB,RR,rr);
   G = map(scalar,CB,scoreB,GG,gg);
   B = map(scalar,CB,scoreB,BB,bb);
}


void selectSound(int data){
   minim = new Minim(this);
   if (data==1){
     groove = minim.loadFile("song.mp3", 2048);
     fft = new FFT( groove.bufferSize(),  groove.sampleRate());
     groove.play();
     beat = new BeatDetect();
   }
   else if(data==2){
     groove = minim.loadFile("song02.mp3", 2048);
     fft = new FFT( groove.bufferSize(),  groove.sampleRate());
     groove.play();
     beat = new BeatDetect();
   
   }
   else{
     groove = minim.loadFile("song03.mp3", 2048);
     fft = new FFT( groove.bufferSize(),  groove.sampleRate());
     groove.play();
     beat = new BeatDetect();
   }
}


void shapeA(int X, int Y, int i){
    scalar = sin(angle)+2;
    if(flag)Color();
    fill(R,G,B);
    strokeWeight( (fft.getBand(i)/100)+1);
    ellipse( X,Y, groove.left.get(i)*200, groove.left.get(i)*200);
    angle += groove.right.get(i);
}


void shapeB(int X, int Y, int i){
  scalar = sin(angle)+2;
  if(flag)Color();
  fill(R,G,B);
  strokeWeight( (fft.getBand(i)/100)+1);
  angle += groove.right.get(i);
  rect(X,Y, groove.left.get(i)*200, groove.left.get(i)*200);
}


void shapeC(int X, int Y, int i){
    scalar = sin(angle)+2;
    if(flag)Color();
    fill(R,G,B);
    strokeWeight( (fft.getBand(i)/100)+1);
    angle += groove.right.get(i);
    pushMatrix();
    translate(X,Y, 0);
    rotateY(groove.left.get(i)*10);
    rotateX(-groove.right.get(i)*10);
    box(groove.left.get(i)*400);
    popMatrix();
}



void keyReleased()
{
  //---------TIPO DE GRAFICO-----------//
  if (key == 'A' || key == 'a') {
    tipeShape = 1;
  } else if (key == 'S' || key == 's') {
    tipeShape = 2;
  }
  else if (key == 'D' || key == 'd'){
    tipeShape = 3;
  } 
  //---------SUMA---------//
  else if (key == 'R'){
    flag = false;
    if(R<255){
      R+=20;
    }
    else{
     println("R ensendido");
    }
  } 
  else if (key == 'G'){
    flag = false;
    if(G<255){
      G+=20;
    }
    else{
     println("G ensendido");
    }
  } 
  else if (key == 'B'){
    flag = false;
    if(B<255){
      B+=20;
    }
    else{
     println("B ensendido");
    }
  } 
  
  //------------RESTA---------------//
  else if (key == 'r'){
    flag = false;
    if(R>0){
      R-=20;
    }
    else{
     println("R apagado");
    }
    
  } 
  else if (key == 'g'){
    flag = false; 
    if(G>0){
      G-=20;
    }
    else{
     println("G apagado");
    }

  } 
  else if (key == 'b'){
    flag = false; 
    if(B>0){
      B-=20;
    }
    else{
     println("B apagado");
    }
  }
  
  // reavilita la bandera 
  else if (key == 'Q'||key == 'q'){
  flag = true;
  }
  
  // cancion 1
  else if (key == '1'){
  println("Cancion 1");
  flagStop= true;
  minim.stop();
  tipeShape = 1;
  selectSound(1);
  }
  
  // cancion 2
  else if (key == '2'){
  println("Cancion 2");
  flagStop= true;
  minim.stop();
  tipeShape = 2;
  selectSound(2);
  }
  // cancion 3
  else if (key == '3'){
  println("Cancion 3");
  flagStop= true;
  minim.stop();
  tipeShape = 3;
  selectSound(3);
  }
  else if (key == 'X'){
    stop();
  }
  
}



void draw(){
  beat.detect(groove.mix);
  fft.forward(groove.mix);
  
  if(flagStop){
  for(int i = 0; i < scoreB ; i++){
     
    //--------- CONTROL DE VELOCIADAD--------//
    if(speedX >= 15 ){
       speedX = speedX-random(1,7);  
    }  
    if (speedX <= -15 ){
       speedX = speedX+random(1,7);
    }
    if( speedY >= 15  ){
       speedY = speedY-random(1,7); 
    }
    if( speedY <= -15  ){
       speedY = speedY+random(1,7); 
    }
    //---------------------------------------//
   
    //----------- MOVIMIENTO-----------------//
    Y = Y+ speedY;
    X = X + speedX;

    speedX = speedX + gravity ;
    speedY = speedY + gravity;
    //---------------------------------------//
    
    //------------REBOTE-----------------//
    if(Y>=height){
      speedY = (speedY*-2.0);
    }
    if(Y<=0){
      speedY = (speedY*-2.0);
    }
    if(X>=width){
      speedX = (speedX*-2.0);
    }
    if(X<=0){
      speedX = (speedX*-2.0);
    }
    //---------------------------------------//
   
    //-------------FIGURA-----------------//
    if( tipeShape == 1){
      shapeA(int (X) , int (Y),i);
    }
    else if (tipeShape == 2) {
      shapeB(int (X) , int (Y),i);
    }
    else{
      shapeC(int (X) , int (Y),i);
    }
    //---------------------------------------//  
  }
  }
}

void stop()
{
  minim.stop();
  flagStop = false;
}
