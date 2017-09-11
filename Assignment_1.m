

close all; clc; clear all;

StartingFrame = 1;
EndingFrame = 448;

Xcentroid = [ ];
Ycentroid = [ ];

for k = StartingFrame : EndingFrame - 1
    
    rgb = imread(['ant/img', sprintf('%2.3d', k), '.jpg']);
    
    if k == 1
        continue;
    end
    
    if k ~= 1
        rgb2 = imread(['ant/img', sprintf('%2.3d', k-1), '.jpg']);
        j = 1;
    end
    
    imshow(rgb);
    hold on;
    
    rgb = rgb2gray(rgb);
    rgb2 = rgb2gray(rgb2);
    diff1 = abs(rgb-rgb2);
    Ithresh = diff1 > 25;
    
    BW = Ithresh;

    [labels, number] = bwlabel(BW, 8);
    Istats = regionprops(labels, 'basic', 'Centroid');
%      [values, index] = sort([Istats.Area], 'descend');
    [maxVal, maxIndex] = max([Istats.Area]);
    
    if number ~= 0
        plot(Istats(maxIndex).Centroid(1), Istats(maxIndex).Centroid(2), 'bx');
        Xcentroid = [Xcentroid Istats(maxIndex).Centroid(1)];
        Ycentroid = [Ycentroid Istats(maxIndex).Centroid(2)];
    end
    
    pause(.016666666);
    
end

pause;

for k = StartingFrame : EndingFrame - 2
    plot(Xcentroid(k), Ycentroid(k), 'bx');
end