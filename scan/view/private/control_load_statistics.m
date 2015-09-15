
function obj = control_load_statistics(obj)
    %% obj = CONTROL_LOAD_STATISTICS(obj)

    %% notes
    % 1. we load the default volumes at the beginning because we need to check the map type
    %    (this is to set the default value in the map popup)
    
    %% function
    disp('control_load_volumes');
    
    % variables
    u_file = {obj.dat.statistics.file};
    
    % return
    if isempty(u_file)
        obj.dat.volumes   = {};
        obj.dat.size      = [nan,nan,nan];
        return;
    end
    
    % load volumes
    [v,s,t,m,d] = aux_loadNII(u_file);
    v = cellfun(@(v,s)reshape(v,s),v,s,'UniformOutput',false);
    v = cellfun(@single,v,'UniformOutput',false);
    
    % coordinates
    c = cellfun(@aux_MNIcoordinates,s,t,'UniformOutput',false);
    
    % save volumes
    obj.dat.statistics = struct('file',u_file,'data',v,'size',s,'matrix',t,'mni',c,'map',m,'df',d);
end
