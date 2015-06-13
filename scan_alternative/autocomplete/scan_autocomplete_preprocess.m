
function scan = scan_autocomplete_preprocess(scan)
    %% scan = SCAN_AUTOCOMPLETE_PREPROCESS(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % last
    scan.running.last = scan.job.last;
    
    % structural
    scan = scan_autocomplete_nii(scan,'structural:image');
    scan = scan_autocomplete_nii(scan,'structural:coregistration');
    scan = scan_autocomplete_nii(scan,'structural:normalisation');
    
    % epi3
    scan = scan_autocomplete_nii(scan,'epi3:image');
    scan = scan_autocomplete_nii(scan,'epi3:slicetime');
    scan = scan_autocomplete_nii(scan,'epi3:realignment');
    scan = scan_autocomplete_nii(scan,'epi3:normalisation');
    scan = scan_autocomplete_nii(scan,'epi3:smooth');
end
