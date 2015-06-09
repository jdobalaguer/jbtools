
function scan = scan_conversion(scan)
    %% scan = SCAN_CONVERSION(scan)
    % Conversion from DICOM, to NIfTI-4D, to NIfTI-3D
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % job type
    scan.job.type = 'conversion';
    
    % summary
    scan_tool_summary(scan,'Conversion',...
        'Initialize',...
        ...
        'DICOM conversion',...
        'NIfTI expansion');
     
    try
        % initialize
        scan = scan_initialize(scan);           % initialize scan / SPM
        scan = scan_autocomplete_dicom(scan);   % autocomplete (dicom)
        scan = scan_autocomplete_nii(scan,'structural:image'); % autocomplete (nii)
        scan = scan_autocomplete_nii(scan,'epi4'); % autocomplete (nii)
        scan = scan_autocomplete_nii(scan,'epi3:image'); % autocomplete (nii)
        scan = scan_conversion_flag(scan);           % redo flags
        scan = scan_conversion_rmdir(scan);          % remove old directories
        scan = scan_conversion_mkdir(scan);          % create new directories

        % conversion
        scan = scan_conversion_dicom(scan);
        scan = scan_conversion_expansion(scan);

    catch e
        scan = scan_tool_catch(scan,e);
    end
end
