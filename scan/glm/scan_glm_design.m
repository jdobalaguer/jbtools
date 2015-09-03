
function scan = scan_glm_design(scan)
    %% scan = SCAN_GLM_DESIGN(scan)
    % set GLM design for SPM
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.design, return; end
    
    % print
    scan_tool_print(scan,false,'\nSPM Design : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % job
        spm{i_subject}.spm.stats.fmri_spec.dir = scan.running.directory.original.first(i_subject);
        spm{i_subject}.spm.stats.fmri_spec.timing.units  = 'secs';
        spm{i_subject}.spm.stats.fmri_spec.timing.RT      = scan.parameter.scanner.tr;
        if scan.parameter.analysis.st  % slice-time correction
            spm{i_subject}.spm.stats.fmri_spec.timing.fmri_t  = scan.parameter.scanner.nslices; % microtime resolution
            spm{i_subject}.spm.stats.fmri_spec.timing.fmri_t0 = scan.parameter.scanner.reft0; % microtime onset
        else
            spm{i_subject}.spm.stats.fmri_spec.timing.fmri_t  = spm_get_defaults('stats.fmri.t');
            spm{i_subject}.spm.stats.fmri_spec.timing.fmri_t0 = spm_get_defaults('stats.fmri.t0');
        end
        spm{i_subject}.spm.stats.fmri_spec.fact = struct('name',{},'levels',{});
        spm{i_subject}.spm.stats.fmri_spec.bases = scan.running.bases; %spm{i_subject}.spm.stats.fmri_spec.bases.(scan.job.basisFunction.name) = scan.job.basisFunction.parameters;
        spm{i_subject}.spm.stats.fmri_spec.volt = 1;
        spm{i_subject}.spm.stats.fmri_spec.global = 'none';
        if scan.job.globalScaling, spm{i_subject}.spm.stats.fmri_spec.global = 'scaling'; end
        spm{i_subject}.spm.stats.fmri_spec.mask = {''};
        spm{i_subject}.spm.stats.fmri_spec.cvi = spm_get_defaults('stats.fmri.cvi');
        
        % session
        for i_session = 1:scan.running.subject.session(i_subject)
            spm{i_subject}.spm.stats.fmri_spec.sess(i_session).scans = scan.running.file.nii.epi3.(scan.job.image){i_subject}{i_session};
            spm{i_subject}.spm.stats.fmri_spec.sess(i_session).hpf   = spm_get_defaults('stats.fmri.hpf');
            spm{i_subject}.spm.stats.fmri_spec.sess(i_session).cond  = struct('name',{},'onset',{},'duration',{},'tmod',{},'pmod',{});
            
            % condition
            for i_condition = 1:length(scan.running.condition{i_subject}{i_session})
                spm{i_subject}.spm.stats.fmri_spec.sess(i_session).cond(i_condition).name     = strcat(scan.running.condition{i_subject}{i_session}(i_condition).name,scan.running.condition{i_subject}{i_session}(i_condition).version);
                spm{i_subject}.spm.stats.fmri_spec.sess(i_session).cond(i_condition).onset    = scan.running.condition{i_subject}{i_session}(i_condition).onset;
                spm{i_subject}.spm.stats.fmri_spec.sess(i_session).cond(i_condition).duration = scan.running.condition{i_subject}{i_session}(i_condition).duration;
                spm{i_subject}.spm.stats.fmri_spec.sess(i_session).cond(i_condition).tmod     = 0;
                spm{i_subject}.spm.stats.fmri_spec.sess(i_session).cond(i_condition).pmod     = struct('name', {}, 'param', {}, 'poly', {});
                for i_level = 1:length(scan.running.condition{i_subject}{i_session}(i_condition).subname)
                    spm{i_subject}.spm.stats.fmri_spec.sess(i_session).cond(i_condition).pmod(i_level).name  = scan.running.condition{i_subject}{i_session}(i_condition).subname{i_level};
                    spm{i_subject}.spm.stats.fmri_spec.sess(i_session).cond(i_condition).pmod(i_level).param = scan.running.condition{i_subject}{i_session}(i_condition).level(:,i_level);
                    spm{i_subject}.spm.stats.fmri_spec.sess(i_session).cond(i_condition).pmod(i_level).poly = 1;
                end
            end

            % regressor
            for i_regressor = 1:length(scan.running.regressor{i_subject}{i_session}.name)
                spm{i_subject}.spm.stats.fmri_spec.sess(i_session).regress(i_regressor).name = scan.running.regressor{i_subject}{i_session}.name{i_regressor};
                spm{i_subject}.spm.stats.fmri_spec.sess(i_session).regress(i_regressor).val  = scan.running.regressor{i_subject}{i_session}.regressor(:,i_regressor);
            end
        end
    
        % SPM
        evalc('spm_jobman(''run'',spm(i_subject))');
        
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.design = spm;
    
    % done
    scan = scan_tool_done(scan);
end
