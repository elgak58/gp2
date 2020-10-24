function [tr_images, tr_labels] = o_shuf(tr_set)
    
    tr_images = [];  % Shuffled training images container
    tr_labels = [];  % Shuffled training labels container
    
    [images, labels] = deal(tr_set{1}, tr_set{2});	% Extract training images (cells) & training labels (cells) of all individuals
    noi = size(images, 2);                          % Specify number of individuals
    nos = size(cell2mat(images(1)), 2);             % Specify number of samples
    % ALL individuals MUST have the same number of samples (named sequentially, starting from 1)
    
    for i = 1:nos  % for each sample 
        for j = 1:noi  % for each individual 
            
            j_person_images = cell2mat(images(j));	% Access all the images of the jth_individual 
            j_person_labels = cell2mat(labels(j));  % Access all the labels of the jth_individual 
            
            ith_image = j_person_images(:,i);	% Read the ith_image of the jth_individual
            ith_label = j_person_labels(:,i);   % Read the ith_label of the jth_individual
            
            tr_images = [tr_images ith_image];  % Add the ith_image to the shuffling container of images
            tr_labels = [tr_labels ith_label];  % Add the ith_label to the shuffling container of labels
        end
    end

end