function [tr_set, ts_set] = loader(noi, ds_path, dims_img, codec, ts_size)
    
    X = [];         % Data container for an individual
    Y = [];         % Labels container for an individual
    ds_data = {};   % The whole dataset images container
    ds_labels = {}; % The whole dataset labels container
    
    for ID = 1:noi   % noi (number of individuals)
        
        i_path = strcat(ds_path,'\',int2str(ID),'\');  % Create an individual path based on ID (start from 1) - strcat (string concatenate)
        i_data = dir(strcat(i_path,'\*.',codec));      % Access and list all the files (signatures) in the ith_individual directory        
        % When pass the ith_individual path to dir function, that creates a dir structure that lists the files in that directory
        % Files in the dir variable will not be sorted, but presented in the same order that the operating system returned them 
        
        nos = length(i_data);  % number of samples for each individual 
        % ALL individuals MUST have the same number of samples (named sequentially, starting from 1)
        
        for j = 1:nos                        
            img = strcat(i_path,i_data(j).name);    % Create the path for the jth_image from the ith_individual
            processed = preprocess(img, dims_img);  % Pass the jth_image path to preprocess, to perform the preprocessing operation on it 
            flattened = processed(:);               % Flatten the preprocessed image in a one column matrix (vector)
            X = [X flattened];                      % Add the flattened jth_image to the individual data container
            Y = [Y ID];                             % Specify and add the label of the jth_image using the individual ID
        end
        
        % After done reading all the samples of an individual...
        ds_data = [ds_data X];      % add the individual's vectors (matrix) of images to the (cell) dataset images contrainer
        ds_labels = [ds_labels Y];  % add the individual's vectors (matrix) of labels to the (cell) dataset labels contrainer
        % We are using the cell structure for the dataset containers, because that will help us keep individual matrices separated
        
        X = [];  % Clear the current individual data container, and prepare it for the next individual
        Y = [];  % Clear the current individual labels container, and prepare it for the next individual
    end    
    
    % After done reading all the samples of all the individuals...
    % Now we have all individuals' images in the dataset images container (ds_data)
    % Also, we have all individuals' labels in the dataset labels container (ds_labels)
    
    [tr_set, ts_set] = split(ds_data, ds_labels, ts_size);  % Split the dataset into training set & testing set
    
    % Shuffling (we only shuffle the training set, becuase we need our model to as general as possible)
    shuffler = 'o';  % Specify the shuffling type (r for "randomized shuffle", & o for "ordered or uniformed" shuffle) 
    
    if shuffler == 'r'      
        [tr_X, tr_y] = r_shuf(tr_set);  % Perform shuffling using "randomized shuffle"
    elseif shuffler == 'o'              
        [tr_X, tr_y] = o_shuf(tr_set);  % Perform shuffling using "uniformed shuffle" 
    end
        
    % Reshape 
    tr_X = reshape(tr_X, dims_img(1), dims_img(2), []);  % Reshape training set images from being vectors to be of the specified dimensions
        
    ts_X = cell2mat(ts_set{1});
    ts_y = cell2mat(ts_set{2});
    ts_X = reshape(ts_X, dims_img(1), dims_img(2), []);  % Reshape testing set images from being vectors to be of the specified dimensions 
        
    tr_set = {tr_X, tr_y};  % Store the training set labels and its reshaped data in one variable
    ts_set = {ts_X, ts_y};  % Store the testing set labels and its reshaped data in one variable
end

