%% Creates Perfromance Curve for Different Shims Height and Optical Density
load("DRDolpSkinODs.mat")
filenames = dir("C:\Users\mwreynol\OneDrive - Umich\Research\NIRS-Testing-Dolphin-Lab\Data\Optical Tests\MAT Data\DummyLED");
filenames = string({filenames.name});
filenames = filenames(3:end);

baselines = OD2Inten(ss_od);
performance = zeros(2, size(filenames,1));
performance(:,1) = [1;1];
hold on
for i = 1:6
    load(filenames(i))
    % filenames(i)
    perf = OD2Inten(nirs_data.OD(:,3));
    plot(nirs_data.time(20:900), perf(20:900), "LineWidth",1.5)
    % text(mean(nirs_data.time(20:900)), mean(perf(100:150))+100, string(mean(perf(100:900))))
    
end
hold off
legend("0 mm", "1 mm", "2 mm", "3 mm", "4 mm", "5 mm")
xlabel("Time [s]")
ylabel("Optical Intensity [-]")
%%
% heights = [0 0.6 1 1.6 2 2.6 3 3.6 4];
% hold on
% plot(heights, 100*performance(1,:), "--*")
% e1 = fit(heights', 100*performance(1,:)', 'exp1');
% plot(heights, e1.a*exp(heights*e1.b))
% plot(heights, 100*performance(2,:), "--*")
% e2 = fit(heights', 100*performance(2,:)', 'exp1');
% plot(heights, e2.a*exp(heights*e2.b))
% ylabel("% of 0mm Intensity [%]")
% xlabel("Shim Height [mm]")
% title("Intensity vs. Shim Height")
% legend("Channel 3 Data", "Channel 3 Exp. Fit" , "Channel 4", "Channel 4 Exp. Fit")
% hold off




% hold on
% for i = 2:size(filenames,2)
%     load(filenames(i))
%     [left_bound, right_bound] = getSSBounds(nirs_data);
%     plot(nirs_data.time(left_bound:right_bound), nirs_data.OD(left_bound:right_bound, 3)/baselines(1))
% end
% hold off
% legend(filenames(2:end))
% fig2 = figure;
% hold on
% for i = 2:size(filenames,2)
%     load(filenames(i))
%     [left_bound, right_bound] = getSSBounds(nirs_data);
%     plot(nirs_data.time(left_bound:right_bound), nirs_data.OD(left_bound:right_bound, 4)/baselines(2))
% end
% hold off
% legend(filenames(2:end))

%% ------------------------------------------------------------------------

function ss_od = getSSod(nirs_data) 
    fig1 = figure;
    plot(nirs_data.time, nirs_data.OD(:,3:4));
    xlabel("Time [s]")
    ylabel("Optical Density [-]")
    title("Please select the bound for SS conditions")
    ymin = min(gca().YLim);
    ymax = max(gca().YLim);
    xmin = min(gca().XLim);
    xmax = max(gca().XLim);
    hold on
    left_bound = plot([xmin;xmin;xmin], [ymin-1;mean([ymax, ymin]);ymax+1], "-g>","LineWidth", 1.5);
    right_bound = plot([xmax;xmax;xmax], [ymin-1;mean([ymax, ymin]);ymax+1], "-r<","LineWidth", 1.5);
    hold off
    xlim([xmin xmax])
    ylim([ymin ymax])
    continue_cond = true;
    
    while continue_cond
        [x, ~, button] = ginput(1);
        if isempty(x)
             button = 'o';
        end
        switch button
            case 'l'
                if x < right_bound.XData(1)
                    set(left_bound,"XData", [x;x;x]);
                    title("Please select the bound for SS conditions")
                else 
                    title("PLEASE SELECT A LEFT BOUND SMALLER THAN RIGHT BOUND")
                end
            case 'r'
                if x > left_bound.XData(1)
                    set(right_bound, "Xdata", [x;x;x]);
                    title("Please select the bound for SS conditions")
                else 
                    title("PLEASE SELECT A RIGHT BOUND LARGER THAN LEFT BOUND")
                end

            otherwise
                left_bound = round(left_bound.XData(1));
                right_bound = round(right_bound.XData(1));
                continue_cond = false;
                close(fig1);
        end
    end

    ss_od = mean(nirs_data.OD(left_bound:right_bound, 3:4));
    return
end

function [left_bound, right_bound] = getSSBounds(nirs_data) 
    fig1 = figure;
    plot(nirs_data.time, nirs_data.OD(:,3:4));
    xlabel("Time [s]")
    ylabel("Optical Density [-]")
    title("Please select the bound for SS conditions")
    ymin = min(gca().YLim);
    ymax = max(gca().YLim);
    xmin = min(gca().XLim);
    xmax = max(gca().XLim);
    hold on
    left_bound = plot([xmin;xmin;xmin], [ymin-1;mean([ymax, ymin]);ymax+1], "-g>","LineWidth", 1.5);
    right_bound = plot([xmax;xmax;xmax], [ymin-1;mean([ymax, ymin]);ymax+1], "-r<","LineWidth", 1.5);
    hold off
    xlim([xmin xmax])
    ylim([ymin ymax])
    continue_cond = true;
    
    while continue_cond
        [x, ~, button] = ginput(1);
        if isempty(x)
             button = 'o';
        end
        switch button
            case 'l'
                if x < right_bound.XData(1)
                    set(left_bound,"XData", [x;x;x]);
                    title("Please select the bound for SS conditions")
                else 
                    title("PLEASE SELECT A LEFT BOUND SMALLER THAN RIGHT BOUND")
                end
            case 'r'
                if x > left_bound.XData(1)
                    set(right_bound, "Xdata", [x;x;x]);
                    title("Please select the bound for SS conditions")
                else 
                    title("PLEASE SELECT A RIGHT BOUND LARGER THAN LEFT BOUND")
                end

            otherwise
                left_bound = round(left_bound.XData(1));
                right_bound = round(right_bound.XData(1));
                if right_bound > max(nirs_data.time)
                    right_bound = max(nirs_data.time)*5;
                end
                if left_bound <= 0
                    left_bound = find(nirs_data.time == 0);
                end
                continue_cond = false;
                close(fig1);
        end
    end
    
end
function intensity = OD2Inten(OD)
    intensity = (2^16-1)./(10.^OD);
end