
function scan = scan_preprocess_slicetime(scan)
    %% scan = SCAN_PREPROCESS_SLICETIME(scan)
    % slice-time correction
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.slicetime, return; end
    
    % print
    scan_tool_print(scan,false,'\nSlice-time correction : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % copy original files
        file_original  = cell(1,scan.running.subject.session(i_subject));
        file_slicetime = cell(1,scan.running.subject.session(i_subject));
        for i_session = 1:scan.running.subject.session(i_subject)
            file_original{i_session} = file_list(fullfile(scan.running.directory.nii.epi3.(scan.running.last.epi3){i_subject}{i_session},'*.nii'),'absolute');
            file_slicetime{i_session}   = strcat(scan.running.directory.nii.epi3.slicetime{i_subject}{i_session},file_2local(file_original{i_session}));
            cellfun(@copyfile,file_original{i_session},file_slicetime{i_session});
        end

        % slice-time correction
        spm{i_subject}.spm.temporal.st.scans    = file_slicetime;
        spm{i_subject}.spm.temporal.st.nslices  = scan.parameter.scanner.nslices;
        spm{i_subject}.spm.temporal.st.tr       = scan.parameter.scanner.tr;
        spm{i_subject}.spm.temporal.st.ta       = spm{i_subject}.spm.temporal.st.tr * (1 - 1/spm{i_subject}.spm.temporal.st.nslices);
        spm{i_subject}.spm.temporal.st.so       = scan.parameter.scanner.ordsl;
        spm{i_subject}.spm.temporal.st.refslice = spm{i_subject}.spm.temporal.st.nslices;
        
        % SPM
        eval('spm_jobman(''run'',spm(i_subject))');

        % delete original file
        for i_session = 1:scan.running.subject.session(i_subject)
            cellfun(@delete,file_slicetime{i_session});
        end
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.slicetime = spm;
    
    % update
    scan = scan_autocomplete_nii(scan,'epi3:slicetime');
    scan.running.last.epi3 = 'slicetime';
    
    % done
    scan = scan_tool_done(scan);
end
