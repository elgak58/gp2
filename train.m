function W = train(W, train_set, epochs, noi)
    
    [X, y] = deal(cell2mat(train_set(1)), cell2mat(train_set(2)));  % Extract all individuals training images and labels 
    
    fprintf('Epoch No.:');
    for epoch = 1:epochs    
        fprintf([' ' int2str(epoch) ',']);

        tr_size = length(y);                                    % Training set size (number of training samples of all the individuals)
        batch_size = 10;                                        % Number of samples to be used to updated the Weight-sets each iteration in each epoch
        batch_list = 1:batch_size:(tr_size - batch_size + 1);   % List contains all the batches beginigs (the begining index of each batch)
        nob = length(batch_list);                               % Number of batches based on the (training set size) & (batch_size)
        
        for batch = 1:nob
                       
            dW = {zeros(size(cell2mat(W(1)))), zeros(size(cell2mat(W(2)))), zeros(size(cell2mat(W(3))))};   % Initialize the gradient matrices
            
            begin = batch_list( batch );                                % Retrieve the begining (the first) index in a batch
            for k = begin:begin+batch_size-1                            % k is the index of the current element in a batch   
                img = X(:, :, k);                                       % One sample of the training set
                [A, pooled, fpooled] = f_prop(img, W);                  % Forward Propagation
                dW = b_prop(img, W, dW, A, pooled, fpooled, y(k), noi); % Back Propagation
            end
            W = w_adj(W, dW, batch_size);   % Update the network weights (once after each batch)   
        end
    end
    
    % Batching Clarification
    
    % trs = 80
    % bs = 10
    % 
    % since ... "bl = (1: bs: trs-bs+1)"
    % which is ... "bl = 1:10:71"
    % bl = [01, 11, 21, 31, 41, 51, 61, 71]
    % 
    % since ... "b = 1:len(bl)"
    % which is ... "b = 1:8"
    % batch = {1, 2, 3, ===> 8}
    % 
    % 	since ... "begin = bl(b)"
    % 	which is ... "begin = bl( {1, 2, 3 --> 8} )"
    % 	begin = {01, 11, 21, ===> 71}
    % 
    % 		since ... "k = begin: begin+bs-1"
    % 		which is ... "k = {01: 01+10-1, 11: 11+10-1, 21: 21+10-1 ===> 71: 71+10-1}"
    % 		k = {
    % 			[begin index]	[begin value]	[end index]	[end clarification] 
    % 			[1] 		01 		10 		(01 + 10 - 1)
    % 			[2] 		11		20 		(11 + 10 - 1)
    % 			[3] 		21		30 		(21 + 10 - 1)
    % 			...		...		...		...
    % 			[8] 		71		80 		(71 + 10 - 1)
    % 		}
    
end
        
    