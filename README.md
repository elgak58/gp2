# Index

## This file contains:
1. Structure of Execution
2. Functions Explanation
3. How To Execute this in MATLAB

### 1. Structure of Execution
This folder contains 16 MATLAB (.m) files  
The files are executed in the following order.  
*Note that: the indentation defines the hierarchy*
``` 
1.  main.m
|______	2.  loader.m
|	|______	3.  preprocess.m
|	|______	4.  split.m
|	|______	5.  r_shuf.m   OR   6.  o_shuf.m
|
|______	7.  w_init
|______	8.  train
|	|______	9.  f_prop.m
|	|	|______	10.  conv.m
|	|	|______	11.  relu.m
|	|	|______	12.  pool.m
|	|	|______	13.  softmax.m
|	|
|	|______	14.  b_prop.m
|	|______	15.  w_adj.m
|
|______	16.  test
	|______	09.  f_prop.m
		|______	10.  conv.m
		|______	11.  relu.m
		|______	12.  pool.m
		|______	13.  softmax.m
```

### 2. Functions Explanation
```
1.  main.m --------> the starting point, where the user can control and specify the required training configurations
2.  loader.m ------> responsible for loading the dataset, preprocess it, split it into training & testing sets, and finally performing the shuffling
3.  preprocess.m --> performs the preprocessing operations, which are Grayscaling, Inversion, Resized, Thresholding (optional), and Normalization
4.  split.m -------> splits the passed dataset into a training set and a testing set according to the splitting percentage that specified by the user
5.  r_shuf.m ------> performs randomized shuffling
6.  o_shuf.m ------> performs ordered shuffling
7.  w_init --------> initialize the weights of the network
8.  train ---------> the training phase that includes forward-propagation & back-propagation
9.  f_prop.m ------> forward-propagation, where an image data will propagate forward though-out the model structure until getting the network prediction
10. conv.m --------> performs convolution operations 
11. relu.m --------> the activation function of the convolution layer, and the hidden layer (of the FCL)
12. pool.m --------> performs pooling operations 
13. softmax.m -----> the activation function of the output layer (of the FCL)
14. b_prop.m ------> back-propagation, where the network prediction will be used to calculate the error that in turn will be used to optimize the weights of the network
15. w_adj.m -------> optimize the weights of the network based on the calculated error and some other parameters such as the learning rate
16. test ----------> the testing phase that takes the passed dataset and calculates the prediction accuracy (how the model performs with that particular dataset)
```

### 3. How To Execute this in MATLAB
#### Usage Notes:
1. The code has been structured in such a way so that the user can easily use it 
2. The only file that the user should engage with is the main.m file
3. In the main.m file, the user needs to specify the path of the dataset folder, and the number of individuals to differentiate between
4. We have 4 datasets that structured in a convenient way 
5. In case you want to use one of these 4 datasets we already have, all you need is to specify the path the dataset you wish to use 
   along with the number of individuals in that dataset
6. In case you want to use your own dataset, note that the dataset folder MUST ...
   contain individuals folders (where each individual folder is labeled as a number starting from 1) ...
   and all individuals MUST have the same number of signature samples
7. In the main.m file the user can also specify the required training configuration 
8. After the required configurations have been specified, the user basically need to run this main.m file 




