
function scan_tool_xY(scan)
    %% SCAN_TOOL_XY(scan)
    % extract the SPM.xY.VY data and save it in files within [scan.directory.xy]
    % (these files will be used for the RSA mahalanobis distance)
    
    %% function
    
    % print
    scan_tool_print(scan,false,'\nSave xY : ');
    scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    for i_subject = 1:scan.running.subject.number
        % load SPM
        SPM = file_loadvar(fullfile(scan.running.directory.copy.first.spm,sprintf('subject_%03i',scan.running.subject.unique(i_subject)),'SPM.mat'),'SPM');
        
        % create y
        xY = cell2mat(arrayfun(@(x)reshape(double(x.private.dat),[1,size(x.private.dat)]),SPM.xY.VY,'UniformOutput',false));
        
        % save
        file_mkdir(scan.directory.xY);
        file_savevar(fullfile(scan.directory.xY,sprintf('subject_%03i.mat',scan.running.subject.unique(i_subject))),[],'xY',xY);
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
end
