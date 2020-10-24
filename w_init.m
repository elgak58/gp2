function W = w_init(dims_img, n_cf, dims_cf, n_pf, dims_pf, h_nodes, o_nodes)
    
    % dims_img: Dimentions of the original images
    % n_cf    : Number of convolution filters
    % dims_cf : Dimentions of the convolution filters
    % n_pf    : Number of pooling filters
    % dims_pf : Dimentions of the pooling filters
    % h_nodes : Number of neurons in the hidden layer
    % o_nodes : Number of classes in the output layer
    
    dims_cimg = dims_img - dims_cf + 1;             % the dimentions of the convolved image (filtered image)
    dims_pimg = dims_cimg / mean(dims_pf);          % the dimentions of the pooled image
    i_nodes = dims_pimg(1) * dims_pimg(2) * n_pf;   % the size of the input vector (flattened pooled images)
    % input vector size = pooled image width * pooled image hight * number of pooled images 
         
    % Xavier weights initialization technique is ===> W = random(CL, PL) * sqrt( 2/(PL + CL) )  
    % Where ===> "CL: is the size of the current layer, AND PL is the size of the previous layer

    % Static Example    
    % W0 = 1e-1*randn([3 3 20]);
    % W1 = (2 * rand(100, 83160) - 1) * sqrt(2) / sqrt(100 + 83160);
    % W2 = (2 * rand(4, 100) - 1) * sqrt(2) / sqrt(4 + 100);

    % Weight Initialization (using Xavier initialization technique)
    W0 = 1e-1 * randn([dims_cf n_cf]);
    W1 = (2 * rand(h_nodes, i_nodes) - 1) * sqrt(2) / sqrt(h_nodes + i_nodes);
    W2 = (2 * rand(o_nodes, h_nodes) - 1) * sqrt(2) / sqrt(o_nodes + h_nodes);
    
    W = {W0, W1, W2};
    
end