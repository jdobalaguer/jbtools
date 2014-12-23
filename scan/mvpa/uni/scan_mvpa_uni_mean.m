

function scan = scan_mvpa_uni_mean(scan)
    %% scan = SCAN_MVPA_UNI_MEAN(scan)
    % average all voxels
    % see scan_mvpa_uni
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % average
    for i_subject = 1:scan.subject.n
        scan.mvpa.variable.beta{i_subject} = mean(scan.mvpa.variable.beta{i_subject},1);
    end
end
