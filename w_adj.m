function W = w_adj(W, dW, batch_size)
    
    alpha = 0.01;  % step size (a.k.a. learning rate)
    beta = 0.95;  % part of the "SGD with Momentum" optimizer

    [W0, W1, W2] = deal(cell2mat(W(1)), cell2mat(W(2)), cell2mat(W(3)));
    [dW0, dW1, dW2] = deal(cell2mat(dW(1)), cell2mat(dW(2)), cell2mat(dW(3)));
    [V0, V1, V2] = deal(zeros(size(W0)), zeros(size(W1)), zeros(size(W2))); % Velocity or Momentum for Weights sets
    
    dW0 = dW0 / batch_size;
    dW1 = dW1 / batch_size;
    dW2 = dW2 / batch_size;
    
    V0 = alpha * dW0 + beta * V0;
    W0 = W0 + V0;
    
    V1 = alpha * dW1 + beta * V1;
    W1 = W1 + V1;
    
    V2 = alpha * dW2 + beta * V2;
    W2 = W2 + V2;
    
    W = {W0, W1, W2};
    
end