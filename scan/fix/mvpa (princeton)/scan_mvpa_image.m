
function scan = scan_mvpa_image(scan)
    %% SCAN_MVPA_IMAGE()
    % load the images for the multi-voxel pattern analysis
    % see also scan_mvpa_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*FPARK,*ERTAG>
    
    %% FUNCTION
    
    % set folder
    switch scan.mvpa.source
        case 'beta'
            folder = scan.dire.glm.beta1;
        case 'cont'
            folder = scan.dire.glm.contrast1;
        case 'spmT'
            folder = scan.dire.glm.statistic1;
        otherwise
            error('scan_mvpa_image: error. source "%s" unknown',scan.mvpa.source);
    end
        
    for i_subject = 1:scan.subject.n
        
        % get file pattern
        dire_pattern = dir([folder,scan.mvpa.image,'*_001']);
        file_pattern = struct('name',{},'date',{},'bytes',{},'isdir',{},'datenum',{});
        for i_dire = 1:length(dire_pattern)
            poss_pattern = dir(sprintf('%s%s/*_sub%02i*.img',folder,dire_pattern(i_dire).name,scan.subject.u(i_subject)));
            if ~isempty(poss_pattern),  file_pattern(i_dire) = poss_pattern;
            else                        dire_pattern(i_dire:end) = [];
                                        break;
            end
        end
        file_pattern = cellstr(strcat(folder,strvcat(dire_pattern.name),filesep,strvcat(file_pattern.name)));
        
        % discard trials
        ii_subject = (scan.mvpa.regressor.subject == scan.subject.u(i_subject));
        ii_discard = scan.mvpa.regressor.discard;
        file_pattern(ii_discard(ii_subject)) = [];
        
        % set subject
        scan.mvpa.subject(i_subject) = load_spm_pattern(scan.mvpa.subject(i_subject),scan.mvpa.variable.pattern,scan.mvpa.variable.mask,file_pattern);
        scan.mvpa.nscans(i_subject)  = size(file_pattern,1);
        
    end

end
