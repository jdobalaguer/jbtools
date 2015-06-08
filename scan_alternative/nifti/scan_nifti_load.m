
function [vol,siz] = scan_nifti_load(file,mask)
    %% [vol,siz] = SCAN_NIFTI_LOAD(file[,mask])
    % load volumes
    % file : a string, or a cell of strings
    % mask : an array
    % vol  : a volume, or a cell of volumes (vector shaped)
    % siz  : a matrix with the shape of the volumes, or cell of matrices
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % mask
    func_default('mask',[]);
    
    if ischar(file)
        % load single file
        vol = spm_vol(file);
        siz = size(vol.private.dat);
        vol = double(vol.private.dat(:));
        vol(~mask(:)) = [];
        
    else
        % load many volumes
        assert(iscellstr(file),'scan_nifti_load: error. file must be a string or a cell of strings');
        if isempty(mask)
            vol = cell(size(file));
            siz = cell(size(file));
            for i = 1:numel(file)
                [vol{i},siz{i}] = scan_nifti_load(file{i},[]);
            end
        else
            [x,y,z] = ind2sub(size(mask),find(mask>0));
            vol = spm_get_data(file,[x,y,z]')';
            vol = mat2vec(num2cell(vol,1));
            siz = repmat({[nan,nan,nan]},size(vol));
        end
    end

end