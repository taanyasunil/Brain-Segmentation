%% Thresholding3D
figure
volshow(T1)
conv = uint8(255*mat2gray(T1));
file = medfilt3(file, [5,5,5] );
file2 = medfilt3(file, [1,1,1]);
mat1 = zeros(362,434,10);mat2 = zeros(362,434,10);mat3 = zeros(362,434,10);
mat4 = zeros(362,434,10);mat5 = zeros(362,434,10);mat6 = zeros(362,434,10);
matrix = zeros(362,434,10);
figure
imhist(conv)

%% Background
for i = 1:362
    for j = 1:434
        for m = 1:10
        if file(i,j,m) >= 0 && file(i,j,m) <= 15
        mat1(i,j,m) = 1;
        matrix(i,j,m) = mat1(i,j,m);
        else
        mat1(i,j,m) = 0;
        end
        end
    end
end
%% Yellow portion
for i = 1:362
    for j = 1:434
        for m = 1:10
        if conv(i,j,m) >= 30 && conv(i,j,m) <= 55
        mat3(i,j,m) = 153;
        matrix(i,j,m) = mat3(i,j,m);
        else
        mat3(i,j,m) = 0;
        end
        end
    end
end
%% Red portion
for i = 1:362
    for j = 1:434
        for m = 1:10
        if conv(i,j,m) >= 80 && conv(i,j,m) <= 130
        mat4(i,j,m) = 204;
        matrix(i,j,m) = mat4(i,j,m);
        else
        mat4(i,j,m) = 0;
        end
        end
    end
end
%% Maroon portion
for i = 1:362
    for j = 1:434
        for m = 1:10
        if conv(i,j,m) >= 130 && conv(i,j,m) <= 170
        mat5(i,j,m) = 255;
        matrix(i,j,m) = mat5(i,j,m);
        else
        mat5(i,j,m) = 0;
        end
        end
    end
end
%% Cyan portion
for i = 1:362
    for j = 1:434
        for m = 1:10
        if file2(i,j,m) >= 20 && file2(i,j,m) <= 29
        mat6(i,j,m) = 102;
        matrix(i,j,m) = mat6(i,j,m);
        else
        mat6(i,j,m) = 0;
        end
        end
    end
end
%% Blue
for i = 1:362
    for j = 1:434
        for m = 1:10
        if conv(i,j,m) >= 170 && conv(i,j,m) <= 255
        mat2(i,j,m) = 51;
        matrix(i,j,m) = mat2(i,j,m);
        else
        mat2(i,j,m) = 0;
        end
        end
    end
end
matrix = modefilt(matrix, [5,5,5]);
volshow(matrix)


% Calculating the overall dice value
Ldouble = double(matrix);
Label_1double = double(labels);
similarity = dice(Ldouble, Label_1double);
similarity2 = generalizedDice(Ldouble, Label_1double);

disp(["Similarity value of Air (Background):" similarity(1)]);
disp(["Similarity value of Skin/Scalp (Blue):" similarity(51)]);
disp(["Similarity value of Skull (Cyan):" similarity(102)]);
disp(["Similarity value of CSF (Yellow):" similarity(153)]);
disp(["Similarity value of Gray Matter (Red):" similarity(204)]);
disp(["Similarity value of White Matter (Maroon):" similarity(255)]);
disp(["The Generalized Dice Score is :" num2str(similarity2)]);