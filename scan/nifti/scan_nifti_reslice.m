
function new = scan_nifti_reslice(vol,ref,interp)
    %% new = SCAN_NIFTI_RESLICE(vol,ref,interp)
    % reslice a volume to a different coordinates system
    % vol    : volume to reslice (output of @spm_vol)
    % ref    : reference volume (output of @spm_vol)
    % interp : method of interpolation (number 0-7, or a string in {'nearest','trilinear','bspline2',bspline3',..}. default 'bspline4')
    % new    : new matrix of the volume resliced, in the coordinate system of [ref]
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % based on @spm_reslice/reslice_images
    % based on @spm_reslice/getmask
    
    %% notes
    % if [vol.fname] is not an existing file, it creates a temprary one in the cwd

    %% function
    
    % spm defaults
    func_default('interp','trilinear');
    
    switch interp
        case 'nearest',  interp = 0;
        case 'trilinear',interp = 1;
        case 'bspline2', interp = 2;
        case 'bspline3', interp = 3;
        case 'bspline4', interp = 4;
        case 'bspline5', interp = 5;
        case 'bspline6', interp = 6;
        case 'bspline7', interp = 7;
    end
    
    % write to temporary file
    file = '';
    if isempty(vol.fname) || isempty(file_match(vol.fname))
        file = fullfile(pwd(),sprintf('.reslice_%05i.nii',randi(1e5)-1));
        if ~isempty(file_match(file)), cprintf('red','you are really unlucky. try again for a better chance!\n'); new = []; return; end
        vol.fname = file;
        scan_nifti_save(file,double(vol.private.dat),vol);
    end
    
    % values
    d = [interp*[1 1 1]' [0;0;0]];
    C = spm_bsplinc(vol, d);
    
    % delete temporary file
    file_delete(file);
    
    % reslice
    new = zeros(ref.dim);
    [x1,x2] = ndgrid(1:ref.dim(1),1:ref.dim(2));
    for x3 = 1:ref.dim(3)
        M = inv(ref.mat\vol.mat);
        y1   = M(1,1)*x1+M(1,2)*x2+(M(1,3)*x3+M(1,4));
        y2   = M(2,1)*x1+M(2,2)*x2+(M(2,3)*x3+M(2,4));
        y3   = M(3,1)*x1+M(3,2)*x2+(M(3,3)*x3+M(3,4));
        new(:,:,x3)  = spm_bsplins(C, y1,y2,y3, d);
    end
    
end
