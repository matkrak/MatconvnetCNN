% use this script to copy results to another directory.
% i.e. if u wanted to copy to another machine, ZIP and emails etc.
% info.mat files will be copied (subdirectory for each will be created)
%
% you can change the file to be copied in the beggining of the script.
% you might also want to change home path and destination path
%
%  can not handle errors yet (errors if files dont exist)


home = '/home/kraki/Documents/WSW/Projekt/net'
dest_path = '/home/kraki/Documents/WSW/Projekt/WYNIKI'

file_name = 'info.mat'

cd(home)


listdir = dir();

for directory = listdir'
    display(directory.name) 
    
    if (~isdir(directory.name) || strcmp(directory.name, '.') || strcmp(directory.name, '..') || strcmp(directory.name, '.git'))
        display('Skipping. . .')
        continue;
    end
   
    cd(dest_path)
    
    if(~isdir(directory.name))
        mkdir(directory.name)
    end
    

    tmp = strcat(dest_path, filesep, directory.name, filesep, file_name)
    
    cd(home)
    cd(directory.name)
    
    cd data
    cd baseline
    
    copyfile('info.mat', tmp)
    cd(home)
end
display('***** D O N E *****')
