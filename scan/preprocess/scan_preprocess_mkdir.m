
function scan = scan_preprocess_mkdir(scan)
    %% scan = SCAN_PREPROCESS_MKDIR(scan)
    % create new directories before running the preprocessing
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    file_mkdir(scan.running.directory.job);
    
    % slicetime
    if scan.running.flag.slicetime
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_mkdir(scan.running.directory.nii.epi3.slicetime{i_subject}{i_session});
            end
        end
    end
        
    % realignment
    if scan.running.flag.realignment
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_mkdir(scan.running.directory.nii.epi3.realignment{i_subject}{i_session});
            end
        end
    end
        
    % coregistration
    if scan.running.flag.coregistration
        for i_subject = 1:scan.running.subject.number
            file_mkdir(scan.running.directory.nii.structural.coregistration{i_subject});
        end
    end
        
    % estimation
    if scan.running.flag.estimation
        for i_subject = 1:scan.running.subject.number
            file_mkdir(scan.running.directory.nii.structural.normalisation{i_subject});
        end
    end
        
    % normalisation
    if scan.running.flag.normalisation
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_mkdir(scan.running.directory.nii.epi3.normalisation{i_subject}{i_session});
            end
        end
    end
        
    % smooth
    if scan.running.flag.smooth
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_mkdir(scan.running.directory.nii.epi3.smooth{i_subject}{i_session});
            end
        end
    end
end
