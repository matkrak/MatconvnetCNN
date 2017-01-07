%% init

% format compact;
% clear all;
% close all;
% clc;
% parameters
function imdb = prepareData()

pathToData = '/home/kraki/Documents/WSW/Projekt/PRZEKROJE';
pathToLabels = '/home/kraki/Documents/WSW/Projekt/2015_etykiety.txt';
image_h = 64; % pierwsza wspolrzedna
image_w = 64;   % druga
to_gray = 1;




trainset_size = 30;        %zmienic
valset_size = 10;
testset_size = 10;
set_size = 50;

%% prepare labels
labelsID = fopen(pathToLabels, 'r');
formatSpec = '%d';
labels = fscanf(labelsID, formatSpec);
labels = labels';

%% prepare images
if to_gray == 1
    image_channels = 1;
else
    image_channels = 3;
end
% prepare memory
% trainset = zeros([image_h, image_w, image_channels, train_set_size]); 
% testset = zeros([image_h, image_w, image_channels, test_set_size]);
set = zeros([image_h, image_w, image_channels, set_size]);

imagelist = dir(pathToData);

% train_set_current = 1;
% test_set_current = 1;
set_current = 1;
for image = imagelist'
    if(strcmp(image.name, '.') || strcmp(image.name, '..'))
        continue;
    end
   path = strcat(pathToData, '/', image.name);
   fprintf('Current file: %s\n', path)
   im = imread(path);
   
   if to_gray == 1
       im = rgb2gray(im);
   end
 
%    if train_set_current <= train_set_size
%       trainset(:, :, :, train_set_current) = imresize(im,[image_h image_w]);
%       train_set_current = train_set_current + 1;
%    
%    elseif test_set_current <= test_set_size
%       testset(:, :, :, test_set_current) = imresize(im,[image_h image_w]);
%       test_set_current = test_set_current + 1;
%    else
   if set_current <= set_size
      set(:, :, :, set_current) = imresize(im,[image_h image_w]);
      set_current = set_current + 1;
   else 
       display('Built train and test sets')
       break;
   end
     
  
end

% fprintf('Train set contains %d images\n', train_set_current - 1);
% fprintf('Test set contains %d images\n', test_set_current - 1); 
fprintf('Set contains %d images\n', set_current - 1); 

%% normalize data
for i=1:image_channels
%    trainset(:, :, i, :) = trainset(:, :, i, :) - mean(mean(mean(trainset(:, :, i, :),1), 2), 4);
%    trainset(:, :, i, :) = trainset(:, :, i, :) / std(std(std(trainset(:, :, i, :), 0, 1), 0, 2), 0, 4);
%    
%    testset(:, :, i, :) = testset(:, :, i, :) - mean(mean(mean(testset(:, :, i, :),1), 2), 4);
%    testset(:, :, i, :) = testset(:, :, i, :) / std(std(std(testset(:, :, i, :), 0, 1), 0, 2), 0, 4);
   set(:, :, i, :) = set(:, :, i, :) - mean(mean(mean(set(:, :, i, :),1), 2), 4);
   set(:, :, i, :) = set(:, :, i, :) / std(std(std(set(:, :, i, :), 0, 1), 0, 2), 0, 4);
end

mean(mean(mean(set(:, :, 1, :),1), 2), 4)
std(std(std(set(:, :, 1, :), 0, 1), 0, 2), 0, 4)

% data = [trainset testset];

%% insert into imdb

imdb.images.data = single(set);
% imdb.images.data_mean = mean(data,4);
imdb.images.labels = single(labels + 1);
imdb.images.set=single([ones(1, trainset_size) 2*ones(1, valset_size) 3*ones(1, testset_size)]);
imdb.meta.sets = {'train', 'val', 'test'} ;
imdb.meta.classes = arrayfun(@(x)sprintf('%d',x),0:1,'uniformoutput',false) ;
end