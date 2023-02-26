# Wide-field-calcium-imaging
MATLAB codes for image processing, including downsampling, calculating df/f, image registration, and PCA/ICA.
See ref Makino et al., Neuron, 2017

How to analyze raw imaging data (tiff file) by NY
General notes
Imaging data is hierarchical: animal - session - block.
Each animal is interpreted as an individual, a session as a day of imaging, and a block as one behavioral trial (from the start of the task to the end).
All specific parameters you have to change (except as noted) are summerized in the section at the top of each live editor file.

Analysis procedure
0) Put raw imaging data (tiff file) and specify tiff_path
It must be organized as, Ex.) 'Users\...\Wide-field-calcium-imaging\230121\KM_Tlx46'  
Wide-field-calcium-imaging folder must include all the MATLAB codes.
Multiple multi-tiff files can be included in the 'Initial_Animal' folder for multiple blocks (trials).
1) Run Downsample\CR_DownsamplePixel.mlx 
2) Run Get_dfof\CR_Get_df_f.mlx
Make sure to change frameRate parameter both in CR_Get_df_f.mlx and CR_DFOF.m
3) Run Image_Registration\CR_Registration.mlx
Add Image Processing Toolbox if not installed
4) Run WarpedTiff\Make_masked_image.mlx
Adjust threshold parameter in middle of the code until masked image capture imaging region.
5) Open Tiff Averaged image in WarpedTiff\ using ImageJ and identify the coordinate of Bregma.
6) Run Get_dfof\CR_ApplyWarpMatrix.mlx
Make sure to specify pixel parameter both in CR_ApplyWarpMatrix.mlx and AlignWithBregma.m
Specify bregma coordinate of each animals obtained in 5)
7) Run PCA_and_ICA\CR_ICA_onEventEpochs_allSessions.mlx
Add Statistics and Machine Learning Toolbox if not installed
Manually select the components to be used for reconstruction from the ICA output (blue heat map).
8) Run PCA_and_ICA\Choose_componet.mlx
9) Run PCA_and_ICA\CR_Reconstruction.mlx
10) Run PCA_and_ICA\plot_RecICA.mlx
Set clims parameter in middle of the code using the result of max(max(RecICA_Temp{1}))

Plot neural activity aligned by behavioral bouts
0) Make sure analysis procedures mentioned above have already been run.
1) Prepare csv file which contains behavior timepoints information.
Template of behavior timepoints can be found in Research Tools folder in Teams.
Make sure csv file is located in the folder below.
[working_directory Date filesep Initial '_' Animal filesep 'BehaviorRecord.csv']
2) Run Get_dfof\plot_neural_activity.mlx
In the top of each code block there are parameters you have to change.
Plotted figures will be outputted to folder below.
[working_directory Date filesep Initial '_' Animal filesep 'neural_act_outputs' filesep]
Currently only at the start of lifting the hand you can align neural activity, but you can extend in a similar way.
plot aligned neural activity of each trial (line + heatmap)
•	Specify brain ROI you want to visualize neural activity based on brain image outputted as RecICA_lift_{Block}.png
•	ImageJ can be used to specify ROI position on image. 
(In this case, you should make ‘y_reverse’ as 1.)
•	Name each brain ROI.
•	Specify how many pixel you expand and take average to show population activity. 
(Already image has been down sampled to 128*128 pixels.)
•	Adjust 'ylimit’ and ‘climit’ based on calcium intensity.
plot activity correlation of each brain region
Output tiff images from matrix for visualization
•	Adjust ‘clims’ based on calcium intensity.
you can check max calcium intensity by the code below.
max(max(RecICA_lift{Block}))
plot neural activity sequence averaged by specific timebin
•	Specify how many milliseconds before and after the event to plot and how many milliseconds between plots using parameter ‘before’ , ‘after’ and ‘inter’.
•	Adjust ‘clims’ based on calcium intensity.
you can check max calcium intensity by the code below.
max(max(mean_RecICA_lift))
plot neural activity averaged by specific behavior
•	Currently events cannot be changed.

