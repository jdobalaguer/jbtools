
function scan = scan_conversion_rmdir(scan)
    %% scan = SCAN_CONVERSION_RMDIR(scan)
    % delete old directories before running the conversion
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % dicom
    if scan.running.flag.dicom
        
        % structural
        if any(cellfun(@isdir,cell_flat(scan.running.directory.nii.structural.image)))
            scan_tool_warning(scan,false,'will delete "nii:structural:image" folders');
        end
        for i_subject = 1:scan.running.subject.number
            file_rmdir(scan.running.directory.nii.structural.image{i_subject});
        end
        
        % epi4
        if any(cellfun(@isdir,cell_flat(scan.running.directory.nii.epi4)))
            scan_tool_warning(scan,false,'will delete "nii:epi4" folders');
        end
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_rmdir(scan.running.directory.nii.epi4{i_subject}{i_session});
            end
        end
    end
    
    % expansion
    if scan.running.flag.expansion
        
        % epi3 - image
        if any(cellfun(@isdir,cell_flat(scan.running.directory.nii.epi3.image)))
            scan_tool_warning(scan,false,'will delete "nii:epi3:image" folders');
        end
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_rmdir(scan.running.directory.nii.epi3.image{i_subject}{i_session});
            end
        end
    end
end
