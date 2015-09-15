
function obj = control_load_background(obj)
    %% obj = CONTROL_LOAD_BACKGROUND(obj,s)
    
    %% function
    disp('control_load_background');
    
    % get files
    tt = struct_rm(obj.scan.file.template,'tpm');
    tn = fieldnames(tt);
    u_file = mat2vec(struct2cell(tt));
    n_file = length(u_file);
    
    % load templates
    [v,s,t,~,~] = aux_loadNII(u_file);
    v = cellfun(@(v,s)reshape(v,s),v,s,'UniformOutput',false);
    v = cellfun(@single,v,'UniformOutput',false);
    
    % coordinates
    c = cellfun(@aux_MNIcoordinates,s,t,'UniformOutput',false);
    
    % save volumes
    obj.dat.background = struct('file',u_file,'name',tn,'data',v,'size',s,'matrix',t,'mni',c);
end
