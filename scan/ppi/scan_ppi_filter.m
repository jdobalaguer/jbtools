
function scan = scan_ppi_filter(scan)
    %% SCAN_PPI_FILTER()
    % high-pass filter for PPI
    % see also scan_ppi_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*FPARK,*NASGU>
    
    %% FUNCTION
    if ~scan.ppi.do.seed, return; end
    
    scan.ppi.variables.vols_f = {};
    for i_subject = 1:length(scan.ppi.variables.final)
        scan.ppi.variables.vols_f{i_subject} = {};
        for i_session = 1:length(scan.ppi.variables.final{i_subject})
            
            subject = scan.subject.u(i_subject);

            % load high-pass filter
            SPM = load(sprintf('%ssub_%02i/SPM.mat',scan.dire.glm.firstlevel,subject),'SPM');
            SPM = SPM.SPM;
            K = SPM.xX.K(i_session);
            K.row = 1:length(K.row);

            % concatenate
            vols = scan.ppi.variables.final{i_subject}{i_session}';

            % apply
            vols = spm_filter(K, vols);
            scan.ppi.variables.vols_f{i_subject}{i_session} = vols;
        end
    end
    
    scan.ppi.variables.final = scan.ppi.variables.vols_f;
    
    % save
    save([scan.dire.glm.root,'scan.mat'],'scan');
    
end
