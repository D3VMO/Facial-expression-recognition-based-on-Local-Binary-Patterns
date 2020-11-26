% Version 23/05/2020 
% version adaptée à la base JAFFE
clear;
close all;

%% Load Image Information  Face Database Directory
faceDatabase = imageSet('D:\CV\miniprojets\projetIPS\jaffe','recursive');

%% Display Montage of First Face
figure;
montage(faceDatabase(1).ImageLocation);
title('Images of Single Face');

mapping = getmapping(8,'riu2');  % uniform rotation-invariant LBP (riu2)
                               % rotation-invariant (ri)
                               % uniform LBP (u2)





%% Extract LBP Features for training set 

trainingFeatures =[];
featureCount = 1;
for k=1:size(faceDatabase,2)
    for l = 1:faceDatabase(k).Count
        Input_image = read(faceDatabase(k), l);
        if size(Input_image, 3) == 3
            Input_image = rgb2gray(Input_image);
        end
        
        [m, n] = size(Input_image);
        F = [];
        m1 = floor(m/8) * 8;
        n1 = floor(n/8) * 8;
        for i = 1 : floor(m/8) : m1
            for j = 1 : floor(n/8) : n1
              
               lbp_feature = lbp(Input_image(i:floor(i+m/8-1), j:floor(j+n/8-1)),1,8,mapping,'nh');
               
               F = horzcat(F, lbp_feature);
                
            end
        end
    
        trainingFeatures(featureCount,:)= F;
        trainingLabel{featureCount} = faceDatabase(k).Description;    
        featureCount = featureCount + 1;
    end
end
%%
 % sauvegarder  les données du training dans un fichier .txt
fileID=fopen('LBP_riu2_training_nomBinome.txt','w');
for i=1: size(trainingFeatures,1)
    for j= 1: size(trainingFeatures,2)
        fprintf(fileID,'%f \t',trainingFeatures(i,j));
    end
    fprintf(fileID,'\n');
end
fclose(fileID);

  % sauvegarder  les labels dans un fichier .txt : Une seule fois

fileID=fopen('labels_nomBinome.txt','w');
for i=1: size(trainingLabel,2)
    
        fprintf(fileID,'%c \t',trainingLabel{i});
 end
   fclose(fileID);
% 








