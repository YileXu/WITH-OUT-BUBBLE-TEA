// IMA NYU Shanghai
// Interaction Lab Final Project (Yile Xu)


char valueFromProcessing;
int tonePin = 11;
int q, w, e, r;
int sensorValue1 = 0;
int sensorValue2 = 0;
int sensorValue3 = 0;
int sensorValue4 = 0;
int sensorValue5 = 0;


void setup() {
  Serial.begin(9600);
  
  pinMode(tonePin, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);}
  

void loop() {

q = analogRead(A1);
w = analogRead(A2);
e = analogRead(A3);
r = analogRead(A4);

if(analogRead(A0)<40){
    sensorValue5 = 2;
}else{
    sensorValue5 = 1;}

if(abs(q-500)>abs(w-500)){
    if(q<300){sensorValue1 = 1;sensorValue2 = 0;}
    if(q>700){sensorValue1 = 2;sensorValue2 = 0;}
    
}else{
    if(w<300){sensorValue2 = 1;sensorValue1 = 0;}
    if(w>700){sensorValue2 = 2;sensorValue1 = 0;}
    }
if(abs(e-500)>abs(r-500)){
    if(e<300){sensorValue3 = 1;sensorValue4 = 0;}
    if(e>700){sensorValue3 = 2;sensorValue4 = 0;}
    
}else{
    if(r<300){sensorValue4 = 1;sensorValue3 = 0;}
    if(r>700){sensorValue4 = 2;sensorValue3 = 0;}
    }
  
  Serial.print(sensorValue1);
  Serial.print(",");
  Serial.print(sensorValue2);
  Serial.print(",");
  Serial.print(sensorValue3);
  Serial.print(",");
  Serial.print(sensorValue4);
  Serial.print(",");
  Serial.print(sensorValue5);
  Serial.println();
  delay(100);
    
  while (Serial.available()) {
  valueFromProcessing = Serial.read();}
  
  if (valueFromProcessing == 'A') {
  tone(11, 200);
  digitalWrite(12, HIGH);}
  if (valueFromProcessing == 'B') {
  noTone(11);}
  if (valueFromProcessing == 'C') {
  tone(11, 100);
  digitalWrite(12, LOW);
  digitalWrite(13, HIGH);}
  if (valueFromProcessing == 'D') {
  noTone(11);
  digitalWrite(13, LOW);}
  if (valueFromProcessing == 'E') {
sensorValue1 = 0;
sensorValue2 = 0;
sensorValue3 = 0;
sensorValue4 = 0;}}
