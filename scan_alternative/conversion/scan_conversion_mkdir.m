
function scan = scan_conversion_mkdir(scan)
    %% scan = SCAN_CONVERSION_MKDIR(scan)
    % create new directories before running the conversion
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % dicom
    if scan.running.flag.dicom
        
        % structural
        for i_subject = 1:scan.running.subject.number
            file_mkdir(scan.running.directory.nii.structural.image{i_subject});
        end
        
        % epi4
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_mkdir(scan.running.directory.nii.epi4{i_subject}{i_session});
            end
        end
    end
    
    % expansion
    if scan.running.flag.expansion
        
        % epi3 - image
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_mkdir(scan.running.directory.nii.epi3.image{i_subject}{i_session});
            end
        end
    end
end
