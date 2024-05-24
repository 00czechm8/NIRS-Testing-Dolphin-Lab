# Thermistor Documentation

## Background
This project is meant to provide scientific backing for a change to the NIRS system so that it does not cause any burns to the Dolphins. NIRS is a system that uses LED light sources to bounce photons off tissue to determine concentrations of specific molecules in the bloodstream of the subject. Although the current system returns excellent results, the system causes burns on the subject's skin. Therefore we attempt to quantify the burn damage to the dolphin skin and create a design solution that minimizes damage. 

# Test Setup Design
Given the simplicity of the design, we opted for a simple circuit where a thermistor was placed in series with a 10-kilohm resistor (with voltage being dropped across the thermistor first). Using a teensy 4.0, we would measure the voltage across the resistor and thus achieve a direct relationship between temperature and pressure. 

# Voltage to Temperature Reading
When initially looking for 