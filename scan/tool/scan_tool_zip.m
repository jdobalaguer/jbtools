
function scan_tool_zip(scan,mode,folder)
    %% SCAN_TOOL_ZIP(scan,mode,folder)
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
    for i_subject = 1:length(scan.subject.session)
        
        % session
        for i_session = 1:scan.subject.session(i_subject)
            
            % folder
            switch(folder)
                case 'dicom:structural'
                    directory{i_subject} = fullfile(scan.directory.dicom,scan.parameter.path.subject{i_subject},'structural');
                    zip_file{i_subject} = [directory{i_subject},'.zip'];
                case 'dicom:epi'
                    directory{i_subject}{i_session} = fullfile(scan.directory.dicom,scan.parameter.path.subject{i_subject},'epi',scan.parameter.path.session{i_session});
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];
                case 'nii:structural:image'
                    directory{i_subject} = fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','image');
                    zip_file{i_subject} = [directory{i_subject},'.zip'];

                case 'nii:structural:coregistration'
                    directory{i_subject} = fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','coregistration');
                    zip_file{i_subject} = [directory{i_subject},'.zip'];

                case 'nii:structural:normalisation'
                    directory{i_subject} = fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'structural','normalisation',num2str(scan.parameter.analysis.voxs));
                    zip_file{i_subject} = [directory{i_subject},'.zip'];

                case 'nii:epi4'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi4',scan.parameter.path.session{i_session});
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:image'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'image');
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:slicetime'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'slicetime');
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:realignment'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'realignment');
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:normalisation'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'normalisation',num2str(scan.parameter.analysis.voxs));
                    zip_file{i_subject}{i_session} = [directory{i_subject}{i_session},'.zip'];

                case 'nii:epi3:smooth'
                    directory{i_subject}{i_session} = fullfile(scan.directory.nii,scan.parameter.path.subject{i_subject},'epi3',scan.parameter.path.session{i_session},'smooth',num2str(scan.parameter.analysis.voxs));
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
        switch mode
            case 'zip'
                zip(zip_file{i},directory{i});
                file_rmdir(directory{i});
            case 'unzip'
                unzip(zip_file{i},fileparts(directory{i}));
%                 delete(zip_file{i});
            case 'delete'
                file_rmdir(file_match(directory{i},'absolute'));
                delete(file_match(zip_file{i},'absolute'));
            otherwise
                scan_tool_error(scan,'unknown mode "%s"',mode);
        end
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
end
