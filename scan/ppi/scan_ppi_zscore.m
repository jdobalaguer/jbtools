
function scan = scan_ppi_zscore(scan)
    %% scan = SCAN_PPI_ZSCORE(scan)
    % zscore the physiological signal (per session)
    
    %% warnings
    
    %% function
    if ~scan.ppi.do.regression, return; end
    
    scan.ppi.variables.vols_z = {};
    for i_subject = 1:length(scan.ppi.variables.final)
        scan.ppi.variables.vols_z{i_subject} = {};
        for i_session = 1:length(scan.ppi.variables.final{i_subject})
            scan.ppi.variables.vols_z{i_subject}{i_session} = zscore(scan.ppi.variables.final{i_subject}{i_session});
        end
    end
    
    scan.ppi.variables.final = scan.ppi.variables.vols_z;
    
end
