
function scan = scan_tbte_condition_split(scan)
    %% scan = SCAN_TBTE_CONDITION_SPLIT(scan)
    % split conditions
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.design, return; end
    
    % print
    scan_tool_print(scan,false,'\nSplit condition : ');
    scan = scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % session
        for i_session = 1:length(scan.running.condition{i_subject})
            
            % variable
            condition = struct('main',{},'name',{},'version',{},'onset',{},'subname',{},'level',{},'split',{},'duration',{});
            
            % condition
            for i_condition = 1:length(scan.running.condition{i_subject}{i_session})
                1;
                if scan.running.condition{i_subject}{i_session}(i_condition).split
                    % variables
                    n_condition = numel(scan.running.condition{i_subject}{i_session}(i_condition).onset);
                    % split
                    condition = [condition, ...
                                 struct('main',     {scan.running.condition{i_subject}{i_session}(i_condition).main},...
                                        'name',     {scan.running.condition{i_subject}{i_session}(i_condition).name},...
                                        'version',  num2leg(1:n_condition,'_%03i'),...
                                        'onset',    num2cell(mat2row(scan.running.condition{i_subject}{i_session}(i_condition).onset)),...
                                        'subname',  {{}},...
                                        'level',    {{}},...
                                        'split',    {true(1,n_condition)},...
                                        'duration', {scan.running.condition{i_subject}{i_session}(i_condition).duration})...
                                ]; %#ok<AGROW>
                else
                    condition = [condition,scan.running.condition{i_subject}{i_session}(i_condition)]; %#ok<AGROW>
                end
            end
            scan.running.condition{i_subject}{i_session} = condition;
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
