%% KMEANS3D
volshow(T1)
% Segmenting the volume into 6 clusters
L = imsegkmeans3(T1,6, MaxIterations = 100);
for i = 1:362
    for j = 1:434
        for m = 1:10
        if L(i,j,m) == 2
            L(i,j,m) = 255; 
        elseif L(i,j,m) == 3 
            L(i,j,m) = 1;
        elseif L(i,j,m) == 1 
            L(i,j,m) = 153;
        elseif L(i,j,m) == 4 
            L(i,j,m) = 204;
        elseif L(i,j,m) == 5 
            L(i,j,m) = 51;
        elseif L(i,j,m) == 6
            L(i,j,m) = 102;
        end
        end
    end
end 
figure
L = modefilt(L, [5,5,5]);
volshow(L);
% Changing the label value to 
labels = uint8(255*mat2gray(label(:,:,:)));
for i = 1:362
    for j = 1:434
        for m = 1:10
        if labels(i,j,m) == 0
           labels(i,j,m) = 1;
        end
        end
    end
end 
for m = 1:10
figure
subplot(1,2,1)
map = jet;
imshow(L(:,:,m), map)
title('Segmented Image')
subplot(1,2,2)
map = jet;
imshow(labels(:,:,m), map)
title('Labelled Image')
sgtitle(sprintf('Slice : %d',m))
end

% Calculating the overall dice value
Ldouble = double(L);
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
