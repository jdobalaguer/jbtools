
function scan = scan_conversion_dicom(scan)
    %% scan = SCAN_CONVERSION_DICOM(scan)
    % convert DICOM to NIfTI-4D
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.dicom, return; end
   
    % print
    scan_tool_print(scan,false,'\nDICOM conversion : ');
    scan_tool_progress(scan,scan.running.subject.number + sum(scan.running.subject.session));
    
    % dicom conversion
    for i_subject = 1:scan.running.subject.number
        
        % structural
        file_dicom   = sprintf('%s*.dcm',scan.running.directory.dicom.structural{i_subject});
        dire_nii     = scan.running.directory.nii.structural.image{i_subject};
        dicm2nii(file_dicom,dire_nii,'nii');
        scan_tool_progress(scan,[]);
        
        % nifti
        for i_session = 1:scan.running.subject.session(i_subject)
            file_dicom   = sprintf('%s*.dcm',scan.running.directory.dicom.epi{i_subject}{i_session});
            dire_nii     = scan.running.directory.nii.epi4{i_subject}{i_session};
            dicm2nii(file_dicom,dire_nii,'nii');
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
