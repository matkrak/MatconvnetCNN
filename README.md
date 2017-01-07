# MatconvnetCNN

Lots of my project nowadays are connected with Machine Learning.
In this one I am using Matconvnet


https://github.com/vlfeat/matconvnet

which is a freamework that allows one to train convolutional neural networks
in Matlab.

### Quick info

What I did in fact is: I changed m-files from 
`<matconvnet>/examples/mnist/`
so that now different nets performs binary classification.
<br>
<br>
No data has been provided here on github.

### If you want to do binary classification of your own data:

1. Prepare data
  1. Gather the data into one directory
  2. Prepare file with labels (txt, csv, whatever)
2. Set parameters of `PrepareData.m` function (for now inside script)
  1. Set pathes
  2. Set image resolution and number of channels (to_gray = 0 makes RGB, =1 - grayscale)
3. Set network architecture in `cnn_init.m` script
  1. Meta parameters: set input size to chosen
  2. change net architecture
  3. run this script
  4. `vl_simplenn_display(ans)` in matlab console to see the architecture (data size)*
4. Train with cnn.m script or use show_results.m script!

\* output from the last conv layer (and input for softmax) should have data size: 1 (one number), data depth: 2 (two clases)


### Other files
For now there is:
* onetorulethemall.m - simple script I am using to run different configurations (sometimes one net can be trained a coule hours)
* gatherinfo.m - another script I am using to move data between my PC and a remote AGH PC when I am performing computations.
