
function obj = new_load_template(obj)
    %% obj = NEW_LOAD_TEMPLATE(obj,s)

    %% function
    disp('new_load_template');
    
    % return
    if any(isnan(obj.dat.size))
        obj.dat.templates = struct('name',{},'volume',{});
        return;
    end
    
    % load templates
    tt = struct_rm(obj.dat.scan.file.template,'tpm');
    tn = fieldnames(tt);
    [tv,ts] = scan_nifti_load(struct2cell(tt));
    
    % resize templates
    tv = cellfun(@(v,s)reshape(v,s),tv,ts,'UniformOutput',false);
    tv = cellfun(@(v)resample(v,obj.dat.size),tv,'UniformOutput',false);
    
    % save templates
    obj.dat.templates = struct('name',tn,'volume',tv);
end

%% auxiliar (resample templates)
function n = resample(t,z)
    % resample template [t] to size [z]
    s = size(t); ... original size
    r = s ./ z; ... resolution
    fx = floor(1:r(1):s(1)); ... floor voxels
    fy = floor(1:r(2):s(2));
    fz = floor(1:r(3):s(3));
    cx =  ceil(1:r(1):s(1)); ... ceil voxels
    cy =  ceil(1:r(2):s(2));
    cz =  ceil(1:r(3):s(3));
    n  = .125 * (t(fx,fy,fz) + t(fx,fy,cz) + t(fx,cy,fz) + t(fx,cy,cz) + t(cx,fy,fz) + t(cx,fy,cz) + t(cx,cy,fz) + t(cx,cy,cz)); ... average of the 8 corners
end