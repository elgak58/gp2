function [tr_set, ts_set] = split(images, labels, ts_size)
    
    all_tr_images = {};	% Training images contrainer
    all_tr_labels = {}; % Training labels contrainer
    
    all_ts_images = {};	% Testing images contrainer
    all_ts_labels = {}; % Testing labels contrainer
    
    noi = size(images,2);  % Specify number of individuals

    for i = 1:noi        
        ith_all_images = cell2mat(images(i));	% ith_individual images
        ith_all_labels = cell2mat(labels(i));   % ith_individual labels
        nos = size(ith_all_images,2);           % ith_individual number of samples
        % ALL individuals MUST have the same number of samples (named sequentially, starting from 1)
        
        tr_start = 1;                   % Start index of the training set (index of the first element [image or label])
        tr_end = ceil((1-ts_size)*nos);	% End index of the training set (index of the last element [image or label])   
        
        ts_start = tr_end+1;            % Start index of the testing set (index of the first element [image or label])
        ts_end = nos;                   % End index of the testing set (index of the last element [image or label])
        
        % Specify training set
        ith_tr_images = ith_all_images(:, tr_start : tr_end);   % Extract training portion (for example 80%) out of all the ith_individual images
        ith_tr_labels = ith_all_labels(   tr_start : tr_end);   % Extract training portion (for example 80%) out of all the ith_individual labels
        
        all_tr_images = [all_tr_images ith_tr_images];  % Append the ith_individual training images to the matrix that contrains all the individuals' training images 
        all_tr_labels = [all_tr_labels ith_tr_labels];  % Append the ith_individual training labels to the matrix that contrains all the individuals' training labels 
        
        % Specify testing set
        ith_ts_images = ith_all_images(:, ts_start : ts_end);   % Extract testing portion (for example 20%) out of all the ith_individual images
        ith_ts_labels = ith_all_labels(   ts_start : ts_end);   % Extract testing portion (for example 20%) out of all the ith_individual labels
        
        all_ts_images = [all_ts_images ith_ts_images];  % Append the ith_individual testing images to the matrix that contrains all the individuals' test images 
        all_ts_labels = [all_ts_labels ith_ts_labels];  % Append the ith_individual testing labels to the matrix that contrains all the individuals' test labels                 
    end
    
    tr_set = {all_tr_images, all_tr_labels};    % Training set, all individuals training (images & labels) 
    ts_set = {all_ts_images, all_ts_labels};    % Testing set, all individuals testing (images & labels) 
end