function dW = b_prop(I, W, dW, A, pooled, fpooled, y, noi)

        [ W0,  W1,  W2] = deal( cell2mat(W(1)),  cell2mat(W(2)),  cell2mat(W(3)));  % Extract weight matrices
        [dW0, dW1, dW2] = deal(cell2mat(dW(1)), cell2mat(dW(2)), cell2mat(dW(3)));  % Extract gradient matrices
        [ a0,  a1,  a2] = deal( cell2mat(A(1)),  cell2mat(A(2)),  cell2mat(A(3)));  % Extract forward propagation activation ouputs
        
        p = a2;                             % The activation output "a2" is the network prediction
        d = zeros(noi, 1);                  % d(desired) is a zero vector contains m number of rows (each row indicates a class)
        dc_ind = sub2ind(size(d), y, 1);    % the desirted class index. sub2ind(size,row,col) returns an index
        d(dc_ind) = 1;                      % Replace "0 value" in the row element that corresponds to the desirted class with "1 value"

        % Error calculation between (Output-Layer) & (Hidden-Layer)        
        L5_err  = d - p;  % prediction error (calculating 5th layer error (FCL output-layer))
        delta_2 = L5_err; % error value of the output layer (5th layer)
        
              
        L4_err = W2' * delta_2;             % "delta" propagates backwards (calculating 4th layer error (FCL hidden-layer) )
        delta_1  = (a1 > 0) .* L4_err;      % Matrix contains error values of the hidden layer (4th layer)
            
        % Error calculation between (Hidden-Layer) and (Input-Layer)
        L3_err = W1' * delta_1;             % "delta" continue propagates backwards (calculating 3rd layer error (FCL input-layer) )                
                
        L2 = reshape(L3_err, size(pooled));	% Reshape 3rd layer error matrix (that is a vector) to the shape of pooled, which is [42 99 20] in this case
        %L2 is the 3rd layer error but reshaped. Note that the 2nd layer (pooling-layer) has not error values (because it has no weights)
        
        % Reverse pooling
        p_filter = ones(size(a0)) / (2*2);  % Pooling layer filter (average pooling)
        unpooled = zeros(size(a0));         % Matrix will contain unpooled images (produced by reversing pooling operation), using kron function
        for count = 1:20                    % 20 because we have 20 pooled images
            unpooled(:, :, count) = kron(L2(:, :, count), ones([2 2])) .* p_filter(:, :, count);
        end
        % Explanation:
        % Pass to kron function ===> "L2" (3rd layer error reshaped) & ===> 2x2 ones matrix (2x2 is the pooling filter size)        
        % That will produce a new matrix of size 2 times the original one (So [42 99 20] will be [84 198 20])       
        % Each element in the original matrix will have 4 duplicates in shape of 2x2 (e. g. [1] will have [1, 1; 1, 1])                
        % Now, each element in the new matrix will be multiplied - elementwise - by "p_filter" (the average pooling filter)        
        
        delta_temp = (a0 > 0) .* unpooled;  % Matrix contains error values of the 3rd layer (reshaped & unpooled)
        % delta_temp will be used to calculate delta_0. Note That, pooling layer has neighter error values nor weights to update 
        
        % Reverse colvolution        
        delta_0 = zeros(size(W0));          % Matrix will contain unconvolved images (produced by reversing convolution operation), using conv2 function
        for count = 1:20                    % 20 because we have 20 filtered images
            delta_0(:, :, count) = conv2(I(:, :), rot90(delta_temp(:, :, count), 2), 'valid');
        end
        % Explanation:
        % ???
        
        dW0 = dW0 + delta_0;            % the gradient with respect to each weight in W0 ???
        dW1 = dW1 + delta_1 * fpooled';	% the gradient with respect to each weight in W1 ???
        dW2 = dW2 + delta_2 * a1';      % the gradient with respect to each weight in W2 ???
        dW = {dW0, dW1, dW2};
end