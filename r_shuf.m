function [tr_images, tr_labels] = r_shuf(tr_set)
    
    tr_images = [];  % Shuffled training data container
    tr_labels = [];  % Shuffled training labels container
        
    [images, labels] = deal(tr_set{1}, tr_set{2});	% Extract training images (cells) & training labels (cells) of all individuals
    noi = size(images, 2);                          % Specify number of individuals
    
    % Extract each individual (training images [matrix]) & (training labels [matrix])
    for i = 1:noi
        tr_images = [tr_images cell2mat(images(i))];
        tr_labels = [tr_labels cell2mat(labels(i))];
    end

    % Perform Shuffling
    columns = size(tr_images,2);            % Specify the number of columns
    shuffle_order = randperm(columns);      % Create a list that contains randomly shuffled values ranges from 1 to (number of colums) 
    tr_images = tr_images(:,shuffle_order);	% Shuffle training images base on the specified shuffling_order 
    tr_labels = tr_labels(1,shuffle_order);	% Shuffle training labels base on the specified shuffling_order     
     
end