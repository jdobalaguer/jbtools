
function scan = scan_ppi_pooling(scan)
    %% scan = SCAN_PPI_POOLING(scan)
    % pool the seed timecourse if required
    
    %% warnings
    %#ok<*AGROW>
    
    %% function
    if ~scan.ppi.do.seed, return; end
    if ~scan.glm.pooling, return; end
    
    scan.ppi.variables.vols_p = {};
    for i_subject = 1:length(scan.ppi.variables.final)
        scan.ppi.variables.vols_p{i_subject} = {};
        t_vols = [];
        scan.ppi.variables.vols_p{i_subject} = {};
        for i_session = 1:length(scan.ppi.variables.final{i_subject})
            t_vols = [t_vols , scan.ppi.variables.final{i_subject}{i_session}];
        end
        scan.ppi.variables.vols_p{i_subject}{1} = t_vols;
    end
    
    scan.ppi.variables.final = scan.ppi.variables.vols_p;
    
    % save
    save([scan.dire.glm.root,'scan.mat'],'scan');
end
