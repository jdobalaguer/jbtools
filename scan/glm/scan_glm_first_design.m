
function scan = scan_glm_first_design(scan)
    %% SCAN_GLM_FIRST_DESIGN()
    % set the design for the GLM (first level)
    % see also scan_glm_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*FPARK>
    
    %% FUNCTION
    if ~exist(scan.dire.glm.firstlevel,'dir'); mkdirp(scan.dire.glm.firstlevel); end

    jobs = {};
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        dire_nii_epi3 = strtrim(scan.dire.nii.epi3(subject,:));
        dire_dat_glm1 = sprintf('%ssub_%02i/',scan.dire.glm.firstlevel,subject);
        fprintf('GLM design for:          %s\n',dire_dat_glm1);
        if ~exist(dire_dat_glm1,'dir'); mkdirp(dire_dat_glm1); end
        
        %% JOB
        job = struct();
        job.spm.stats.fmri_spec.dir = {dire_dat_glm1};
        job.spm.stats.fmri_spec.timing.units  = 'secs';
        job.spm.stats.fmri_spec.timing.RT      = scan.pars.tr;
        job.spm.stats.fmri_spec.timing.fmri_t  = 16;
        job.spm.stats.fmri_spec.timing.fmri_t0 = 1;
        
        %% SESSIONS
        
        % load
        condition   = load(sprintf('%sfinal_condition_sub_%02i.mat',scan.dire.glm.regressor,subject),'condition');
        condition   = condition.condition;
        realignment = load(sprintf('%sfinal_realignment_sub_%02i.mat',scan.dire.glm.regressor,subject),  'realignment');
        realignment = realignment.realignment;

        % nii files
        dire_nii_runs = dir([dire_nii_epi3,'run*']);
        dire_nii_runs = strcat(strvcat(dire_nii_runs.name),'/');
        nb_runs     = size(dire_nii_runs, 1);
        u_run       = 1:nb_runs;
        file_niiimg = {};
        for i_run = u_run
            dire_niirun = strcat(dire_nii_epi3,strtrim(dire_nii_runs(i_run,:)));
            dire_niiimg = strcat(dire_niirun,scan.glm.image,filesep);
            assert(logical(exist(dire_niiimg,'dir')),'scan3_glm_firstlevel: error. "%s" doesnt exist',dire_niiimg);
            file_niiimg{i_run} = cellstr(spm_select('FPlist', dire_niiimg,'^.*images.*\.nii'));
            % discard mean images
            ii_discard = [];
            for i_niiimg = 1:length(file_niiimg{i_run})
                [~,file_niiname,~] = fileparts(file_niiimg{i_run}{i_niiimg});
                if ~isempty(regexp(file_niiname,'.*mean.*','match'))
                    ii_discard(end+1) = i_niiimg;
                end
            end
            file_niiimg{i_run}(ii_discard) = [];
        end
        if scan.glm.pooling
            file_pooling = {};
            for i_run = u_run, file_pooling = [file_pooling;file_niiimg{i_run}]; end
            file_niiimg = {file_pooling};
        end
        
        for i_run = 1:length(condition)
            % nii files
            job.spm.stats.fmri_spec.sess(i_run).scans = file_niiimg{i_run};
            job.spm.stats.fmri_spec.sess(i_run).hpf   = 128;
            job.spm.stats.fmri_spec.sess(i_run).cond  = struct('name',{},'onset',{},'duration',{},'tmod',{},'pmod',{});
            
            % conditions (regressors, modulators & factors)
            for i_cond = 1:length(condition{i_run})
                cond = struct();
                cond.name     = condition{i_run}{i_cond}.name;
                cond.onset    = condition{i_run}{i_cond}.onset;
                cond.duration = condition{i_run}{i_cond}.duration;
                cond.tmod     = 0;
                cond.pmod     = struct('name', {}, 'param', {}, 'poly', {});
                for i_subcond = 1:length(condition{i_run}{i_cond}.subname)
                    cond.pmod(i_subcond).name  = condition{i_run}{i_cond}.subname{i_subcond};
                    cond.pmod(i_subcond).param = condition{i_run}{i_cond}.level{i_subcond};
                    cond.pmod(i_subcond).poly = 1;
                end
                job.spm.stats.fmri_spec.sess(i_run).cond(end+1) = cond;
            end

            % realignment
            for i_rea = 1:size(realignment{i_run},2)
                job.spm.stats.fmri_spec.sess(i_run).regress(i_rea).name = sprintf('regressor %d',i_rea);
                job.spm.stats.fmri_spec.sess(i_run).regress(i_rea).val  = realignment{i_run}(:,i_rea);
            end
        end

        %% OTHERS
        job.spm.stats.fmri_spec.fact = struct('name',{},'levels',{});
        switch(scan.glm.function)
            case 'hrf'
                job.spm.stats.fmri_spec.bases.hrf.derivs = scan.glm.hrf.ord;
            case 'fir'
                job.spm.stats.fmri_spec.bases.fir.length = scan.glm.fir.len;
                job.spm.stats.fmri_spec.bases.fir.order  = scan.glm.fir.ord;
        end
        job.spm.stats.fmri_spec.volt = 1;
        if ~isfieldp(scan,'glm.global')
            scan.glm.global = 'None';
        end
        job.spm.stats.fmri_spec.global = scan.glm.global;
        job.spm.stats.fmri_spec.mask = {''};
        job.spm.stats.fmri_spec.cvi = 'AR(1)';
        
        %% ADD JOB
        jobs{end+1} = job;
    end
    spm_jobman('run',jobs);
    
end