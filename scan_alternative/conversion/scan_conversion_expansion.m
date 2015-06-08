
function scan = scan_conversion_expansion(scan)
    %% scan = SCAN_CONVERSION_EXPANSION(scan)
    % expand NIfTI-4D to many NIfTI-3D volumnes
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.expansion, return; end
   
    % print
    scan_tool_print(scan,false,'\nNIfTI expansion : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % update nii.epi4
    scan = scan_autocomplete_nii(scan,'epi4');
    
    % nifti expansion
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            file_epi4 = scan.running.file.nii.epi4{i_subject}{i_session};
            dire_epi3 = scan.running.directory.nii.epi3.image{i_subject}{i_session};
            spm_file_split(file_epi4,dire_epi3);
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
