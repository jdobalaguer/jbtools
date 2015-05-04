
function scan = scan_ppi_seed(scan)
    %% SCAN_PPI_SEED()
    % extract seed timecourse for PPI
    % see also scan_ppi_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*FPARK,*NASGU>
    
    %% FUNCTION
    if ~scan.ppi.do.seed, return; end
    
    scan.ppi.variables = struct();
    scan.ppi.variables.seed = scan_nifti_load([scan.dire.mask,scan.ppi.seed]);
    scan.ppi.variables.vols = {};
    scan.ppi.variables.file = {};
    scan.ppi.variables.n_file = 0;
    
    for i_subject = 1:scan.subject.n
        scan.ppi.variables.vols{i_subject} = {};
        scan.ppi.variables.file{i_subject} = {};
        subject = scan.subject.u(i_subject);
        
        % directories
        dire_nii_epi3 = strtrim(scan.dire.nii.epi3(subject,:));
        fprintf('Extracting seed signal for: %s\n',dire_nii_epi3);
        dire_nii_runs = dir([strtrim(dire_nii_epi3),'run*']);
        dire_nii_runs = strcat(strvcat(dire_nii_runs.name),'/');
        n_session     = size(dire_nii_runs, 1);
        u_session     = 1:n_session;
        for i_session = u_session

            dire_nii_run  = strcat(dire_nii_epi3,strtrim(dire_nii_runs(i_session,:)));
            dire_nii_run  = [dire_nii_run,scan.glm.image,filesep()];
            u_file        = dir([dire_nii_run,'*.nii']);
            n_file        = length(u_file);
            ii_discard    = false(size(u_file));
            for i_file = 1:n_file
                if ~isempty(regexp(u_file(i_file).name,'.*mean.*','match')) % remove mean image
                    ii_discard(i_file) = true;
                end
            end
            u_file(ii_discard) = [];
            u_file        = strcat(dire_nii_run,strvcat(u_file.name));
            n_file        = size(u_file,1);
            
            % remove seed
            vols = nan(1,n_file);
            jb_parallel_progress(n_file);
            for i_file = 1:n_file
                vols(i_file) = nanmean(scan_nifti_load(u_file(i_file,:),scan.ppi.variables.seed));
                jb_parallel_progress();
            end
            jb_parallel_progress(0);
            scan.ppi.variables.vols{i_subject}{i_session} = vols;
            scan.ppi.variables.file{i_subject}{i_session} = u_file;
            scan.ppi.variables.n_file = scan.ppi.variables.n_file + n_file;
        end
    end
    
    % set as final
    scan.ppi.variables.final = scan.ppi.variables.vols;
    
    % save
    save([scan.dire.glm.root,'scan.mat'],'scan');
end

