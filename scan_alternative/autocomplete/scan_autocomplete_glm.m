
function scan = scan_autocomplete_glm(scan)
    %% scan = SCAN_AUTOCOMPLETE_GLM(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % original
    scan.running.directory.original.first        = fullfile(scan.running.directory.job,'original','first_level',num2leg(scan.running.subject.unique,'subject_%03i')',filesep);
    scan.running.directory.original.second       = fullfile(scan.running.directory.job,'original','second_level',filesep);
    
    % copy
    scan.running.directory.copy.root             = fullfile(scan.running.directory.job,'copy',filesep);
    scan.running.directory.copy.first.beta       = fullfile(scan.running.directory.job,'copy','beta_1',filesep);
    scan.running.directory.copy.first.contrast   = fullfile(scan.running.directory.job,'copy','cont_1',filesep);
    scan.running.directory.copy.first.statistic  = fullfile(scan.running.directory.job,'copy','spmt_1',filesep);
    scan.running.directory.copy.first.spm        = fullfile(scan.running.directory.job,'copy','SPM_1',filesep);
    scan.running.directory.copy.second.beta      = fullfile(scan.running.directory.job,'copy','beta_2',filesep);
    scan.running.directory.copy.second.contrast  = fullfile(scan.running.directory.job,'copy','cont_2',filesep);
    scan.running.directory.copy.second.statistic = fullfile(scan.running.directory.job,'copy','spmt_2',filesep);
    scan.running.directory.copy.second.spm       = fullfile(scan.running.directory.job,'copy','SPM_2',filesep);
    
    % condition
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.condition{i_subject}{i_session} = struct('name',{},'onset',{},'subname',{},'level',{},'duration',{});
            for i_condition = 1:length(scan.job.condition)
                ii_subject  = (scan.job.condition(i_condition).subject == scan.running.subject.unique(i_subject));
                ii_session  = (scan.job.condition(i_condition).session == i_session);
                ii_discard  = (scan.job.condition(i_condition).discard);
                func_default('ii_discard',false(size(ii_subject)));
                ii_data  = (ii_subject & ii_session & ~ii_discard);
                if ~any(ii_data), continue; end
                scan.running.condition{i_subject}{i_session}(end+1) = struct( ...
                    'name'     , scan.job.condition(i_condition).name, ...
                    'onset'    , {scan.job.condition(i_condition).onset(ii_data) + scan.parameter.scanner.reft0 - scan.job.delayOnset}, ...
                    'subname'  , {scan.job.condition(i_condition).subname}, ...
                    'level'    , {cell2mat(cellfun(@(x)double(mat2vec(x(ii_data))),scan.job.condition(i_condition).level,'UniformOutput',false))}, ...
                    'duration' , {scan.job.condition(i_condition).duration});
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
