
function scan = scan_tool_zip(scan,mode,folder)
    %% scan = SCAN_TOOL_ZIP(scan,mode,folder)
    % zip/unzip folders
    % scan   : [scan] struct
    % mode   : string with mode (either 'zip' or 'unzip' or 'delete')
    % folder : folder to analyse (edit this file to see options)
    % to list main functions, try
    %   >> help scan;
    
    %% warning
    %#ok<*AGROW>
    
    %% function
    
    % variables
    directory = {};
    zip_file  = {};
    
    % auto-initialize
    if ~struct_isfield(scan,'directory'), scan = scan_initialize(scan); end
    
    % subject
    [u_subject,n_subject] = numbers(scan.running.subject.unique);
    for i_subject = 1:n_subject
        
        % session
        [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
        for i_session = 1:n_session
            
            % folder
            switch(folder)
                case 'dicom:structural'
                    directory{i_subject} = fullfile(scan.directory.dicom,scan.parameter.path.subject{u_subject(i_subject)},'structural');
                    zip_file{i_subject} = [directory{i_subject},'.zip'];
                    
                case 'dicom:epi'
                    directory{i_subject}{i_session} = fullfile(scan.directory.dicom,scan.parameter.path.subject{u_subject(i_subject)},'epi',scan.parameter.path.session{u_session(i_session)});
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];
                    
                case 'nii:structural:image'
                    directory{i_subject} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'structural','image');
                    zip_file{i_subject} = [directory{i_subject},'.zip'];

                case 'nii:structural:segmentation'
                    directory{i_subject} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'structural','segmentation');
                    zip_file{i_subject} = [directory{i_subject},'.zip'];

                case 'nii:structural:coregistration'
                    directory{i_subject} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'structural','coregistration');
                    zip_file{i_subject} = [directory{i_subject},'.zip'];

                case 'nii:structural:normalisation'
                    directory{i_subject} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'structural','normalisation',num2str(scan.parameter.analysis.voxs));
                    zip_file{i_subject} = [directory{i_subject},'.zip'];

                case 'nii:epi4'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'epi4',scan.parameter.path.session{u_session(i_session)});
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:image'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'epi3',scan.parameter.path.session{u_session(i_session)},'image');
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:slicetime'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'epi3',scan.parameter.path.session{u_session(i_session)},'slicetime');
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:realignment'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'epi3',scan.parameter.path.session{u_session(i_session)},'realignment');
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:normalisation'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'epi3',scan.parameter.path.session{u_session(i_session)},'normalisation',num2str(scan.parameter.analysis.voxs));
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:smooth'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{u_subject(i_subject)},'epi3',scan.parameter.path.session{u_session(i_session)},'smooth',num2str(scan.parameter.analysis.voxs));
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];
                    
                otherwise
                    scan_tool_error(scan,'unknown folder "%s"',folder);
            end
        end
    end
    
    % flat cell
    directory = cell_flat(directory);
    zip_file  = cell_flat(zip_file);
    
    % zip/unzip
    scan_tool_print(scan,false,'\nZip/Unzip : ');
    scan = scan_tool_progress(scan,length(directory));
    for i = 1:length(directory)
        try %#ok<TRYNC>
            switch mode
                case 'zip'
                    zip(zip_file{i},directory{i});
                case 'zip+delete'
                    zip(zip_file{i},directory{i});
                    file_rmdir(directory{i});
                case 'zip+delnii'
                    zip(zip_file{i},directory{i});
                    file_delete(fullfile(directory{i},'*.nii'));
                case 'unzip'
                    unzip(zip_file{i},fileparts(directory{i}));
                case 'unzip+delete'
                    unzip(zip_file{i},fileparts(directory{i}));
                    file_delete(zip_file{i});
                case 'deldir'
                    file_rmdir(file_match(directory{i},'absolute'));
                case 'delnii'
                    file_delete(fullfile(directory{i},'*.nii'));
                case 'delzip'
                    file_delete(file_match(zip_file{i},'absolute'));
                otherwise
                    scan_tool_error(scan,'unknown mode "%s"',mode);
            end
        end
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
end
