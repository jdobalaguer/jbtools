
function obj = new_load_volumes(obj)
    %% obj = NEW_LOAD(obj)

    %% function
    disp('new_load');
    
    % variables
    u_file = obj.dat.file;
    
    % return
    if isempty(u_file)
        obj.dat.volumes   = {};
        obj.dat.size      = [nan,nan,nan];
        return;
    end
    
    % load volumes
    [v,s,m,d] = nifti_load(u_file);
    scan_tool_assert(obj.dat.scan,isequal(s{:}),'one or more volumes do not have the same size');
    s = s{1};
    if isequal(m{:}), m = m{1}; else m = ''; end
    if isequal(d{:}), d = d{1}; else d = nan; end
    v = cellfun(@(v)reshape(v,s),v,'UniformOutput',false);
    v = cellfun(@single,v,'UniformOutput',false);
    
    % save volumes
    obj.dat.volumes   = v;
    obj.dat.size      = s;
    obj.dat.map       = m;
    obj.dat.df        = d;
end

%% auxiliar
function [v,s,m,d] = nifti_load(file)
    % load single file
    if ischar(file)
        h = spm_vol(file);
        v = double(h.private.dat(:));
        s = h.dim;
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
        m = cell(size(file));
        d = cell(size(file));
        for i = 1:numel(file)
            [v{i},s{i},m{i},d{i}] = nifti_load(file{i});
        end
    end
end