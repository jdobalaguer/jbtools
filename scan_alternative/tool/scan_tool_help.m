
function scan_tool_help(header,description)
    %% SCAN_TOOL_HELP(header,description)
    % print a descriptive help for functions in [scan.function]
    % to list main functions, try
    %   >> help scan;

    %% notes
    % this should be improve. it currenly breaks words in two and bugs when splitting a '\n'
    
    %% function
    header_colour = '*blue';
    description_colour = 'black';
    max_length   = 60;
    
    % header
    cprintf(header_colour,header);
    fprintf('\n');
    
    % description
    description = [description , repmat(' ',1,mod(-length(description),max_length))];
    description = reshape(description,max_length,length(description)/max_length)';
    for i = 1:size(description,1)
        cprintf(description_colour,description(i,:));
        fprintf('\n');
    end
    fprintf('\n');
end
