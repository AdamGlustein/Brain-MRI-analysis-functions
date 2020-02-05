% some useful functions for BRATS MRI data analysis
M = img_to_matrix("BraTS19_2013_12_1_t1ce.nii.gz");
subplot(2,1,1);
voxel_histogram(M,1,1);
hold on
subplot(2,1,2);
mean_color_map(M,1);

function f = img_to_matrix(file_name);
    % converts file name given in string (.nii.gz) to 3D-array of voxels
    f = niftiread(file_name);
end

function f = voxel_histogram(img_matrix, normalize, logarithmic);
    % plots a zero-to-one normalized histogram of an MRI file. 
    % Can declare second input parameter as 1 to normalize image 
    % Can declare third input parameter as 1 to make y-scale logarithmic
    vox_list = img_matrix(:,:,:);
    if normalize;        
        vox_list = mat2gray(vox_list);
    end
    histogram(vox_list);
    title("Voxel Histogram");
    if logarithmic;
        set(gca, 'YScale', 'log');
    end
end 

function f = mean_color_map(img_matrix, direction);
    % produces a color map of the average cross-sectional voxel values in a
    % given direction. Second paramteter alters cross-sectional plane (1 =
    % axial, 2 = sagittal, 3 = coronal).
    
    % Axial plane (1) means moving down the brain vertically, looking
    % at horizontal planes. Sagittal plane (2) means moving laterally
    % across brain and viewing the vertical cross-sections. Coronal plane
    % (3) means moving into the brain from the forehead and viewing
    % vertical plane.
    slices = [];
    if direction == 1;
        slices = sum(img_matrix,3)/240;
    elseif direction == 2;
        slices = sum(img_matrix,2)/240;
    elseif direction == 3;
       slices = sum(img_matrix)/155;
    end
    imagesc(squeeze(slices));
    
end

function f = normalize_voxels(img_matrix);
    % runs 0 to 1 normalizatino on an MRI image
    f = mat2gray(img_matrix);
end

function f = histogram_equalization(img_matrix);
    % runs histogram equalization on voxels, which can greatly increase
    % contrast sometimes
    f = histeq(img_matrix);
end


    