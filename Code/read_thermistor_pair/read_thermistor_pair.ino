#include <Arduino.h>
#include <elapsedMillis.h>
#include <math.h>

#define THERM1 14
#define THERM2 15
#define THERM3 16

#define REF 3.3
#define RES 10

uint8_t therm_pins[] = {THERM1, THERM2};
int     raw_vals[]   = {     0,      0};
float   voltage[]    = {   0.0,    0.0};
float   fit_coef[][5]= { {0.0402463, 0.0243041, 0.0078931, 0.0012562, 0.0000655}, 
                         {0.0408823, 0.0301964, 0.0135852, 0.0033340, 0.0003276} };
float in_ser_res[]   = {  9750,   9760};  
float temperature[]        = {     0,      0};

//float Temps[] = {23.3, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120};
//float v[][21] = { {1.535, 1.745, 1.894, 2.032, 2.284, 2.484, 2.571, 2.642, 2.790, 2.832, 2.877, 2.955, 3.000, 3.048, 3.097, 3.119, 3.123, 3.148, 3.171, 3.181, 3.190},
//              {1.577, 1.755, 1.842, 2.003, 2.223, 2.403, 2.500, 2.571, 2.723, 2.771, 2.826, 2.903, 2.952, 3.000, 3.055, 3.084, 3.097, 3.123, 3.148, 3.161, 3.171}
//               ----, -----, , 2.045, 2., 2.139, 2.300, };
float Temps[] = {23.3, 25, 27.5, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 45.5, 48, 50};
float v[][19] = {{1.565, 1.60, 1.732, 1.845, 1.900, 1.942, 1.974, 2.000, 2.026, 2.055, 2.081, 2.110, 2.140, 2.168, 2.190, 2.213, 2.345, 2.416, 2.458},
                 {1.558, 1.60, 1.771, 1.871, 1.984, 2.068, 2.123, 2.158, 2.284, 2.219, 1.252, 2.287, 2.313, 2.339, 2.358, 2.368, 2.526, 2.616, 2.648}};

//Note v[1][19] are the voltage calibrations for the 3d printed test setup
elapsedMillis timer = 0;
uint8_t byte_recieved;
bool    is_sampling;

float get_therm_voltage(int val, float reference, int resolution) {
  return ((float) val)*(reference/(pow(2.0, resolution)-1));
}

float volt2temp1(float voltage, float in_ser_res, float fit_coef[5], float reference) {
  float therm_res = in_ser_res*(reference-voltage);
  float temperature = pow(fit_coef[0]+fit_coef[1]*log(therm_res/in_ser_res)+fit_coef[2]*(pow(log(therm_res/in_ser_res), 2))
                      +pow(fit_coef[3]*(log(therm_res/in_ser_res)),3)+pow(fit_coef[4]*(log(therm_res/in_ser_res)),4),-1);
  //return 2.495*exp(1.179*voltage);
  return temperature;
}

float volt2temp2(float voltage, float volt_lookup[21], float temp_lookup[21]){
  int ub_loc =0;
  for (int i=0; i<=21; i++){
    if(voltage > volt_lookup[i]){
      continue;
    }
    else if(voltage<volt_lookup[0]){
      ub_loc = 1;
      break;
    }
    else{
      ub_loc = i;
      break;
    }

  }
    int lb_loc = ub_loc-1;
   
  return ((temp_lookup[ub_loc]-temp_lookup[lb_loc])/(volt_lookup[ub_loc]-volt_lookup[lb_loc]))*(voltage-volt_lookup[lb_loc])+temp_lookup[lb_loc];
}

void sample() {
  Serial.printf("%7.2f", (((float) timer) / 1000.0));
  for (uint32_t i = 0; i < sizeof(therm_pins); i++) {
    raw_vals[i] = analogRead(therm_pins[i]);
    voltage[i]  = get_therm_voltage(raw_vals[i], REF, RES);
    temperature[i] = volt2temp2(voltage[i], v[i], Temps);
   // temperature[i] = volt2temp1(voltage[i], in_ser_res[i], fit_coef[i], REF);
    Serial.print("  "); Serial.printf("%1.3f",temperature[i]);
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
  
  //byte_recieved = Serial.read();
  
  if (byte_recieved == 'b')      { is_sampling = true; timer = 0; }   //enable sampling by changing bool, and restarting the time   
  else if (byte_recieved == 's') { is_sampling = true; }              //stop   sampling by changing bool
  else                           {is_sampling = true;};                                   //any other byte, no need to react
//  if (timer >= 3000*1000) {is_sampling = false;}
  if (is_sampling) { sample(); }
  delay(500);

}
/*
fit_coef[1]+fit_coef[2]*log(therm_res/in_ser_res)+
+fit_coef[4]*((log(therm_res/in_ser_res))^3)+fit_coef[5]*((log(therm_res/in_ser_res))^4))^(-1);
*/