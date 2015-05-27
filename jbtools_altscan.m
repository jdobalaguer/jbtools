
function jbtools_altscan()
    %% JBTOOLS_ALTSCAN()
    % swithc to new version of the scan toolbox

    %% warnings

    %% function
    rmgenpath ([jbtools_root(),'/scan']);
    addgenpath([jbtools_root(),'/scan_alternative']);
end