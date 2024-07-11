cd("C:\Users\mwreynol\OneDrive - Umich\Research\NIRS-Testing-Dolphin-Lab\Data\Temp Tests\HeatSinks");
temp_data_names = dir("*.txt");
temp_data_names = string({temp_data_names.name});

hold on
data = readmatrix(temp_data_names(1));
plot(data(:,1), data(:,3))
data = readmatrix(temp_data_names(2));
plot(data(:,1), data(:,3))
data = readmatrix(temp_data_names(3));
plot(data(:,1), data(:,3))
data = readmatrix(temp_data_names(4));
plot(data(:,1), data(:,3))
data = readmatrix(temp_data_names(5));
plot(data(:,1), data(:,3))
data = readmatrix(temp_data_names(6));
plot(data(:,1), data(:,3))
data = readmatrix(temp_data_names(7));
plot(data(:,1), data(:,3))
% data = readmatrix(temp_data_names(20));
% plot(data(:,1), data(:,2))
% data = readmatrix(temp_data_names(21));
% plot(data(:,1), data(:,2))
xlabel("Time [s]")
ylabel("Temperature ["+char(176)+"C]")
% legend("0 mm", "0.6 mm", "1 mm","1.6 mm","2 mm", "2.6 mm", "3 mm","3.6mm","Location","south")
legend("No Heat Sink", "Heat Sink 1","Heat Sink 2", "Heat Sink 3", "Heat Sink 4", "Heat Sink 5", "Heat Sink 6", "Location","south")
hold off
% cd("C:\Users\mwreynol\OneDrive - Umich\Research\NIRS-Testing-Dolphin-Lab\Data\Temp Tests");
% temp_data_names = dir("*mm.txt")
% temp_data_names = string({temp_data_names.name});
% hold on
% for i = 1:length(temp_data_names)
%     data = readmatrix(temp_data_names(i));
%     plot(data(:,1), data(:,2))
% end
% hold off

% figure
% sstempsPLA = 100*(1-[42.255, 41.422 39.549 38.598 37.885 37.437 36.029 35.389 35.197 30.334]/42.255);
% sstempsAluminum = 100*(1-[42.255 40.481 39.165 37.181 36.797]/42.255);
% sstempsTough = 100*(1-[42.255 39.485 39.101 38.013 36.413]/42.255);
% heightsAluminum = [0 1.18 2.38 3.58 4.71];
% heightsTough = [0 1.12 2.28 3.3 4.16];
% heightsPLA = [0;0.6;1;1.6;2;2.6;3;3.6;4.9;8.25]';
% sstempsSili = 100*(1-[42.255 40.318 38.909 37.501]/42.255);
% heightsSili = [0 1.12 2.28 3.58];
% hold on
% plot(heightsPLA, sstempsPLA);
% plot(heightsAluminum, sstempsAluminum)
% plot(heightsTough, sstempsTough)
% plot(heightsSili, sstempsSili)


% x0 = 9;
% funPLA = @(a,heightsPLA)a*log(heightsPLA+1);
% funAluminum = @(a,heightsAluminum)a*log(heightsAluminum+1);
% funTough = @(a,heightsTough)a*log(heightsTough+1);
% funSili = @(a,heightsSili)a*log(heightsSili+1);
% fitPLA = lsqcurvefit(funPLA, x0, heightsPLA, sstempsPLA);
% fitAluminum = lsqcurvefit(funAluminum, x0, heightsAluminum, sstempsAluminum);
% fitTough = lsqcurvefit(funTough, x0, heightsTough, sstempsTough);
% fitSili = lsqcurvefit(funSili, x0, heightsSili, sstempsSili);
% x = 0:0.01:round(max(heightsPLA));
% plot(x,fitPLA*log(x+1), "--b")
% plot(x,fitAluminum*log(x+1), "--r")
% plot(x,fitTough*log(x+1), "--", "Color", "#EDB120")
% plot(x,fitSili*log(x+1), "--", "Color", "#7E2F8E")
% hold off 

% % text(0.1, 19, "% Drop for PLA [%] = "+string(m1)+"*Shim Ht. [mm]")
% % text(0.1, 17.5, "% Drop for Aluminum [%] = "+string(m2)+"*Shim Ht. [mm]")
% % text(0.1, 16, "% Drop for Tough 1500 [%] = "+string(m3)+"*Shim Ht. [mm]")
% xlabel("Shim Height [mm]")
% ylabel("% Drop From of 0 mm Shim Height [%]")
% legend("PLA","Aluminum","Location", "southeast")
