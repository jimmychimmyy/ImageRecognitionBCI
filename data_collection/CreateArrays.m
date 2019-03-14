%----------------------Create Arrays--------------------------------------%
%By Will Knox-------------------------------------------------------------%
%Cogs189------------------------------------------------------------------%
%Takes a predetermined set of images and forms them into 2 random arrays--%
%To be used with CollectData.m--------------------------------------------%

%% Load Images

%First load all files (ONLY WORKS IF PICS ARE LOCALLY SAVED)
Familiar = {'Familiar01.JPG', 'Familiar02.jpg', 'Familiar03.jpg', ...
    'Familiar04.jpg', 'Familiar05.JPG', 'Familiar06.JPG', ...
    'Familiar07.JPG', 'Familiar08.JPG', 'Familiar09.JPG', ...
    'Familiar10.jpg', 'Familiar11.jpg', 'Familiar12.jpg', ...
    'Familiar13.JPG', 'Familiar14.JPG', 'Familiar15.jpg', ...
    'Familiar16.jpg', 'Familiar17.JPG', 'Familiar18.JPG', ...
    'Familiar19.jpg', 'Familiar20.jpg'};


Unfamiliar = {'Unfamiliar01.jpg', 'Unfamiliar02.jpg', ...
    'Unfamiliar03.jpg', 'Unfamiliar04.jpg', 'Unfamiliar05.jpg', ...
    'Unfamiliar06.jpg', 'Unfamiliar07.jpg', 'Unfamiliar08.JPG', ...
    'Unfamiliar09.JPG', 'Unfamiliar10.JPG', 'Unfamiliar11.jpg', ...
    'Unfamiliar12.JPG', 'Unfamiliar13.JPG', 'Unfamiliar14.JPG', ...
    'Unfamiliar15.JPG', 'Unfamiliar16.JPG', 'Unfamiliar17.jpg', ...
    'Unfamiliar18.JPG', 'Unfamiliar19.jpg', 'Unfamiliar20.JPG'};

%remember: to view the images in this state:
%   imshow(imread(Familiar.Pics{1,i}))

%% Create Random Arrays

%randomize familiar array for initial familiarization
FamiliarShuffled = Familiar(randperm(length(Familiar)));

%randomize the combination of both cell arrays
All = [Familiar, Unfamiliar];
AllShuffled = All(randperm(length(All)));

%% Assign Target Values
for i=1:length(AllShuffled)
    
    %identify first characters in String name for target value
    Type = strsplit(AllShuffled{1,i},'l');
    %compare first to target
    if(strcmp(Type{1,1},'Fami'))
        AllShuffled{2,i} = 1;
    else
        AllShuffled{2,i} = 0;
    end
end

%% Result
%Now you should have two (useful) arrays:
%   FamiliarShuffled: All familiar images shuffled randomly
%   AllShuffled: All images shuffled randomly, along with a target identity