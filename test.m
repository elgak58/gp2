function accuracy = test(W, test_set)
    
    [X, y] = deal(cell2mat(test_set(1)), cell2mat(test_set(2)));  % Extract all individuals testing images and labels 
    
    nocp = 0;               % Number of correct predictions
    ts_size = length(y);	% Testing set size (number of testing samples of all the individuals)

    for k = 1:ts_size
        img = X(:, :, k);           % One sample of the testing set
        [A, ~, ~] = f_prop(img, W);	% Forward Propagation
        p = cell2mat(A(3));         % Network Prediction (for each class)               
        
        % Accuracy calculation
        [~, predicted] = max(p);    % Check for the maximum (highest prediction) value among the classes 
        if predicted == y(k)        % IF the highest prediction equals the label for that image ...
            nocp = nocp + 1;        % THEN incremented the number of correct predictions
        end
    end
    accuracy = (nocp / ts_size)*100;    
end