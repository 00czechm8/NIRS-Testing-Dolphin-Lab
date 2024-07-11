%% Converts .oxy3 to .MAT

filename = uigetfile('*.oxy3');
savename = fullfile("C:\Users\mwreynol\OneDrive - Umich\Research\NIRS-Testing-Dolphin-Lab\Data\Optical Tests\MAT Data\DummyLED", filename(1:end-5));
target = "rawOD";
[nirs_data, ~] = oxysoft2matlab(filename, target, savename);
