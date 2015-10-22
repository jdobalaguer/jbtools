
function scan = scan_autocomplete_glm(scan)
    %% scan = SCAN_AUTOCOMPLETE_GLM(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % directory
    scan.running.directory.job          = file_endsep(fullfile(scan.directory.glm,scan.job.image,scan.job.name));
    scan.running.directory.save.scan    = file_endsep(fullfile(scan.running.directory.job,'scan'));
    scan.running.directory.save.caller  = file_endsep(fullfile(scan.running.directory.job,'caller'));
    scan.running.file.save.hdd          = fullfile(scan.running.directory.job,'hdd.mat');
    
    scan.running.directory.y                     = file_endsep(fullfile(scan.running.directory.job,'y'));
    scan.running.directory.original.first        = fullfile(scan.running.directory.job,'original','first_level',num2leg(scan.running.subject.unique,'subject_%03i')',filesep);
    scan.running.directory.original.second       = fullfile(scan.running.directory.job,'original','second_level',filesep);
    scan.running.directory.copy.root             = fullfile(scan.running.directory.job,'copy',filesep);
    scan.running.directory.copy.first.beta       = fullfile(scan.running.directory.job,'copy','beta_1',filesep);
    scan.running.directory.copy.first.contrast   = fullfile(scan.running.directory.job,'copy','cont_1',filesep);
    scan.running.directory.copy.first.statistic  = fullfile(scan.running.directory.job,'copy','spmt_1',filesep);
    scan.running.directory.copy.first.spm        = fullfile(scan.running.directory.job,'copy','SPM_1',filesep);
    scan.running.directory.copy.second.beta      = fullfile(scan.running.directory.job,'copy','beta_2',filesep);
    scan.running.directory.copy.second.contrast  = fullfile(scan.running.directory.job,'copy','cont_2',filesep);
    scan.running.directory.copy.second.statistic = fullfile(scan.running.directory.job,'copy','spmt_2',filesep);
    scan.running.directory.copy.second.spm       = fullfile(scan.running.directory.job,'copy','SPM_2',filesep);
    
    % bases
    scan.running.bases = struct(scan.job.basisFunction.name,{scan.job.basisFunction.parameters});
    
    % extend duration if required
    for i_condition = 1:length(scan.job.condition)
        if isscalar(scan.job.condition(i_condition).duration)
            scan.job.condition(i_condition).duration = repmat(scan.job.condition(i_condition).duration,size(scan.job.condition(i_condition).onset));
        end
    end
    
    % condition
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.condition{i_subject}{i_session} = struct('main',{},'name',{},'version',{},'onset',{},'subname',{},'level',{},'duration',{});
            for i_condition = 1:length(scan.job.condition)
                ii_subject  = (scan.job.condition(i_condition).subject == scan.running.subject.unique(i_subject));
                ii_session  = (scan.job.condition(i_condition).session == i_session);
                ii_discard  = (scan.job.condition(i_condition).discard);
                func_default('ii_discard',false(size(ii_subject)));
                ii_data  = (ii_subject & ii_session & ~ii_discard);
                if ~any(ii_data), continue; end
                scan.running.condition{i_subject}{i_session}(end+1) = struct( ...
                    'main'     , {scan.job.condition(i_condition).name}, ...
                    'name'     , {scan.job.condition(i_condition).name}, ...
                    'version'  , {''}, ...
                    'onset'    , {scan.job.condition(i_condition).onset(ii_data) + scan.parameter.scanner.reft0 - scan.job.delayOnset}, ...
                    'subname'  , {scan.job.condition(i_condition).subname}, ...
                    'level'    , {cell2mat(cellfun(@(x)double(mat2vec(x(ii_data))),scan.job.condition(i_condition).level,'UniformOutput',false))}, ...
                    'duration' , {scan.job.condition(i_condition).duration(ii_data)});
            end
        end
    end
    
    % regressor
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.regressor{i_subject}{i_session} = struct('name',{{}},'regressor',{[]},'filter',{[]},'zscore',{[]},'covariate',{[]});
        end
    end
    
    % design
    scan.running.design = struct('column',{},'row',{},'matrix',{});
    
    % contrast
    scan.running.contrast = {};
end
