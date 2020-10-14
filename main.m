function main()
    clear;
    clc;

    noi = 4;               % number of individual (classes)
    ds_path = 'dataset1';   % dataset path
    dims_img = [86 200];    % required dimenstions for the dataset images 
    codec = 'png';          % dataset images codec

    ts_size = 0.2;          % training and testing persent

    n_cf = 20;              % number of convolution filters
    dims_cf = [3 3];        % dimentions of the convolution filters
    n_pf = 20;              % number of pooling filters
    dims_pf = [2 2];        % dimentions of the pooling filters
    h_nodes = 100;          % number of neurons in the hidden layer 

    % Load the dataset
    [train_set, test_set] = loader(noi, ds_path, dims_img, codec, ts_size);  

    % Initialize the network weights
    W = w_init(dims_img, n_cf, dims_cf, n_pf, dims_pf, h_nodes, noi);  

    % Training Phase
    epochs = 4;
    W = train(W, train_set, epochs, noi);  

    % Testing Phase
    WTemp = W;
    accuracy = test(W, test_set);  
    fprintf('\n\nTesting accuracy = %.2f %% \n', accuracy);
end
