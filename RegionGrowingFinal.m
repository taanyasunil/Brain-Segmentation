background = zeros(1,10);
blue = zeros(1,10);
cyan = zeros(1,10);
yellow = zeros(1,10);
red = zeros(1,10);
maroon = zeros(1,10);
gen = zeros(1,10);
for m = 1:10
% First doing it only for the background
I = im2double(imread(T1_file(m)));
x=50; y=50;
J = regiongrowing(I,x,y,0.1); 
J = J*1;
J = uint8(J);
figure;
subplot(2,3,1)
imshow(J);
impixelinfo;
colormap('jet')
title('Background Filter')

Mat = zeros(362,434);

% Changing background values from 0 to 1 as dice takes index values from 1
for i = 1:362
    for j = 1:434
        if J(i,j) == 1
            Mat(i,j) = J(i,j);
        end
    end
end

% Doing it for the next section: Blue
x=252; y=36;
%if m==1; val = 0.3; elseif m ==2; val = 0.3; end
D = regiongrowing(I,x,y,0.2);
D = D*51;
D = uint8(D);
%K = imadjust(I,[0 1]);
subplot(2,3,2)
imshow(D);
colormap('jet')
title('Blue Filter')

for i = 1:362
    for j = 1:434
        if D(i,j) == 51
            Mat(i,j) = D(i,j);
        end
    end
end

% Doing it for the next section: Light Blue
x=74; y=94;
X = regiongrowing(I,x,y,0.09); 
X = X*102;
X = uint8(X);
%K = imadjust(I,[0 1]);
subplot(2,3,3)
imshow(X);
colormap('jet')
title('Light Blue Filter')

for i = 1:362
    for j = 1:434
        if X(i,j) == 102
            Mat(i,j) = X(i,j);
        end
    end
end

% Doing it for the next section: Red
x=262; y=282;
if m == 1; val = 0.11; elseif m == 10; val = 0.2; else val = 0.11; end
N = regiongrowing(I,x,y,val); 
N = N*204;
N = uint8(N);
%K = imadjust(I,[0 1]);
subplot(2,3,4)
imshow(N);
colormap('jet')
title('Red Filter')

for i = 1:362
    for j = 1:434
        if N(i,j) == 204
            Mat(i,j) = N(i,j);
        end
    end
end

% Doing it for the next section: Maroon
x=148; y=264;
K = regiongrowing(I,x,y,0.09); 
K = K*255;
K = uint8(K);
%K = imadjust(I,[0 1]);
subplot(2,3,5)
imshow(K);
impixelinfo;
colormap('jet')
title('Maroon Filter')

for i = 1:362
    for j = 1:434
        if K(i,j) == 255
            Mat(i,j) = K(i,j);
        end
    end
end

% Doing it for the next section: Yellow
x=178; y=178;
if m == 1; val = 0.13; elseif m == 2; val = 0.12; elseif m == 3 ; val = 0.12; elseif m == 4; val = 0.14;elseif m == 5; val = 0.14;elseif m == 6; val = 0.14;elseif m == 7; val = 0.13;elseif m == 8; val = 0.14;elseif m == 9; val = 0.14; elseif m ==10; val = 0.09; end
M = regiongrowing(I,x,y,val); 
M = M*153;
M = uint8(M);
subplot(2,3,6)
imshow(M);
colormap('jet')
title('Yellow Filter')
sgtitle(sprintf('Slice : %d',m))

for i = 1:362
    for j = 1:434
        if M(i,j) == 153
            Mat(i,j) = M(i,j);
        end
    end
end

%% Computing Generalized Dice Score:
% Convering to double in order to analyse
Lab = imread(Labels_file(m));
for i = 1:362
    for j = 1:434
        if Lab(i,j) == 0
           Lab(i,j) = J(i,j);
        end
    end
end 
Label_1double = double(Lab);
similarity = dice(Mat, Label_1double);
similarity2 = generalizedDice(Mat, Label_1double);

map = jet;
figure
subplot(1,2,1)
imshow(Mat, map);
impixelinfo;
title('Segmented Image')
%title(['The Generalized Dice Score is = ' num2str(similarity)])

% Looking at the Labels
subplot(1,2,2)
imshow(Lab, map);
impixelinfo;
title('Original Labels')
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
