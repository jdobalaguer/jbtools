
function scan = scan_tbte_condition_split(scan)
    %% scan = SCAN_TBTE_CONDITION_SPLIT(scan)
    % split conditions
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.design, return; end
    
    % print
    scan_tool_print(scan,false,'\nSplit condition : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % session
        for i_session = 1:length(scan.running.condition{i_subject})
            
            % variable
            condition = struct('main',{},'name',{},'version',{},'onset',{},'subname',{},'level',{},'duration',{});
            
            % condition
            for i_condition = 1:length(scan.running.condition{i_subject}{i_session})
            
                % variables
                n_condition = numel(scan.running.condition{i_subject}{i_session}(i_condition).onset);
                % split
                condition = [condition, ...
                             struct('main',     {scan.running.condition{i_subject}{i_session}(i_condition).main},...
                                    'name',     {scan.running.condition{i_subject}{i_session}(i_condition).name},...
                                    'version',  num2leg(1:n_condition,'%03i'),...
                                    'onset',    num2cell(mat2row(scan.running.condition{i_subject}{i_session}(i_condition).onset)),...
                                    'subname',  {{}},...
                                    'level',    {{}},...
                                    'duration', {scan.running.condition{i_subject}{i_session}(i_condition).duration})...
                            ]; %#ok<AGROW>
            end
            scan.running.condition{i_subject}{i_session} = condition;
            
            % wait
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
