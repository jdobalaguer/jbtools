
function scan_tool_physiological(scan,image,mask,file)
    %% SCAN_TOOL_PHYSIOLOGICAL(scan,image,mask,file)
    % extract the physiological from a region [mask] and save it in [file]
    % scan  : [scan] struct
    % image : string with the kind of epi3 image. one of {'image','slicetime','realignment','normalisation','smooth'}
    % mask  : string with the path to the mask volume, relative to [scan.directory.mask]
    % file  : string with the path where to save the regressor, relative to [scan.directory.regressor]
    
    %% function
    
    % auto-initialize
    if ~struct_isfield(scan,'scan.running.subject.session')
        scan = scan_initialize(scan);
    end
    
    % print
    scan_tool_print(scan,false,'\nPre-load physiological signal (image "%s", mask "%s") : ',image,mask);
    scan = scan_tool_progress(scan,sum(cellfun(@numel,scan.running.subject.session)));
    
    % autocomplete (nii)
    scan = scan_autocomplete_nii(scan,['epi3:',image]);
    
    % load mask
    mask = scan_nifti_load(fullfile(scan.directory.mask,mask));
    
    % load
    regressor = cell(1,length(scan.running.subject.number));
    parfor (i_subject = 1:scan.running.subject.number, mme_size())
        regressor{i_subject} = auxiliar(scan,i_subject,image,mask); %#ok<PFOUS>
    end
    scan = scan_tool_progress(scan,0);
    
    % save
    file_mkdir(file_parts(fullfile(scan.directory.regressor,file)));
    save(fullfile(scan.directory.regressor,file),'regressor');
    
end

%% auxiliar
function regressor = auxiliar(scan,i_subject,image,mask)
    [~,n_session] = numbers(scan.running.subject.session{i_subject});
    regressor = cell(1,n_session);
    for i_session = 1:n_session
        regressor{i_session} = cellfun(@nanmean,scan_nifti_load(scan.running.file.nii.epi3.(image){i_subject}{i_session},mask));
        scan = scan_tool_progress(scan,[]);
    end
end