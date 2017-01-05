% [net, info] = cnn();
% 
% net.layers{end}.type = 'softmax';
% 
% load('./data/baseline/imdb.mat')
% 
% correct = 0;
% 
% for i = 1:50 
%     im = images.data(:, : ,:, i);
%     res = vl_simplenn(net, im);
%     if (res(12).x(1) > res(12).x(2))
%        r = 1;
%     else
%         r = 2;
%     end
%     if (r == images.labels(i))
%         correct = correct + 1;
%     end
% end
% 
% fprintf('TOTAL: %d, correct: %d\n\n',50, correct);
%%%%%%%%%%%%%%%%
[net, info] = cnn();

net.layers{end}.type = 'softmax';

load('./data/baseline/imdb.mat')
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
%%%%%%%%%%%%%%

% figure()
% subplot(2,1,1);
% xlabel('epoch')
% ylabel('train error')
% plot([info.train.objective]);
% 
% 
% subplot(2,1,2);
% xlabel('epoch')
% ylabel('train error')
% plot([info.val.objective], 'r')

% 
% for i=41:50
%    no = floor(rand(1) * 50);
%    im = images.data(:, :, :, i);
%    res = vl_simplenn(net, im);
%    display(res(end).x)
%    display(images.labels(i));
%    imshow(im)
%    k = waitforbuttonpress;
% end