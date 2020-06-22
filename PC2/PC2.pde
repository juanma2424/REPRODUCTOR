//import ddf.minim.*;

//Minim minim;
//AudioPlayer player;

//void setup(){
//  minim = new Minim(this);
//  player = minim.loadFile("song.mp3");
//}
//void draw(){
//  background(0);
//  stroke(255);
//  if(player.isPlaying()){
//    text("presiona una tecla stop",10,20);
//  }else{
//       text("presiona una tecla play",10,20);
//  } 
//}

//void keyPressed(){
//  if(player.isPlaying()){
//    player.pause();
//  }
//  else{
//   player.play();
//  }
//}
////////////////////////////////////////////////////////////////////////////

//import ddf.minim.analysis.*;
//import ddf.minim.*;

//Minim minim;
//AudioInput in;
//FFT fft;
//AudioPlayer ap;
//// how many individual peak bands we have (dep. binsperband)
//float gain = 0; // in dB
//float dB_scale = 2.0;  // pixels per dB
//int buffer_size = 1024;  // also sets FFT size (frequency resolution)
//float sample_rate = 44100;

//int spectrum_height = 200; // determines range of dB shown
//int legend_height = 20;
//int spectrum_width = 512; // determines how much of spectrum we see
//int legend_width = 40;
//int freqOffset = 0;

//final color colSelected=color(255,0,0);
//final color colPlain=color(255);

//void setup()
//{
//  size(552, 220, P2D);
//  textMode(SCREEN);
//  //textFont(createFont("Georgia", 12));

//  minim = new Minim(this);

//  //in = minim.getLineIn(Minim.MONO,buffer_size,sample_rate);
//  ap = minim.loadFile("song.mp3");
//  // create an FFT object that has a time-domain buffer 
//  // the same size as line-in's sample buffer
//  fft = new FFT(ap.bufferSize(), ap.sampleRate());

//  // Tapered window important for log-domain display
//  fft.window(FFT.HAMMING);

//  //println("buffer:"+in.bufferSize());
//  //println("sampleRate:"+in.sampleRate());
//  //println("peaksize:"+peaksize);
//}


//void draw()
//{
//  // clear window
//  background(0);

//  // perform a forward FFT on the samples in input buffer
//  fft.forward(ap.mix);
//  ap.play();

//  // now draw current spectrum in brighter blue
//  stroke(64, 255, 255);
//  noFill();
//  for (int i = 0; i < fft.specSize(); i++) {

//    // draw the line for frequency band i using dB scale
//    float val = dB_scale*(20*((float)Math.log10(fft.getBand(i))) + gain);

//    if (fft.getBand(i) == 0) {   
//      val = -200;
//    }  // avoid log(0)

//    int y = spectrum_height - Math.round(val);

//    if (y > spectrum_height) { 
//      y = spectrum_height;
//    }

//    float x1=legend_width+i+freqOffset;
//    float y1=spectrum_height;
//    float x2=x1;
//    float y2=y;

//    line(x1, y1, x2, y2);

//    pushStyle();
//    if (dist(mouseX, mouseY, x2, y2)<20) 
//      fill(colSelected);
//    else
//      fill(colPlain);
//    noStroke();
//    ellipse(x2, y2, 3, 3);
//    popStyle();

//    // update the peak record
//    // which peak bin are we in?
//    //int peaksi = i/binsperband;
//    //if (val > peaks[peaksi]) {
//    //  peaks[peaksi] = val;
//    //  // reset peak age counter
//    //  peak_age[peaksi] = 0;
//    //}
//  }
//  // add legend
//  // frequency axis
//  fill(255);

//  stroke(255);

//  int y = spectrum_height;

//  line(legend_width, y, legend_width+spectrum_width, y); // horizontal line

//  // x,y address of text is immediately to the left of the middle of the letters 
//  textAlign(CENTER, TOP);

//  int spFreq=0; //for spacing

//  for (float freq = 0.0; freq < ap.sampleRate(); freq += 2000.0) {
//    int x = legend_width+spFreq+freqOffset; // which bin holds this frequency
//    //println(freq+"->"+fft.freqToIndex(freq));
//    line(x, y, x, y+4); // tick mark
//    text(Math.round(freq/1000) +"kHz", x, y+5); // add text label
//    spFreq+=45;
//  }

//  // DBlevel axis
//  int x = legend_width;

//  line(x, 0, x, spectrum_height); // vertictal line

//  textAlign(RIGHT, CENTER);

//  for (float level = -100.0; level < 100.0; level += 20.0) {
//    y = spectrum_height - (int)(dB_scale * (level+gain));

//    line(x, y, x-3, y);

//    text((int)level+" dB", x-5, y);
//  }
//}

//void keyReleased()
//{
//  // +/- used to adjust gain on the fly
//  if (key == '+' || key == '=') {
//    gain = gain + 5.0;
//  } else if (key == '-' || key == '_') {
//    gain = gain - 5.0;
//  }
//  //(.)/(/) used to adjust frequency axis
//  else if (key == '/')
//  {
//    freqOffset = freqOffset-4;
//  } else if ( key == '.')
//  {
//    freqOffset = freqOffset+4;
//  }
//}

//void stop()
//{
//  // always close Minim audio classes when you finish with them
//  in.close();
//  minim.stop();
//  super.stop();
//}

/////////////////////////////////////////////////////////////////////////////////////
//import ddf.minim.analysis.*;
//import ddf.minim.*;
 
//BeatDetect heart = new BeatDetect();
//Minim       minim;
//AudioPlayer jingle;
//FFT         fft;
 
//void setup(){
//  size(512, 200, P3D);
 
//  minim = new Minim(this);
 
//  // specify that we want the audio buffers of the AudioPlayer
//  // to be 1024 samples long because our FFT needs to have 
//  // a power-of-two buffer size and this is a good size.
//  jingle = minim.loadFile("song.mp3", 1024);
 
//  // loop the file indefinitely
//  jingle.loop();
 
//  // create an FFT object that has a time-domain buffer 
//  // the same size as jingle's sample buffer
//  // note that this needs to be a power of two 
//  // and that it means the size of the spectrum will be half as large.
//  fft = new FFT( jingle.bufferSize(), jingle.sampleRate() );
 
//}
 
//void draw()
//{
//  background(0);
//  heart.detect( jingle.right );  
//  if( heart.isOnset() ){
//    background(255,0,0);
//  }
 
//  stroke(255);
 
//  // perform a forward FFT on the samples in jingle's mix buffer,
//  // which contains the mix of both the left and right channels of the file
//  fft.forward( jingle.right );
 
//  for(int i = 0; i < fft.specSize(); i++)
//  {
//    // draw the line for frequency band i, scaling it up a bit so we can see it
//    line( i, height, i, height - fft.getBand(i)*8 );
//  }
//}


////////////////////////////////////////////////////////////////////////////////////

//import ddf.minim.*;
//import ddf.minim.signals.*;
//Minim minim;
//AudioPlayer mySound;

//void setup(){
//  size(400, 400,P3D);
//  noStroke();
//  rectMode(CENTER);
//  minim = new Minim(this);
//  mySound = minim.loadFile("song.mp3");
//  mySound.play();
//}
//int n=0;
//void draw(){
//  background(0);
//  translate(width/2,height/2);
//  for(int i = 0; i < mySound.bufferSize() - 1; i++)  {
//    rotateX(n*-PI/6*0.05);
//    rotateY(n*-PI/6*0.05);
//    rotateZ(n*-PI/6*0.05);
//    fill(random(255),random(255),random(255));
//    rect(i,i,mySound.left.get(i)*50,mySound.left.get(i)*50);
//  }
//  n++;
//}

////mute out
//void keyPressed(){
//  if ( key == 'm'|| key == 'M' ){
//    if ( mySound.isMuted() ){
//      mySound.unmute();
//    }
//    else{
//      mySound.mute();
//    }
//  }
//}

//void stop(){
//  mySound.close();
//  minim.stop();
//  super.stop();
//}

/////////////////////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////
//----------------------- EJEMPLO BASE -----------------------------//
////////////////////////////////////////////////////////////////////
//import ddf.minim.*;
//import ddf.minim.analysis.*;
 
//Minim minim;
//AudioPlayer groove;
//AudioMetaData meta;
//BeatDetect beat;
//float yoff = 0.0;
 
////---------------------------//
//float y = 50.0;
//float fast = 3.0;
//float radio = 5.0;
////---------------------------//
 
 
 
 
//void setup()
//{
 
//size(640, 360, P3D);
 
//minim = new Minim(this);
//groove = minim.loadFile("song.mp3", 2048);
//groove.play();
//beat = new BeatDetect();
//ellipseMode(CENTER);
 
//}
//void draw() 
//{
//background(#9C69D3);
//beat.detect(groove.mix);
//stroke(255);
 
  
//  // linea blanca 
//  for(int i = 0; i < groove.bufferSize() - 1; i+=20)
//  {
    
//     ellipse( i,200, groove.left.get(i)*100, groove.left.get(i)*100);
//     ellipse( groove.left.get(i)*300, groove.left.get(i)*300,radio,radio);
//    //line(100 + groove.left.get(i+1)*10, 100  + groove.left.get(i)*100,  130, 130);
//    // line(100  + groove.left.get(i)*100, 0, 100 + groove.left.get(i+1)*10 ,200 );
//     //line(i, 100  + groove.left.get(i)*100,  i+1, 100 + groove.left.get(i+1)*10);
//  }
  
//fill(#1F0BDB);
//beginShape();
// float xoff = 0;
//  for (float x = 0; x <= width; x += 10) {
//    float y = map(noise(xoff, yoff), 10, 1, 0, 300);
//    vertex(x, y); 
//    xoff += 0.10;
//  }
//  yoff += 0.10;
//  vertex(width, height);
//  vertex(0, height);
//  endShape(CLOSE);
//}








////////////////////////////////////////////////////
import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer groove;
AudioMetaData meta;
BeatDetect beat;
float yoff = 0.0;
 
//---------------------------//
float y = 50.0;
float fast = 3.0;
float radio = 5.0;
//---------------------------//
float angle = 0.0;
float X= 100;
float Y= 70;
float speedX = 0.0;
float speedY = 0.0;
float gravity = 0.1;
float diam = 120;
//==========================//
FFT fft;
float specLow = 0.03; // 3%
float specMid = 0.125;  // 12.5%
float specHi = 0.20;   // 20%

float scoreLow = 0;
float scoreMid = 0;
float scoreHi = 0;

float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;


float scoreDecreaseRate = 25;




void setup()
{
   size(1000, 500,P3D);
   fill(0,0,0);
   rect(0,0,1000,500);
   minim = new Minim(this);
   groove = minim.loadFile("song.mp3", 2048);
   fft = new FFT( groove.bufferSize(),  groove.sampleRate());
   groove.play();
   beat = new BeatDetect();   
   surface.setResizable(true);
}


void shapeX(int pX, int pY){
 float scalar = sin(angle)+2;
  if(angle>=26){
    angle = 0.0;
  }
  translate(pX,pY);
  scalar = sin(angle)+2;
  scale(scalar);
  rotate(angle);
  
  float R = map(scalar,1,3,0,220);
  float G = map(scalar,1,3,10,120);
  float B = map(scalar,1,3,220,20);
  
  fill(R,G,B);
  strokeWeight(abs(0.01/scalar));
  rect(-30,-30,70,70);
  angle += 0.1;
 
}





void draw(){
  //fft.forward(groove.mix);
  //background(0);
  beat.detect(groove.mix);
  fft.forward(groove.mix);
  
  oldScoreLow = scoreLow;
  oldScoreMid = scoreMid;
  oldScoreHi = scoreHi;
  
  //Réinitialiser les valeurs
  scoreLow = 0;
  scoreMid = 0;
  scoreHi = 0;
  //shapeX(int(X),int(Y));
 
//Calculer les nouveaux "scores"
  for(int i = 0; i < 3; i++){
     
    if(speedX >= 15 ){
       speedX = speedX-random(1,7);  
    }  
    if(speedX <= -15 ){
       speedX = speedX+random(1,7);
    }
    if( speedY >= 15  ){
       speedY = speedY-random(1,7); 
    }
    if( speedY <= -15  ){
       speedY = speedY+random(1,7); 
    }
   
    Y = Y+ speedY;
    X = X + speedX;

    speedX = speedX + gravity ;
    speedY = speedY + gravity;
    
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

    float scalar = sin(angle)+2;
    float R = map(scalar,1,3,0,220);
    float G = map(scalar,1,3,10,120);
    float B = map(scalar,1,3,220,20);
    fill(R,G,B);
   // strokeWeight(abs(1.1/scalar));
    strokeWeight( (fft.getBand(i)/100)+1);
    ellipse( X,Y, groove.left.get(i)*200, groove.left.get(i)*200);
     angle += groove.right.get(i);

    //rect(X,Y, groove.left.get(i)*200, groove.left.get(i)*200);
   
   //pushMatrix();
   //translate(X,Y, 0);
   //rotateY(groove.left.get(i)*10);
   //rotateX(-groove.right.get(i)*10);
   //box(groove.left.get(i)*400);
   //popMatrix();

  }

}










///////////////////////////////////////////////////////////////////////////////////
