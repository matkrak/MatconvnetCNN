% Two Nets for the Elven-kings under the sky (32x32),
% Two for the Dwarf-lords in their halls of stone(64x64),
% Two for Mortal Men doomed to die(128x128),

% (And another two for 256x256)

% One >>script<< for the Dark Lord on his dark throne
% In the Land of Mordor where the Shadows lie.
% One Script to rule them all, One M-file to find them,
% One Script to bring them all and in the darkness bind them
% In the Land of Mordor where the Shadows lie.


% if the nets are already trained this script wont train again.
% instead will use saved nets to perform tests or whatever you like

flag_check_test_set_performance = 1;
flag_check_overall_performance = 1;
flag_print_learning_curves_to_png = 1;


listdir = dir();

for directory = listdir'
    if (isdir(directory.name) == 0 || strcmp(directory.name, '.') || strcmp(directory.name, '..') || strcmp(directory.name, '.git') || strcmp(directory.name, 'WYNIKI'))
        display(directory.name) 
        display('Skipping. . .')
        continue;
    end
    display(directory.name) 
    cd(directory.name)
    
    %   * * * * * * * * * * * * *
    %   * * * do stuff here * * *
    %   * * * * * * * * * * * * *

%     run show_results    % just if you know what you are doing, 
%                           this does a lot of stuff


% FOR WSW PROJECT PURPOSES:

%       train nets or load trained if exists

    [net, info] = cnn();
    save('./data/baseline/info', 'info')

    
%       check performance of test set

    if(flag_check_test_set_performance)
        
        display('Performance over test set:')
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
    end
    
    
%       check performance of the whole set

    if(flag_check_overall_performance)
        display('Performance over the whole dataset:')
        net.layers{end}.type = 'softmax';

        load('./data/baseline/imdb.mat')

        correct = 0;

        for i = 1:numel(images.labels)
            im = images.data(:, : ,:, i);
            res = vl_simplenn(net, im);

            if (res(end).x(1) > res(end).x(2))
               r = 1;
            else
                r = 2;
            end
            if (r == images.labels(i))
                correct = correct + 1;
            end
        end

        fprintf('TOTAL: %d, correct: %d\n\n',numel(images.labels), correct); 
    end
    
    
%   plot learning curevs and save plots to be copied later

    if(flag_print_learning_curves_to_png)
        display('Printing learning curves')

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

        print('Learning Curves', '-dpng')
        close 1
    end
    
    % required for the loop to continue
    cd ..
end

