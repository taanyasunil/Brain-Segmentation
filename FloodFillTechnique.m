%% Implementing Flood-Fill Technique:
background = zeros(1,10);
blue = zeros(1,10);
cyan = zeros(1,10);
yellow = zeros(1,10);
red = zeros(1,10);
maroon = zeros(1,10);
gen = zeros(1,10);
for m = 1:10
img = imread(T1_file(m));
Mat = zeros(362,434);

J = grayconnected(img,34,34); % BACKGROUND
J = J*1;
J = uint8(J);
for i = 1:362
    for j = 1:434
        if J(i,j) == 1
            Mat(i,j) = J(i,j);
        end
    end
end
K = grayconnected(img,180,22); % BLUE
K = K*51;
K = uint8(K);
for i = 1:362
    for j = 1:434
        if K(i,j) == 51
            Mat(i,j) = K(i,j);
        end
    end
end
Q = grayconnected(img,96,76); % LIGHT BLUE
Q = Q*102;
Q = uint8(Q);
for i = 1:362
    for j = 1:434
        if Q(i,j) == 102
            Mat(i,j) = Q(i,j);
        end
    end
end
N = grayconnected(img,144,64); % RED
N = N*204;
N = uint8(N);
for i = 1:362
    for j = 1:434
        if N(i,j) == 204
            Mat(i,j) = N(i,j);
        end
    end
end
X = grayconnected(img,234,222); % MAROON
X = X*255;
X = uint8(X);
for i = 1:362
    for j = 1:434
        if X(i,j) == 255
            Mat(i,j) = X(i,j);
        end
    end
end

I = grayconnected(img,172,178); % YELLOW
I = I*153;
I = uint8(I);
for i = 1:362
    for j = 1:434
        if I(i,j) == 153
            Mat(i,j) = I(i,j);
        end
    end
end

% Changing background values from 0 to 1 as dice takes index values from 1
Lab = imread(Labels_file(m));
for i = 1:362
    for j = 1:434
        if Lab(i,j) == 0
           Lab(i,j) = J(i,j);
        end
    end
end 

% Converting to double in order to analyse
Label_1double = double(Lab);
similarity = dice(Mat, Label_1double);
similarity2 = generalizedDice(Mat, Label_1double);

map = jet;
figure
subplot(1,2,1)
imshow(Mat, map);
impixelinfo;
title(sprintf('Segmented Image - Slice : %d',m))
%title(['The Generalized Dice Score is = ' num2str(similarity2)]);

subplot(1,2,2)
imshow(Lab, map)
impixelinfo;
title(sprintf('Labelled Image - Slice : %d',m))

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
