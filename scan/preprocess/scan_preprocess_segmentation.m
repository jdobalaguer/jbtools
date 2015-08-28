
function scan = scan_preprocess_segmentation(scan)
    %% scan = SCAN_PREPROCESS_SEGMENTATION(scan)
    % run the segmentation before the normalisation
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.segmentation, return; end
    
    % print
    scan_tool_print(scan,false,'\nSegmentation : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    spm = cell(1,scan.running.subject.number);
    for i_subject = 1:scan.running.subject.number
        
        % variables
        file_origin        = scan.running.file.nii.structural.(scan.running.last.structural){i_subject};
        file_segmentation = fullfile(scan.running.directory.nii.structural.segmentation{i_subject},file_2local(file_origin));
        
        % copy original file
        copyfile(file_origin,file_segmentation);
        
        % normalisation
        spm{i_subject}.spm.spatial.preproc.channel.vols  = {[file_segmentation,',1']};
        spm{i_subject}.spm.spatial.preproc.channel.write = [0,1];
        spm{i_subject}.spm.spatial.preproc.warp.write    = [0,1];
        
        % SPM
        evalc('spm_jobman(''run'',spm(i_subject))');
        
        % delete original file
        delete(file_segmentation);
        
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    scan.running.jobs.segmentation = spm;
    
    % update
    scan = scan_autocomplete_nii(scan,'structural:segmentation');
    scan.running.last.structural = 'segmentation';
    
    % done
    scan = scan_tool_done(scan);
end
