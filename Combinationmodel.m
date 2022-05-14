%% COMBINED 2D MODEL:
background = zeros(1,10);
blue = zeros(1,10);
cyan = zeros(1,10);
yellow = zeros(1,10);
red = zeros(1,10);
maroon = zeros(1,10);
gen = zeros(1,10);
mat2 = zeros(362,434);
mat4 = zeros(362,434);
for m = 1:10
%img = imread(T1_file(m));
file = imread(T1_file(m));
filedoub = im2double(file);
file2 = medfilt2(file,[9 9]);
file2doub = im2double(file2);
Mat = zeros(362,434);

%% BACKGROUND: AIR
x=50; y=50;
J = regiongrowing(filedoub,x,y,0.1); 
J = J*1;
J = uint8(J);
Mat = zeros(362,434);

% Changing background values from 0 to 1 as dice takes index values from 1
for i = 1:362
    for j = 1:434
        if J(i,j) == 1
            Mat(i,j) = J(i,j);
        end
    end
end

%% CYAN
x=74; y=94;
X = regiongrowing(filedoub,x,y,0.09); 
X = X*102;
X = uint8(X);
for i = 1:362
    for j = 1:434
        if X(i,j) == 102
            Mat(i,j) = X(i,j);
        end
    end
end

%% RED
for i = 1:362
    for j = 1:434
        if file(i,j) >= 115 && file(i,j) <= 120
        mat4(i,j) = 204;
        else
        mat4(i,j) = 0;
        end
    end
end
% Doing it for the next section: Red
x=194; y=201;
if m == 10; val = 0.2; else val = 0.09; end
N = regiongrowing(filedoub,x,y,val); 
N = N*204;
N = uint8(N);
for i = 1:362
    for j = 1:434
        if N(i,j) == 204
            mat4(i,j) = N(i,j);
            Mat(i,j) = mat4(i,j);
        end
    end
end

%% MAROON
[L,~] = imsegkmeans(file,6,NumAttempts=6);
% Correcting the labels to match the labels provided in order to analyse them.
if m == 1
    for i = 1:362
    for j = 1:434
        if L(i,j) == 1 ; L(i,j) = 255; Mat(i,j) =  L(i,j);
        end
    end
    end
elseif m == 2
    for i = 1:362
    for j = 1:434
        if L(i,j) == 5; L(i,j) = 255;Mat(i,j) =  L(i,j);
        end
    end
    end
elseif m == 3
    for i = 1:362
    for j = 1:434
        if L(i,j) == 5; L(i,j) = 255;Mat(i,j) =  L(i,j);
        end
    end
    end
elseif m == 4
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2;L(i,j) = 255;Mat(i,j) =  L(i,j);
        end
    end
    end
elseif m == 5
    for i = 1:362
    for j = 1:434
        if L(i,j) == 4 ;L(i,j) = 255;Mat(i,j) =  L(i,j);
        end
    end
    end
elseif m == 6
    for i = 1:362
    for j = 1:434
        if L(i,j) == 3;L(i,j) = 255;Mat(i,j) =  L(i,j);
        end 
    end
    end
elseif m == 7
    for i = 1:362
    for j = 1:434
        if L(i,j) == 3;L(i,j) = 255;Mat(i,j) =  L(i,j);
        end
    end
    end
elseif m == 8
    for i = 1:362
    for j = 1:434
        if L(i,j) == 2; L(i,j) = 255;Mat(i,j) =  L(i,j);
        end
    end
    end
elseif m == 9
    for i = 1:362
    for j = 1:434
        if L(i,j) == 6;L(i,j) = 255;Mat(i,j) =  L(i,j);
        end
    end
    end
elseif m == 10
    for i = 1:362
    for j = 1:434
        if L(i,j) == 4 ;L(i,j) = 255;Mat(i,j) =  L(i,j);
        end
    end
    end
end

%% YELLOW
X = grayslice(file,6);
X = uint8(X);
for i = 1:362
    for j = 1:434
        if X(i,j) == 1 
            X(i,j) = 153;
            Mat(i,j) = X(i,j);
        end
    end
end

%% BLUE 
for i = 1:362
    for j = 1:434
        if file2(i,j) >= 170 && file2(i,j) <= 255
        mat2(i,j) = 51;
        else
        mat2(i,j) = 0;
        end
    end
end
x=73; y=68;
D = regiongrowing(file2doub,x,y,0.18); 
D = D*51;
D = uint8(D);
for i = 1:362
    for j = 1:434
        if D(i,j) == 51
            mat2(i,j) = D(i,j);
            Mat(i,j) = mat2(i,j);
        end
    end
end

Mat = modefilt(Mat,[5 5]);

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
