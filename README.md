# Thermistor Documentation

## Background
This project is meant to provide scientific backing for a change to the NIRS system so that it does not cause any burns to the Dolphins. NIRS is a system that uses LED light sources to bounce photons off tissue to determine concentrations of specific molecules in the subject's bloodstream. Although the current system returns excellent results, the system causes burns on the subject's skin. Therefore we attempt to quantify the burn damage to the dolphin skin and create a design solution that minimizes damage. 

# Test Setup Design
Given the simplicity of the design, we opted for a simple circuit where a thermistor was placed in series with a 10-kilohm resistor (with voltage being dropped across the thermistor first). Using a teensy 4.0, we would measure the voltage across the resistor and thus achieve a direct relationship between temperature and pressure. 

# Voltage to Temperature Reading
According to the literature[1], we can create an accurate fit using a quartic polynomial from the ratio of the thermistor resistance to the 10-kilohm resistor and the reciprocal of temperature. 

## Calibration Curves and Residuals
![alt text](https://github.com/00czechm8/NIRS-Testing-Dolphin-Lab/blob/main/Code/Probe1Calib.jpg)

![alt text](https://github.com/00czechm8/NIRS-Testing-Dolphin-Lab/blob/main/Code/Probe2Calib.jpg)

![alt text](https://github.com/00czechm8/NIRS-Testing-Dolphin-Lab/blob/main/Code/ResidualPlot.jpg)

## Calibration Data
This data can be found in the Code directory of the main branch

## References
[1]: S. Rudtsch and C. von Rohden, “Calibration and self-validation of thermistors for high- 
       precision temperature measurements,” Measurement, vol. 76, pp. 1–6, Dec. 2015. 
       doi:10.1016/j.measurement.2015.07.028.
