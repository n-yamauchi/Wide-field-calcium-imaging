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
Ex.) 'Wide-field-calcium-imaging\' Date filesep Initial '_' Animal
1) Run Downsample\CR_DownsamplePixel.mlx 
2) Run Get_dfof\CR_Get_df_f.mlx
Make sure to change frameRate parameter both in CR_Get_df_f.mlx and CR_DFOF.m
3) Run Image_Registration\CR_Registration.mlx
4) Run WarpedTiff\Make_masked_image.mlx
Adjust threshold parameter in middle of the code until masked image capture imaging region.
5) Open Tiff Averaged image in WarpedTiff\ using ImageJ and identify the coordinate of Bregma.
6) Run Get_dfof\CR_ApplyWarpMatrix.mlx
Make sure to specify pixel parameter both in CR_ApplyWarpMatrix.mlx and AlignWithBregma.m
Specify bregma coordinate of each animals obtained in 5)
7) Run PCA_and_ICA\CR_ICA_onEventEpochs_allSessions.mlx
Manually select the components to be used for reconstruction from the ICA output (blue heat map).
8) Run PCA_and_ICA\Choose_componet.mlx
9) Run PCA_and_ICA\CR_Reconstruction.mlx
10) Run PCA_and_ICA\plot_RecICA.mlx
Set clims parameter in middle of the code using the result of max(max(RecICA_Temp{1}))
