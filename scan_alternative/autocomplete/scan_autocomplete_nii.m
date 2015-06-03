
function scan = scan_autocomplete_nii(scan)
    %% scan = SCAN_AUTOCOMPLETE_NII(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function (dicom)
    % todo
    
    %% function (nii)
    
    % structural - image
    for i_subject = 1:scan.running.subject.number
        scan.running.directory.nii.structural.image{i_subject} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','image'));
        scan.running.file.nii.structural.image{i_subject} = file_match(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','image','*.nii'),'absolute');
    end
    
    % structural - coregistration
    for i_subject = 1:scan.running.subject.number
        scan.running.directory.nii.structural.coregistration{i_subject} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','coregistration'));
        scan.running.file.nii.structural.coregistration{i_subject} = file_match(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','coregistration','*.nii'),'absolute');
    end
    
    % structrual - normalisation
    for i_subject = 1:scan.running.subject.number
        scan.running.directory.nii.structural.normalisation{i_subject} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','normalisation',num2str(scan.parameter.analysis.voxs)));
        scan.running.file.nii.structural.normalisation{i_subject} = file_match(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','normalisation',num2str(scan.parameter.analysis.voxs),'*.nii'),'absolute');
    end
    
    % epi4
    for i_subject = 1:scan.running.subject.number
        scan.running.directory.nii.epi4{i_subject} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi4'));
        scan.running.file.nii.epi4{i_subject} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi4','*.nii'),'absolute');
    end
    
    % epi3 - image
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.directory.nii.epi3.image{i_subject}{i_session} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'image'));
            scan.running.file.nii.epi3.image{i_subject}{i_session} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'image','*.nii'),'absolute');
            scan.running.file.nii.epi3.image{i_subject}{i_session}(cellfun(@isscalar,strfind(scan.running.file.nii.epi3.image{i_subject}{i_session},'mean'))) = []; % remove mean image
        end
    end
    
    % epi3 - realignment
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.directory.nii.epi3.realignment{i_subject}{i_session} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'realignment'));
            scan.running.file.nii.epi3.realignment{i_subject}{i_session} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'realignment','*.nii'),'absolute');
            scan.running.file.nii.epi3.realignment{i_subject}{i_session}(cellfun(@isscalar,strfind(scan.running.file.nii.epi3.realignment{i_subject}{i_session},'mean'))) = []; % remove mean image
        end
    end
    
    % epi3 - normalisation
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.directory.nii.epi3.normalisation{i_subject}{i_session} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'normalisation',num2str(scan.parameter.analysis.voxs)));
            scan.running.file.nii.epi3.normalisation{i_subject}{i_session} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'normalisation',num2str(scan.parameter.analysis.voxs),'*.nii'),'absolute');
            scan.running.file.nii.epi3.normalisation{i_subject}{i_session}(cellfun(@isscalar,strfind(scan.running.file.nii.epi3.normalisation{i_subject}{i_session},'mean'))) = []; % remove mean image
        end
    end
    
    % epi3 - smooth
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.directory.nii.epi3.smooth{i_subject}{i_session} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'smooth',num2str(scan.parameter.analysis.voxs)));
            scan.running.file.nii.epi3.smooth{i_subject}{i_session} = file_list(fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'smooth',num2str(scan.parameter.analysis.voxs),'*.nii'),'absolute');
            scan.running.file.nii.epi3.smooth{i_subject}{i_session}(cellfun(@isscalar,strfind(scan.running.file.nii.epi3.smooth{i_subject}{i_session},'mean'))) = []; % remove mean image
        end
    end
end
