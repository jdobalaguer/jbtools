
function scan = scan_autocomplete_dicom(scan)
    %% scan = SCAN_AUTOCOMPLETE_DICOM(scan)
    % autocomplete [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % root
    for i_subject = 1:scan.running.subject.number
        subject = scan.running.subject.unique(i_subject);
        scan.running.directory.dicom.root{i_subject} = fullfile(scan.directory.dicom,scan.parameter.path.subject{subject});
    end
    
    % structural
    for i_subject = 1:scan.running.subject.number
        scan.running.directory.dicom.structural{i_subject} = file_endsep(fullfile(scan.running.directory.dicom.root{i_subject},'structural'));
        scan.running.file.dicom.structural{i_subject} = file_list(fullfile(scan.running.directory.dicom.structural{i_subject},'*.dcm'),'absolute');
    end
   
    % epi
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan.running.directory.dicom.epi{i_subject}{i_session} = file_endsep(fullfile(scan.running.directory.dicom.root{i_subject},'epi',scan.parameter.path.session{i_session}));
            scan.running.file.dicom.epi{i_subject}{i_session} = file_list(fullfile(scan.running.directory.dicom.epi{i_subject}{i_session},'*.dcm'),'absolute');
        end
    end
end
