% Two Nets for the Elven-kings under the sky (32x32),
% Two for the Dwarf-lords in their halls of stone(64x64),
% Two for Mortal Men doomed to die(128x128),

% (And another two for 256x256)

% One >>script<< for the Dark Lord on his dark throne
% In the Land of Mordor where the Shadows lie.
% One Script to rule them all, One M-file to find them,
% One Script to bring them all and in the darkness bind them
% In the Land of Mordor where the Shadows lie.


listdir = dir();

for directory = listdir'
    if (strcmp(directory.name, '.') || strcmp(directory.name, '..'))
        continue;
    end
    if (isdir(directory.name) == 0)
        continue
    end
    display(directory.name) 
    cd(directory.name)
    run show_results.m
    save('./data/baseline/info', 'info')
    cd ..
end

