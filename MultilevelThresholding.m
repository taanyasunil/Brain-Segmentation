%% Multilevel thresholding:
background = zeros(1,10);
blue = zeros(1,10);
cyan = zeros(1,10);
yellow = zeros(1,10);
red = zeros(1,10);
maroon = zeros(1,10);
gen = zeros(1,10);
for m = 1:10
file = imread(T1_file(m));
X = grayslice(file,6);
X = uint8(X);
for i = 1:362
    for j = 1:434
        if X(i,j) == 1 
            X(i,j) = 153;
        elseif X(i,j) == 3
            X(i,j) = 255;
        elseif X(i,j) == 2 
            X(i,j) = 204;
        elseif X(i,j) == 4 
            X(i,j) = 102;
        elseif X(i,j) == 5 
            X(i,j) = 51;
        elseif X(i,j) == 0
            X(i,j) = 1;
        end
    end
end 
Lab = imread(Labels_file(m));
% Changing background values from 0 to 1 as dice takes index values from 1
for i = 1:362
    for j = 1:434
        if Lab(i,j) == 0
           Lab(i,j) = 1;
        end
    end
end 
X = double(X);
Label_1double = double(Lab);
similarity = dice(X, Label_1double);
similarity2 = generalizedDice(X, Label_1double);

figure;
subplot(1,2,1)
imshow(X, map)
axis off
title('Segmented Image')
subplot(1,2,2)
imshow(Lab,map)
axis off
title('Labelled Image')
sgtitle(sprintf('Slice : %d',m))
impixelinfo

background(m) = similarity(1);
blue(m) = similarity(51);
cyan(m) = similarity(102);
yellow(m) = similarity(153);
red(m) = similarity(204);
maroon(m) = similarity(255);
gen(m) = similarity2;
end
back = mean(background);
blues = mean(blue);
cyans = mean(cyan);
yellows = mean(yellow);
reds = mean(red);
maroons = mean(maroon);
gens = mean(gen);
disp(["Similarity value of Air (Background):" back]);
disp(["Similarity value of Skin/Scalp (Blue):" blues]);
disp(["Similarity value of Skull (Cyan):" cyans]);
disp(["Similarity value of CSF (Yellow):" yellows]);
disp(["Similarity value of Gray Matter (Red):" reds]);
disp(["Similarity value of White Matter (Maroon):" maroons]);
disp(["The Generalized Dice Score is :" gens]);

