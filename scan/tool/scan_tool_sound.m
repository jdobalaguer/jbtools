
function scan = scan_tool_sound(scan,good)
    %% scan = SCAN_TOOL_SOUND(scan,good)
    % set a function as done
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if good, s = scan.parameter.analysis.sound.good;
    else     s = scan.parameter.analysis.sound.bad;
    end
    if strcmp(s,'none'), return; end

    y  = file_loadvar(s,'y');
    Fs = file_loadvar(s,'Fs');
    sound(y,Fs);
end
