#include <Arduino.h>
#include <elapsedMillis.h>
#include <math.h>

#define THERM1 14
#define THERM2 15

#define REF 3.3
#define RES 10

uint8_t therm_pins[] = {THERM1, THERM2};
int     raw_vals[]   = {     0,      0};
float   voltage[]    = {   0.0,    0.0};
float   fit_coef[][5]= { {0.0402463, 0.0243041, 0.0078931, 0.0012562, 0.0000655}, 
                         {0.0408823, 0.0301964, 0.0135852, 0.0033340, 0.0003276} };
float in_ser_res[]   = {  9750,   9760};  
float temperature[]        = {     0,      0};

elapsedMillis timer;
uint8_t byte_recieved;
bool    is_sampling;

float get_therm_voltage(int val, float reference, int resolution) {
  return ((float) val)*(reference/(pow(2.0, resolution)-1));
}

float volt2temp(float voltage, float in_ser_res, float fit_coef[5], float reference) {
  float therm_res = in_ser_res*(reference-voltage);
  float temperature = pow(fit_coef[0]+fit_coef[1]*log(therm_res/in_ser_res)+fit_coef[2]*(pow(log(therm_res/in_ser_res), 2))
                      +pow(fit_coef[3]*(log(therm_res/in_ser_res)),3)+pow(fit_coef[4]*(log(therm_res/in_ser_res)),4),-1);
  return temperature;
}

void sample() {
  Serial.printf("%7.2f", (((float) timer) / 1000.0));
  for (uint32_t i = 0; i < sizeof(therm_pins); i++) {
    raw_vals[i] = analogRead(therm_pins[i]);
    voltage[i]  = get_therm_voltage(raw_vals[i], REF, RES);
    temperature[i] = volt2temp(voltage[i], in_ser_res[i], fit_coef[i], REF);
    Serial.print("  "); Serial.printf("%1.3f", temperature[i]);
  }
  Serial.print("\n");
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  //pinMode(THERM1, INPUT);
  //pinMode(THERM2, INPUT);
  for (uint32_t i = 0; i < sizeof(therm_pins); i++) {
    pinMode(therm_pins[i], INPUT);
  }
}

void loop() {
  // put your main code here, to run repeatedly:
  //int sensor1Value = analogRead(THERM1);
  //int sensor2Value = analogRead(THERM2);
  //double voltage1 = sensor1Value*(3.3/1023);
  //double voltage2 = sensor2Value*(3.3/1023);
  //Serial.print(voltage1); Serial.print("  "); Serial.print(voltage2); Serial.print("   "); Serial.print(get_voltage(sensor1Value, 3.3, 10)); Serial.print("  "); Serial.println(get_voltage(sensor2Value, 3.3, 10));
  byte_recieved = Serial.read();
  if (byte_recieved == 'b')      { is_sampling = true; timer = 0; }   //enable sampling by changing bool, and restarting the time   
  else if (byte_recieved == 's') { is_sampling = false; }              //stop   sampling by changing bool
  else                           {};                                   //any other byte, no need to react

  if (is_sampling) { sample(); }
  
  delay(500);
}


/*
fit_coef[1]+fit_coef[2]*log(therm_res/in_ser_res)+
+fit_coef[4]*((log(therm_res/in_ser_res))^3)+fit_coef[5]*((log(therm_res/in_ser_res))^4))^(-1);
*/