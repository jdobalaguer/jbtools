
function scan = scan_glm_regressor_outKF(scan)
    %% SCAN_GLM_REGRESSOR_OUTKF()
    % filter out the outside covariate
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    if ~isfieldp(scan,'glm.outside'), return; end
    if isempty(scan.glm.outside),     return; end
    
    % do stuff
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        
        % realignment
        realignment = load(sprintf('%sfinal_realignment_sub_%02i.mat',  scan.dire.glm.regressor,subject),'realignment');
        realignment = realignment.realignment;
        n_run = length(realignment);
        u_run = 1:n_run;
        
        for i_run = u_run
            r = realignment{i_run}(:,7);
            K = struct('HParam',128,'row',1:length(r),'RT',scan.pars.tr);
            K = spm_filter(K);
            r = spm_filter(K,r);
            realignment{i_run}(:,7) = r;
        end
        save(sprintf('%soutKF_realignment_sub_%02i.mat',  scan.dire.glm.regressor,subject),'realignment');
        save(sprintf('%sfinal_realignment_sub_%02i.mat',  scan.dire.glm.regressor,subject),'realignment');
    end
end