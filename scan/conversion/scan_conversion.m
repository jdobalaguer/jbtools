
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
        'First steps',...
        ...
        'DICOM conversion',...
        'NIfTI expansion');
     
    % initialize
    scan = scan_assert_spm(scan);                   % assert (spm)
    scan = scan_initialize(scan);                   % initialize scan / SPM
    try
        % first steps
        scan = scan_conversion_steps(scan);
        
        % conversion
        scan = scan_conversion_dicom(scan);
        scan = scan_conversion_expansion(scan);
        
        % time
        scan = scan_tool_time(scan);
        scan = scan_tool_sound(scan,1);
    catch e
        scan = scan_tool_catch(scan,e);
        scan = scan_tool_sound(scan,0);
    end
end
