# Brain-Segmentation
This project involves 2D and 3D segmentation of Brain Images in MATLAB.
10 Slices of Brain MRI Images as well as the ground truth labels have been provided in the file Brain.mat stored in 'T1' and 'label' respectively.
For 2D image segmentation, 6 methods were implemented - Thresholding, MultiLevel Thresholding, KMeans, Flood-Fill Technique, Region Growing and a Combined model that includes a mixture of the aforementioned methods.
The thresholding method is implemented in Thresholding.m
The MultiLevel Thresholding is implemented in MultilevelThresholding.m
Kmeans is implemented in Kmeansimplementation.m
Flood-Fill Technique is implemented in FloodFillTechnique.m
Region Growing is implemented in regiongrowing.m and RegionGrowingFinal.m
Finally the combined 2D model is implemented in Combinationmodel.m

For 3D image segmentation, 3 algorithms have been implemented - Thresholding, KMeans and a Model combining Thresholding and KMeans.
Thresholding model can be found in Thresh3D.m
KMeans model can be found in KMeans3D.m
And finally, the combined model can be found in Combined3D.m

These models also do use several filters to bring out the best results. More information on this and other methods implemented as well as an indepth analysis can be found in the report titled 'Taanya Computer Vision'
