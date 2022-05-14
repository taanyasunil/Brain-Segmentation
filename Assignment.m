load('Brain.mat')
%figure('units','normalized','outerposition',[0.2 0.2 0.8 0.8]);

%% LOADING THE T1 IMAGES
for i = 1 : 10
    conv = uint8(255*mat2gray(T1(:,:,i)));
    filename = sprintf("T1image%d.png", i);
    imwrite(conv,filename);
end
    T1_1 = imread('T1image1.png');
    T1_2 = imread('T1image2.png');
    T1_3 = imread('T1image3.png');
    T1_4 = imread('T1image4.png');
    T1_5 = imread('T1image5.png');
    T1_6 = imread('T1image6.png');
    T1_7 = imread('T1image7.png');
    T1_8 = imread('T1image8.png');
    T1_9 = imread('T1image9.png');
    T1_10 = imread('T1image10.png');
    % Creating a list with all the names in it: 
    T1_file = ["T1image1.png" ,"T1image2.png","T1image3.png","T1image4.png","T1image5.png","T1image6.png","T1image7.png","T1image8.png","T1image9.png","T1image10.png"];
    % Displaying the images
    figure;
    for m = 1:10
        imread(T1_file(m))
        for m = 1:5
            subplot(2,5,m)
            imshow(T1_file(m))
            title(sprintf('Slice : %d',m))
        end
        for m = 6:10
            subplot(2,5,m)
            imshow(T1_file(m))
            title(sprintf('Slice : %d',m))
            colorbar;
        end
    end

%% LOADING THE LABEL IMAGES
for i = 1 : 10
    conv2 = uint8(255*mat2gray(label(:,:,i)));
    map = jet;
    filename = sprintf("Labelimage%d.png", i);
    imwrite(conv2,map,filename)
    
end
    Label_1 = imread('Labelimage1.png');
    Label_2 = imread('Labelimage2.png');
    Label_3 = imread('Labelimage3.png');
    Label_4 = imread('Labelimage4.png');
    Label_5 = imread('Labelimage5.png');
    Label_6 = imread('Labelimage6.png');
    Label_7 = imread('Labelimage7.png');
    Label_8 = imread('Labelimage8.png');
    Label_9 = imread('Labelimage9.png');
    Label_10 = imread('Labelimage10.png');

    Labels_file = ["Labelimage1.png" ,"Labelimage2.png","Labelimage3.png","Labelimage4.png","Labelimage5.png","Labelimage6.png","Labelimage7.png","Labelimage8.png","Labelimage9.png","Labelimage10.png"];

    % Displaying the labels
    figure;
    for m = 1:10
        imread(Labels_file(m))
        for m = 1:5
            subplot(2,5,m)
            imshow(Labels_file(m))
            title(sprintf('Labels : %d',m))
        end
        for m = 6:10
            subplot(2,5,m)
            imshow(Labels_file(m))
            title(sprintf('Labels : %d',m))
        end
    end
