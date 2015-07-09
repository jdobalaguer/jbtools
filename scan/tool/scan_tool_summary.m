
function scan_tool_summary(varargin)
    %% SCAN_TOOL_SUMMARY(scan,title,text1,text2,..)
    % print a summary of the process
    % scan  : [scan] struct
    % text* : steps of the process
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % default
    scan  = varargin{1};
    title = varargin{2};
    text  = varargin(3:end);
    
    % print steps
    if scan.parameter.analysis.verbose
        cprintf(scan.parameter.analysis.color.summary,'%s :',title);
        fprintf('\n');
        for i_text = 1:length(text)
            fprintf('  %02i. %s\n',i_text,text{i_text});
        end
    end
end
