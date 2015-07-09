
function scan_tool_help(scan,header,description)
    %% SCAN_TOOL_HELP(header,description)
    % print a descriptive help for functions in [scan.function]
    % to list main functions, try
    %   >> help scan;

    %% notes
    % this should be improve. it currenly breaks words in two and bugs when splitting a '\n'
    
    %% function
    max_length   = 60;
    
    % header
    cprintf(scan.parameter.analysis.color.help,header);
    fprintf('\n');
    
    % description
    description = [description , repmat(' ',1,mod(-length(description),max_length))];
    description = reshape(description,max_length,length(description)/max_length)';
    for i = 1:size(description,1)
        fprintf(description(i,:));
        fprintf('\n');
    end
    fprintf('\n');
end
