
function [scan,job] = scan_preprocess_realignment(scan,job)
    %% [scan,job] = SCAN_PREPROCESS_REALIGNMENT(scan,job)
    % preprocessing realignment
    % see also scan_preprocess_run
    
    %% WARNINGS
    %#ok<*FPARK,*AGROW>

    %% FUNCTION
    
    % realignment
    batches = {};
    for i_subject = scan.subject.u
        dir_sub  = strtrim(scan.dire.nii.subs(i_subject,:));
        dir_runs    = dir([strtrim(scan.dire.nii.epi3(i_subject,:)),'run*']); dir_runs = strcat(strvcat(dir_runs.name),filesep);
        nb_runs     = size(dir_runs, 1);
        u_run       = 1:nb_runs;
        if ~job.run, u_run = 1; end
        fprintf('Realign and Unwarp for:          %s\n',dir_sub);
        batch = struct();
        batch.spm.spatial.realignunwarp.eoptions.quality = 0.9;       % Quality (Default: 0.9)
        batch.spm.spatial.realignunwarp.eoptions.sep = 4;             % Separation (Default: 4) 
        batch.spm.spatial.realignunwarp.eoptions.fwhm = 5;            % Smoothing (FWHM) (Default: 5)
        batch.spm.spatial.realignunwarp.eoptions.rtm = 0;             % Num Passes (Default: Register to mean) 
        batch.spm.spatial.realignunwarp.eoptions.einterp = 2;         % Interpolation (Default: 2nd Degree B-Spline)
        batch.spm.spatial.realignunwarp.eoptions.ewrap = [0 0 0];     % Wrapping (Default: No wrap) 
        batch.spm.spatial.realignunwarp.eoptions.weight = '' ;        % Weighting (Default: None) (vorher {} )
        batch.spm.spatial.realignunwarp.uwroptions.uwwhich = [2 1];   % Resliced Images ([0 1] > Only Mean Image; Default: [2 1] > All Images + Mean Image) 
        batch.spm.spatial.realignunwarp.uwroptions.rinterp = 4;       % Interpolation (Default: 4th Degree B-Spline) 
        batch.spm.spatial.realignunwarp.uwroptions.wrap = [0 0 0];    % Wrapping (Default: No wrap) 
        batch.spm.spatial.realignunwarp.uwroptions.mask = 1;          % Masking (Default: Mask images)
        batch.spm.spatial.realignunwarp.uwroptions.prefix = 'u';      % Realigned files prefix
        batch.spm.spatial.realignunwarp.uweoptions.basfcn = [12 12];
        batch.spm.spatial.realignunwarp.uweoptions.regorder = 1;
        batch.spm.spatial.realignunwarp.uweoptions.lambda = 100000;
        batch.spm.spatial.realignunwarp.uweoptions.jm = 0;
        batch.spm.spatial.realignunwarp.uweoptions.fot = [4 5];
        batch.spm.spatial.realignunwarp.uweoptions.sot = [];
        batch.spm.spatial.realignunwarp.uweoptions.uwfwhm = 4;
        batch.spm.spatial.realignunwarp.uweoptions.rem = 1;
        batch.spm.spatial.realignunwarp.uweoptions.noi = 5;
        batch.spm.spatial.realignunwarp.uweoptions.expround = 'Average';
        for i_run = u_run
            if job.run, dir_from = strcat(dir_sub,sprintf(job.from.path,i_run),filesep);
            else        dir_from = strcat(dir_sub,job.from.path,filesep);
            end
            run_images = dir([dir_from,job.from.file]);
            run_images = strvcat(run_images.name);
            filenames  = strcat(dir_from,run_images);
            batch.spm.spatial.realignunwarp.data(i_run).scans = cellstr(filenames);
            batch.spm.spatial.realignunwarp.data(i_run).pmscan = [];
        end
        batches{end+1} = batch;
    end
    if ~isempty(batches)
        spm_jobman('run',batches);
    end
end
