
function scan = scan_autocomplete_preprocess(scan)
    %% scan = SCAN_AUTOCOMPLETE_PREPROCESS(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % directory
    scan.running.directory.job          = scan.directory.preprocess;
    scan.running.directory.save.scan    = file_endsep(fullfile(scan.running.directory.job,'scan'));
    scan.running.directory.save.caller  = file_endsep(fullfile(scan.running.directory.job,'caller'));
    scan.running.file.save.hdd          = fullfile(scan.running.directory.job,'hdd.mat');
    
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
