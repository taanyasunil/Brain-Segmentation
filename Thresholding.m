% Displaying histograms for all the images :
background = zeros(1,10);
blue = zeros(1,10);
cyan = zeros(1,10);
yellow = zeros(1,10);
red = zeros(1,10);
maroon = zeros(1,10);
gen = zeros(1,10);
figure
% Displaying histogram of first slice:
file = imread(T1_file(1));
imhist(file)
title('Histogram: 1')
for m = 1:10
file = imread(T1_file(m));
mat = zeros(362,434);
matrix = zeros(362,434);
%% Background
for i = 1:362
    for j = 1:434
        if file(i,j) >= 0 && file(i,j) <= 15
        mat(i,j) = 1;
        matrix(i,j) = mat(i,j);
        else
        mat(i,j) = 255;
        end
    end
end
map = jet;
figure;
subplot(2,3,1)
imshow(mat,map)
title('Segment : 1')
%% Yellow portion
for i = 1:362
    for j = 1:434
        if file(i,j) >= 30 && file(i,j) <= 55
        mat(i,j) = 153;
        matrix(i,j) = mat(i,j);
        else
        mat(i,j) = 0;
        end
    end
end
map = jet;
subplot(2,3,2)
imshow(mat,map)
title('Segment : 2')
%% Blue portion
for i = 1:362
    for j = 1:434
        if (file(i,j) >= 15 && file(i,j) <= 21) || (file(i,j) >= 170 && file(i,j) <= 255)
        mat(i,j) = 51;
        matrix(i,j) = mat(i,j);
        else
        mat(i,j) = 0;
        end
    end
end
map = jet;
subplot(2,3,3)
imshow(mat,map)
title('Segment : 3')
%% Red portion
for i = 1:362
    for j = 1:434
        if file(i,j) >= 80 && file(i,j) <= 130
        mat(i,j) = 204;
        matrix(i,j) = mat(i,j);
        else
        mat(i,j) = 0;
        end
    end
end
map = jet;
subplot(2,3,4)
imshow(mat,map)
title('Segment : 4')
%% Maroon portion
for i = 1:362
    for j = 1:434
        if file(i,j) >= 130 && file(i,j) <= 170
        mat(i,j) = 255;
        matrix(i,j) = mat(i,j);
        else
        mat(i,j) = 0;
        end
    end
end
map = jet;
subplot(2,3,5)
imshow(mat,map)
title('Segment : 5')
%% Cyan portion
for i = 1:362
    for j = 1:434
        if file(i,j) >= 20 && file(i,j) <= 29
        mat(i,j) = 102;
        matrix(i,j) = mat(i,j);
        else
        mat(i,j) = 0;
        end
    end
end
map = jet;
subplot(2,3,6)
imshow(mat,map)
title('Segment : 6')
sgtitle(sprintf('Slice : %d',m))
% Labels:
Lab = imread(Labels_file(m));
for i = 1:362
    for j = 1:434
        if Lab(i,j) == 0
           Lab(i,j) = 1;
        end
    end
end 
% Displaying the segmented image and the label
figure;
subplot(1,2,1)
imshow(matrix,map)
title('Segmented Image')
subplot(1,2,2)
imshow(Lab,map)
title('Labelled Image')
sgtitle(sprintf('Slice : %d',m))
% Checking dice score:
Label_1double = double(Lab);
matrix = double(matrix);
similarity = dice(matrix, Label_1double);
similarity2 = generalizedDice(matrix, Label_1double);

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
