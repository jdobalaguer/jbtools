
function scan = scan_preprocess_rmdir(scan)
    %% scan = SCAN_PREPROCESS_RMDIR(scan)
    % delete old directories before running the preprocessing
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % slicetime
    if scan.running.flag.slicetime
        if any(cellfun(@isdir,cell_flat(scan.running.directory.nii.epi3.slicetime)))
            scan_tool_warning(scan,true,'will delete "epi3:slicetime" folders');
        end
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_rmdir(scan.running.directory.nii.epi3.slicetime{i_subject}{i_session});
            end
        end
    end
        
    % realignment
    if scan.running.flag.realignment
        if any(cellfun(@isdir,cell_flat(scan.running.directory.nii.epi3.realignment)))
            scan_tool_warning(scan,true,'will delete "epi3:realignment" folders');
        end
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_rmdir(scan.running.directory.nii.epi3.realignment{i_subject}{i_session});
            end
        end
    end
        
    % coregistration
    if scan.running.flag.coregistration
        if any(cellfun(@isdir,cell_flat(scan.running.directory.nii.structural.coregistration)))
            scan_tool_warning(scan,true,'will delete "structural:coregistration" folders');
        end
        for i_subject = 1:scan.running.subject.number
            file_rmdir(scan.running.directory.nii.structural.coregistration{i_subject});
        end
    end
        
    % segmentation
    if scan.running.flag.segmentation
        if any(cellfun(@isdir,cell_flat(scan.running.directory.nii.structural.segmentation)))
            scan_tool_warning(scan,true,'will delete "structural:segmentation" folders');
        end
        for i_subject = 1:scan.running.subject.number
            file_rmdir(scan.running.directory.nii.structural.segmentation{i_subject});
        end
    end
        
    % estimation
    if scan.running.flag.estimation
        if any(cellfun(@isdir,cell_flat(scan.running.directory.nii.structural.normalisation)))
            scan_tool_warning(scan,true,'will delete "structural:normalisation" folders');
        end
        for i_subject = 1:scan.running.subject.number
            file_rmdir(scan.running.directory.nii.structural.normalisation{i_subject});
        end
    end
        
    % normalisation
    if scan.running.flag.normalisation
        if any(cellfun(@exist,cell_flat(scan.running.directory.nii.epi3.normalisation)))
            scan_tool_warning(scan,true,'will delete "epi3:normalisation" folders');
        end
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_rmdir(scan.running.directory.nii.epi3.normalisation{i_subject}{i_session});
            end
        end
    end
        
    % smooth
    if scan.running.flag.smooth
        if any(cellfun(@isdir,cell_flat(scan.running.directory.nii.epi3.smooth)))
            scan_tool_warning(scan,true,'will delete "epi3:smooth" folders');
        end
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                file_rmdir(scan.running.directory.nii.epi3.smooth{i_subject}{i_session});
            end
        end
    end
end
