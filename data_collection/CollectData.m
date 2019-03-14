%------------------------CollectData--------------------------------------%
%By Will Knox-------------------------------------------------------------%
%Cogs189------------------------------------------------------------------%
%Today we will be experimenting whether or not you can make a reliable
%experiment without PsychToolBox because PTB is a pain in the ass to
%install!-----------------------------------------------------------------%
%Runs through a collection of images and stores the timestamp for each
%images display-----------------------------------------------------------%

%% Load Image Arrays

%run the CreateArrays script to get two usefule arrays:
%   FamiliarShuffled, and AllShuffled will be used throughout
CreateArrays;
%Add a row for timestamps in AllShuffled
for i=1:length(AllShuffled)
    AllShuffled{3,i} = 0;
end

%suppress image warnings too cause that's some shit we don't need
w = warning ('off','all');

%% Familiarize

%prompt user ofr familiarization phase
%pardon the run on line
fprintf('Welcome! We will begin by familiarizing you with 20 images.\nPlease look at the center of your screen, sit still,\nand pay close attention to each image.\nPress any key when ready.\n')
pause;

%First, familiarize the user with the first 20 images
for i=1:length(FamiliarShuffled)
    
    %show image and wait
    imshow(imread(FamiliarShuffled{1,i}));
    pause(2)
    
end

%close figure for next step
close all;

%% Display Familiar and Unfamiliar and Collect Timestamps

%now prompt the user for the actual experiment
fprintf('\nGreat! Now we will show you a total of 40 images.\nPlease sit still and pay close attention to each image.\nNo action is necessary, just enjoy the images.\nPress any key when ready!\n')
pause;
%quick get the neurosky go go!
fprintf('\nStart the Neurosky in 3...')
pause(1)
fprintf('\n2...')
pause(1)
fprintf('\n1...\n')
pause(1)
%allow user time to prepare
fprintf('\nTest beginning in 3...')
pause(1)
fprintf('\n2...')
pause(1)
fprintf('\n1...\n')
pause(1)
%loop through all images and collect timestamps, start the timer
tic;
for i=1:length(AllShuffled)
    
    %timestamp start of image
    AllShuffled{3,i} = toc;
    %show image and wait
    imshow(imread(AllShuffled{1,i}));
    pause(2)
    
end

close all;

fprintf('\n\nThank you! Please turn off the Neurosky now, if not already done\n\n')

%convert to table so you can convert to csv and save
T = cell2table(AllShuffled);
writetable(T, 'subjdata.csv');

