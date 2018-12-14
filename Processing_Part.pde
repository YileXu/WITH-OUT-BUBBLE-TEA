// IMA NYU Shanghai
// Interaction Lab Final Project (Yile Xu)


import processing.sound.*;
import processing.serial.*;

String myString = null;
Serial myPort;
int[] sensorValues;


SoundFile file;
AudioIn input;
Amplitude amp;


  float volume = 0;
  int valueFromArduino;
  int r = 30; //diameter of the circles in the loading page

  int e = 01; //the flash of insert coin instruction
  int f = 01; //start page
  int g = 01; //for the start button (all this 3 ints are used as booleans)
  
  PImage photoUp, photoDown, photoDown2, photoLeft, photoRight, 
         bubbleTea, bubbleTea2, bubbleTea3, Coin, shang, xia, zuo, you;
  float start, end; //the framecount related number when the game start or end
  float speed1 = 5; //the speed of player1
  float speed2 = 1; //the initial speed of player2
  float x, y;
  float mode = 1;
  color c1 = color(0);
  color c2 = color(0);
  color c3 = color(0);


void setup(){
  fullScreen();
  frameRate(100);
  uploadImage();
  printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[ 15 ], 9600);
  myPort.clear();
  sensorValues = new int[5];
  uploadAudio();
  x = random(width/2-150, width/2+150); //the initial x-position of the player
  y = random(height/2-150, height/2+150);} //the initial y-position of the player


void draw(){
  noCursor();
  updateSerial();
  printArray(sensorValues);
  volume = amp.analyze()*100; 
  background(255);
  noStroke();
  if(f==1){ //if the game restart
  initialImage();}else{ //the game are on
  if(sq(x-width/2)+sq(y-height/2)<=sq(350)){ //distinguish the position of the player, inside or outside
  insides();
  }else{
  outsides();}}}
  
  
void uploadImage(){
  Coin = loadImage("Coin.jpg");
  photoUp = loadImage("UP.jpg");
  photoDown = loadImage("DOWN.jpg");
  photoDown2 = loadImage("DOWN2.jpg");
  photoLeft = loadImage("LEFT.jpg");
  photoRight = loadImage("RIGHT.jpg");
  bubbleTea  = loadImage("bubbleTea.JPEG");
  bubbleTea2 = loadImage("bubbleTea2.JPEG");
  bubbleTea3 = loadImage("bubbleTea3.JPEG");
  shang = loadImage("shang.jpg");
  xia = loadImage("xia.jpg");
  zuo = loadImage("zuo.jpg");
  you = loadImage("you.jpg");
  Coin.resize(50, 50);
  photoUp.resize(34, 48);
  photoDown.resize(34, 48);
  photoDown2.resize(34, 48);
  photoLeft.resize(34, 48);
  photoRight.resize(34, 48);
  bubbleTea. resize(424, 424);
  bubbleTea2.resize(424, 424);
  bubbleTea3.resize(424, 424);}
  
  
void uploadAudio(){
  file = new SoundFile(this, "schnappi.aiff");
  file.loop();
  
  input = new AudioIn(this, 0);
  input.start();
  amp = new Amplitude(this);
  amp.input(input);}
  
  
void updateSerial() {
  while (myPort.available() > 0) {
  myString = myPort.readStringUntil( 10 );
  if (myString != null) {
  String[] serialInArray = split(trim(myString), ",");
  if (serialInArray.length == 5) {
  for (int i=0; i<serialInArray.length; i++) {
  sensorValues[i] = int(serialInArray[i]);}}}}}
  
  //
  
void insides(){
  if(frameCount<=start+200){
  opening();
  if(frameCount==start+200){
  myPort.write('A');}
  }else{
  if(frameCount==start+210){
  myPort.write('B');}
  setupImage();
  mode(); //the direction of the player2
  direction(); //the direction of the player2
  speed(); //the accelerattion
  fill(0);
  textSize(50);
  textAlign(CENTER);
  text(int((frameCount-start)/100), width/2, 100);} //showing the score during the game
  end = frameCount/100;} //for the score
  
  
void outsides(){
  if(frameCount<=end*100+150){
  myPort.write('C');
  ending();
  }else{
  myPort.write('D');
  score();
  restart();}}
  
  //
  
void initialImage(){
  g=01;
  image(photoDown2, width/2-550-17, height/2-80-24+30-50);
  image(bubbleTea3, width/2-212, height/2-212);
  color bubbleTea = get(width/2-212, height/2-212); //get the color
  fill(bubbleTea);
  ellipse(width/2, height/2, 820, 820);
  image(bubbleTea3, width/2-212, height/2-212);
  fill(255, 0, 0);
  ellipse(width/2, height/2+330, 45, 45);
  fill(bubbleTea);
  ellipse(width/2, height/2+330, 35, 35);
  fill(255);
  stroke(0);
  rectMode(CENTER);
  rect(width/2+550, height/2-70-40, 34, 48);
  noStroke();
  textAlign(CENTER);
  fill(0, 128, 128);
  textSize(50);
  text("WITH OR WITHOUT BUBBLE TEA", width/2, 180);
  fill(0);
  textSize(10);
  text("SHARE\nSAME\nROLE", width/2+551, height/2-70-5-40-7);
  textSize(20);
  text("Hey! You are Jacki,\na boy can't live without Bubble Tea.\nTry to stay      the bubble tea circle,\nor you will die.\n\n[Your goal is to resist for 20 counts]", width/2-550, height/2+30-50);
  text("Hey! You are Jacki's Fat.\nYou can also control Jacki\nand your mission is to kill him\nby dragging him          of the bubble tea circle,\nyou will become more and more fatal\nas long as he is staying with bubble tea.\n\n[Your goal is to success before 20 counts]", width/2+550, height/2-40+5);
  textSize(25);
  fill(256, 0, 0);
  text("IN", width/2-600, height/2+42);
  text("OUT", width/2+515, height/2+58);
  
  
  fill(150, 0, 0);
  textSize(30);
  text("Press the START Button to Start", width/2, height/2+400);
  keyPressed();} //end the start page, save the framecount when game start
  
  
void keyPressed(){
  if(g==01){
  if(keyPressed){
  if(keyCode==ENTER){
  f=-f;
  start=frameCount;
  g=-1;}}}}
  
  
void opening(){
  if(frameCount>=start+050&&frameCount<=start+100){c1 = color(255);}
  if(frameCount>=start+100&&frameCount<=start+150){c2 = color(255);}
  if(frameCount>=start+150&&frameCount<=start+200){c3 = color(255);}
  fill(c1);
  ellipse(width/2-300, height/2, r, r);
  fill(c2);
  ellipse(width/2, height/2, r, r);
  fill(c3);
  ellipse(width/2+300, height/2, r, r);}
  
  
void setupImage(){
  image(bubbleTea, width/2-212, height/2-212); //the image to get the color value of the big ellipse background
  color bubbleTea = get(width/2-212, height/2-212); //get the color
  fill(bubbleTea);
  ellipse(width/2, height/2, 820, 820); //the big ellipse background
  image(bubbleTea2, width/2-212, height/2-212);
  fill(255);
  ellipse(x, y, 120, 120); //the small ellipse for the player
  image(photoDown, x-17, y-24);}
  
  
void mode(){ //the interruption speed
  if(sensorValues[3]==2){
  x+=speed2; //right
  image(photoRight, x-17, y-24);
  image(you, width-370, height/2-35);}
  if(sensorValues[3]==1){
  x-=speed2; //left
  image(photoLeft, x-17, y-24);
  image(zuo, width-370, height/2-35);}
  if(sensorValues[2]==1){
  y-=speed2; //up
  image(photoUp, x-17, y-24);
  image(shang, width-370, height/2-35);}
  if(sensorValues[2]==2){
  y+=speed2; //down
  image(photoDown, x-17, y-24);
  image(xia, width-370, height/2-35);}
  fill(0);
  textSize(15);
  textAlign(CENTER);
  text("Fat's Speed="+int(speed2), width-370+35, height/2+55);}
  
  
void direction(){ //the player1 speed
  if(sensorValues[0]==1){
  y-=speed1; //up
  image(photoUp, x-17, y-24);
  image(shang, 300, height/2-35);}
  if(sensorValues[0]==2){
  y+=speed1; //down
  image(photoDown, x-17, y-24);
  image(xia, 300, height/2-35);}
  if(sensorValues[1]==1){
  x-=speed1; //left
  image(photoLeft, x-17, y-24);
  image(zuo, 300, height/2-35);}
  if(sensorValues[1]==2){
  x+=speed1; //right
  image(photoRight, x-17, y-24);
  image(you, 300, height/2-35);}
  text("Jacki's speed="+int(speed1), 300+35, height/2+55);}
  
  
void speed(){
  if(frameCount%100==0){
  if(speed2<=3){ //if speed2 is relatively small
  speed2+=0.2; //increase fast
  }else{
  speed2+=0.1;}}} //increase slow

  
void ending(){
  rectMode(CENTER);
  c2 = color(255, 0, 0);
  fill(c2);
  translate(width/2, height/2); //some setup stuff
  
  pushMatrix();
  rotate(PI/4);
  rect(0, 0, 100, 10);
  popMatrix(); 
  
  pushMatrix();
  rotate(PI*3/4);
  rect(0, 0, 100, 10);
  popMatrix();} //the red X in the middle
  
  
void score(){
  if(frameCount%50==0){e=-e;} //flash
  fill(0);
  if(e==1){
  image(Coin, width/2-200-15, height/2+55);
  textSize(20);
  color coinColor = get(width/2-200+20-15, height/2+55+15);
  fill(coinColor);
  if(int(end-start/100)>=20){
  text("\"Fat\" Please Insert Coin to Restart", width/2+50-15, height/2+87.5); //instruction for inserting the coin
  }else{
  text("\"Jacki\" Please Insert Coin to Restart", width/2+50-15, height/2+87.5);}}
  textAlign(CENTER);
  textSize(40);
  fill(0);
  if(int(end-start/100)>=20){
  text(" Jacki is the Winner!", width/2, height/2+10);
  }else{
  text("Fat is the Winner!", width/2, height/2+10);}
  textSize(150);
  text(int(end-start/100), width/2, height/2-60);} //showing the score
  
  
void restart(){
  if(sensorValues[4]==2){
  frameCount=0;
  f = -f;
  speed2 = 0.1;
  x = random(width/2-150, width/2+150);
  y = random(height/2-150, height/2+150);
  c1 = color(0);
  c2 = color(0);
  c3 = color(0);
  myPort.write('E');}}
  
 
  
// Work Cited
// Image photoUp, photoDown, photoLeft, photoRight: https://stackoverflow.com/questions/45569580/sprite-sheet-animation-with-arrow-keys
// Image bubbleTea: https://www.pinterest.com/pin/431219733046876247/
// Image shang, xia, zuo, you: https://www.123rf.com/photo_58944868_stock-vector-up-down-left-right-or-north-east-south-west-round-arrows-flat-icon-for-apps-and-websites.html
// Image Coin: https://www.123rf.com/photo_59779172_stock-vector-one-gold-coin-icon-in-cartoon-style-on-a-white-background.html
// Audio schnappi: Joy Gruttmann, http://music.163.com/
// Function updateSerial() is based on the framework code provided by NYU Shanghai IMA Interaction Lab: https://drive.google.com/file/d/19Bc1yY-CaQCaSlfgFVd21UNCePM8xen7/view
