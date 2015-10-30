
function MRIcroGL(script)
    %% MRICROGL([script])
    % wrap for MRIcroGL
    
    %% function
    func_default('script','');
    if ~isempty(script), script = file_2absolute(script); end
    MRIcroGL = '/Applications/MRIcroGL/MRIcroGL.app/Contents/MacOS/MRIcroGL';
    if file_exist(script), cmd = sprintf('!%s "%s"',MRIcroGL,script);
    else                   cmd = sprintf('!%s',     MRIcroGL);
    end
    eval(cmd);
end
