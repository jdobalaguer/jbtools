
function [scan,rdm] = scan_rsa_searchlight_loadRDM(scan)
    %% [scan,rdm] = SCAN_RSA_SEARCHLIGHT_LOADRDM(scan)
    % Load pre-computed RDMs
    % to list main functions, try
    %   >> help scan;
    
    %% function
    rdm = cellfun(@(x)cell(1,numel(x)),scan.running.subject.session,'UniformOutput',false);
    
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.estimation, return; end
    if isempty(scan.job.loadRDM), return; end
    
    % load RDMs
    scan_tool_print(scan,false,'\nLoading RDMs : ');
    scan = scan_tool_progress(scan,1);
    rdm = file_loadvar(scan.job.loadRDM,'value');
    scan = scan_tool_progress(scan,0);

    % done
    scan = scan_tool_done(scan);
end
