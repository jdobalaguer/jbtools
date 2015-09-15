
function [v,s,t,m,d] = aux_loadNII(file)
    %% [v,s,t,m,d] = AUX_LOADNII(file)
    % load NIfTI files with extra header information
    
    %% function
    disp('aux_loadNII');
    
    % load single file
    if ischar(file)
        h = spm_vol(file);
        v = double(h.private.dat(:));
        s = h.dim;
        t = h.mat;
        r = regexp(h.descrip,'SPM{(.*)_\[(.*)\]}.*','tokens');
        if isempty(r)
            m = '';
            d = nan;
        else
            m = r{1}{1};
            d = str2double(r{1}{2});
        end
    % load many volumes
    else
        % recursive call
        v = cell(size(file));
        s = cell(size(file));
        t = cell(size(file));
        m = cell(size(file));
        d = cell(size(file));
        for i = 1:numel(file)
            [v{i},s{i},t{i},m{i},d{i}] = aux_loadNII(file{i});
        end
    end
end
