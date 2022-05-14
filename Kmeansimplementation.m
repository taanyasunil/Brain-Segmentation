%% Implementing Kmeans:
background = zeros(1,10);
blue = zeros(1,10);
cyan = zeros(1,10);
yellow = zeros(1,10);
red = zeros(1,10);
maroon = zeros(1,10);
gen = zeros(1,10);

for m = 1:10
file = imread(T1_file(m));
[L,~] = imsegkmeans(file,6,NumAttempts=6);
% Correcting the labels to match the labels provided in order to analyse them.
if m == 1
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2; L(i,j) = 1;elseif L(i,j) == 3 ; L(i,j) = 51;elseif L(i,j) == 1 ; L(i,j) = 255;elseif L(i,j) == 4 ; L(i,j) = 153;elseif L(i,j) == 5 ; L(i,j) = 204;elseif L(i,j) == 6 ; L(i,j) = 102;
        end
    end
    end
elseif m == 2
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2;L(i,j) = 204;elseif L(i,j) == 3; L(i,j) = 51;elseif L(i,j) == 1; L(i,j) = 1;elseif L(i,j) == 4; L(i,j) = 102;elseif L(i,j) == 5; L(i,j) = 255;elseif L(i,j) == 6; L(i,j) = 153;
        end
    end
    end
elseif m == 3
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2; L(i,j) = 1;elseif L(i,j) == 3; L(i,j) = 51;elseif L(i,j) == 1; L(i,j) = 153;elseif L(i,j) == 4; L(i,j) = 102;elseif L(i,j) == 5; L(i,j) = 255;elseif L(i,j) == 6; L(i,j) = 204;
        end
    end
    end
elseif m == 4
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2;L(i,j) = 255;elseif L(i,j) == 3;L(i,j) = 1;elseif L(i,j) == 1;L(i,j) = 153;elseif L(i,j) == 4;L(i,j) = 51;elseif L(i,j) == 5;L(i,j) = 204;elseif L(i,j) == 6;L(i,j) = 102;
        end
    end
    end
elseif m == 5
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2;L(i,j) = 204; elseif L(i,j) == 3;L(i,j) = 153;elseif L(i,j) == 1 ;L(i,j) = 1; elseif L(i,j) == 4 ;L(i,j) = 255; elseif L(i,j) == 5 ;L(i,j) = 51; elseif L(i,j) == 6; L(i,j) = 102; 
        end
    end
    end
elseif m == 6
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2; L(i,j) = 51;elseif L(i,j) == 3;L(i,j) = 255; elseif L(i,j) == 1; L(i,j) = 1;elseif L(i,j) == 4 ;L(i,j) = 153;elseif L(i,j) == 5 ;L(i,j) = 204;elseif L(i,j) == 6;L(i,j) = 102;
        end %cb mc br
    end
    end
elseif m == 7
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2; L(i,j) = 204;elseif L(i,j) == 3;L(i,j) = 255; elseif L(i,j) == 1; L(i,j) = 1;elseif L(i,j) == 4 ;L(i,j) = 51;elseif L(i,j) == 5 ;L(i,j) = 153;elseif L(i,j) == 6;L(i,j) = 102;
        end
    end
    end
elseif m == 8
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2; L(i,j) = 255;elseif L(i,j) == 3;L(i,j) = 153; elseif L(i,j) == 1; L(i,j) = 51;elseif L(i,j) == 4 ;L(i,j) = 204;elseif L(i,j) == 5 ;L(i,j) = 1;elseif L(i,j) == 6;L(i,j) = 102;
        end
    end
    end
elseif m == 9
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2; L(i,j) = 204;elseif L(i,j) == 3;L(i,j) = 1; elseif L(i,j) == 1; L(i,j) = 153;elseif L(i,j) == 4 ;L(i,j) = 51;elseif L(i,j) == 5 ;L(i,j) = 102;elseif L(i,j) == 6;L(i,j) = 255;
        end
    end
    end
elseif m == 10
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2; L(i,j) = 204;elseif L(i,j) == 3;L(i,j) = 51; elseif L(i,j) == 1; L(i,j) = 1;elseif L(i,j) == 4 ;L(i,j) = 255;elseif L(i,j) == 5 ;L(i,j) = 153;elseif L(i,j) == 6;L(i,j) = 102;
        end
    end
    end
end

Lab = imread(Labels_file(m));
% Changing Labels background values from 0 to 1 as dice takes index values from 1
for i = 1:362
    for j = 1:434
        if Lab(i,j) == 0
           Lab(i,j) = 1;
        end
    end
end 
L = modefilt(L, [5,5]);
L = double(L);
%Converting to double in order to analyse
Label_1double = double(Lab);
similarity = dice(L, Label_1double);
similarity2 = generalizedDice(L, Label_1double);

figure;
map = jet;
subplot(1,2,1)
imshow(L, map)
impixelinfo
axis off
title("Segmented Image")

subplot(1,2,2)
imshow(Lab, map)
impixelinfo
title("Labelled Image")
sgtitle(sprintf('Slice : %d',m))

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
