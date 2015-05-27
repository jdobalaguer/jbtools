
function scan = scan_initialize_autocomplete_nii(scan)
    %% scan = SCAN_INITIALIZE_AUTOCOMPLETE_NII(scan)
    % autocomplete initial values
    % to list main functions, try
    %   >> scan;
    
    %% function (dicom)
    % todo
    
    %% function (nii)
    
    % structural - image
    for i_subject = 1:scan.running.subject.number
        scan.running.file.nii.structural.image{i_subject} = file_match(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','image','*.nii'));
    end
    
    % structural - coregistration
    for i_subject = 1:scan.running.subject.number
        scan.running.file.nii.structural.coregistration{i_subject} = file_match(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','coregistration','*.nii'));
    end
    
    % structrual - normalisation
    for i_subject = 1:scan.running.subject.number
        scan.running.file.nii.structural.normalisation{i_subject} = file_match(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','normalisation',num2str(scan.parameter.analysis.voxs),'*.nii'));
    end
    
    % epi4
    for i_subject = 1:scan.running.subject.number
        scan.running.file.nii.epi4{i_subject} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi4','*.nii'));
    end
    
    % epi3 - image
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.file.nii.epi3.image{i_subject}{i_session} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'image','*.nii'));
        end
    end
    
    % epi3 - realignment
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.file.nii.epi3.realignment{i_subject}{i_session} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'realignment','*.nii'));
        end
    end
    
    % epi3 - normalisation
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.file.nii.epi3.normalisation{i_subject}{i_session} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'normalisation',num2str(scan.parameter.analysis.voxs),'*.nii'));
        end
    end
    
    % epi3 - smooth
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.file.nii.epi3.smooth{i_subject}{i_session} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'smooth',num2str(scan.parameter.analysis.voxs),'*.nii'));
        end
    end
end
