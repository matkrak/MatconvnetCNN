% perform tests for the particular net
% you can run setcions manually, just keep in mind to 
% run this init section first


%% init section - train the net or load saved state
display('Initialising network . . .')

[net, info] = cnn();

% change last layer for testing purpose
net.layers{end}.type = 'softmax';

% load images!
load('./data/baseline/imdb.mat')

%% test 1 - check performance over test set:
display('Testing performance over test set . . .')
testset = find(images.set == 3);

correct = 0;

for i = 1:numel(testset)
    im = images.data(:, : ,:, testset(i));
    res = vl_simplenn(net, im);

    if (res(end).x(1) > res(end).x(2))
       r = 1;
    else
        r = 2;
    end
    if (r == images.labels(testset(i)))
        correct = correct + 1;
    end
end

fprintf('TOTAL: %d, correct: %d\n\n',numel(testset), correct);

%% test 2 - check performance over all set:
display('Testing performance over all data set . . .')

correct = 0;

for i = 1:numel(images.labels)
    im = images.data(:, : ,:, i);
    res = vl_simplenn(net, im);
    if (res(12).x(1) > res(12).x(2))
       r = 1;
    else
        r = 2;
    end
    if (r == images.labels(i))
        correct = correct + 1;
    end
end

fprintf('TOTAL: %d, correct: %d\n\n',50, correct);


%% draw results
display('Plotting results:')

figure(1)
title('train and validation errors')

subplot(2,1,1);
xlabel('epoch')
ylabel('train error')
plot([info.train.objective]);


subplot(2,1,2);
xlabel('epoch')
ylabel('validation error')
plot([info.val.objective], 'r')



%% display 5 random examples with labels 1 or 2 and results predicted by net:
display('5 random images with net prediction:')

figure(2)
title('Click to proceed')
for i=1:5
   no = floor(rand(1) * 50);
   im = images.data(:, :, :, no);
   res = vl_simplenn(net, im);
   if (res(12).x(1) > res(12).x(2))
       r = 1;
    else
        r = 2;
    end
   fprintf('For this image (%d), the actual label was : %d\n', no, images.labels(no));
   fprintf('Networks output are: [%f %f].       Predicted label: %d\n\n', res(end).x(1), res(end).x(2), r) 
%    display(res(end).x)
%    display(images.labels(no));
   imshow(im)
   k = waitforbuttonpress;
end