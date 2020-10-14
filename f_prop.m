function [A, p, fp] = f_prop(I, W)

        [W0, W1, W2] = deal(cell2mat(W(1)), cell2mat(W(2)), cell2mat(W(3)));
        
        z0 = conv(I, W0);       % z0: is the filtered images (matrix contains all the filtered images corresponding to the input image)
        a0 = relu(z0);          % a0: the activation ouput of the convolution layer (matrix contains all the activated filtered images corresponding to the input image)
        p  = pool(a0);          % p(pooled): matrix contains all the 20 pooled images corresponding to the 20 filtered activated input images
        fp = reshape(p, [], 1);	% fp(flattened): vector contains all the 20 pooled images in 1 column
        z1 = W1 * fp;           % z1: first weighted-sum resulted from multiplying the ANN input (flattened) by Weight-set 1 (W1)
        a1 = relu(z1);          % a1: the activated output of the hidden layer
        z2 = W2 * a1;           % z2: second weighted-sum resulted from multiplying the activated output from the previous layer (a1) by Weight-set 2 (W2)
        a2 = softmax(z2);       % a2: the network prediction, which is output that the network produced
        
        A = {a0, a1, a2};        
    
end