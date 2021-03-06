
function scan = scan_autocomplete_nii(scan,folder)
    %% scan = SCAN_AUTOCOMPLETE_NII(scan,folder)
    % autocomplete [scan] struct
    % scan   : [scan] struct
    % folder : folder to analyse (edit this file to see options)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    switch(folder)
        case 'structural:image'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                scan.running.directory.nii.structural.image{i_subject} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'structural','image'));
                scan.running.file.nii.structural.image{i_subject} = file_match(fullfile(scan.running.directory.nii.structural.image{i_subject},'*.nii'),'absolute');
            end
            
        case 'structural:coregistration'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                scan.running.directory.nii.structural.coregistration{i_subject} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'structural','coregistration'));
                scan.running.file.nii.structural.coregistration{i_subject} = file_match(fullfile(scan.running.directory.nii.structural.coregistration{i_subject},'*.nii'),'absolute');
            end
    
        case 'structural:segmentation'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                scan.running.directory.nii.structural.segmentation{i_subject} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'structural','segmentation'));
                scan.running.file.nii.structural.segmentation.c{i_subject} = file_list (fullfile(scan.running.directory.nii.structural.segmentation{i_subject},'c*.nii'),'absolute');
                scan.running.file.nii.structural.segmentation.y{i_subject} = file_match(fullfile(scan.running.directory.nii.structural.segmentation{i_subject},'y*.nii'),'absolute');
                scan.running.file.nii.structural.segmentation.m{i_subject} = file_match(fullfile(scan.running.directory.nii.structural.segmentation{i_subject},'m*.nii'),'absolute');
            end
    
        case 'structural:normalisation'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                scan.running.directory.nii.structural.normalisation{i_subject} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'structural','normalisation',num2str(scan.parameter.analysis.voxs)));
                scan.running.file.nii.structural.normalisation{i_subject} = file_match(fullfile(scan.running.directory.nii.structural.normalisation{i_subject},'*.nii'),'absolute');
            end

        case 'epi4'
            for i_subject = 1:scan.running.subject.number
                [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
                for i_session = 1:n_session
                    subject = scan.running.subject.unique(i_subject);
                    scan.running.directory.nii.epi4{i_subject}{i_session} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi4',scan.parameter.path.session{u_session(i_session)}));
                    scan.running.file.nii.epi4{i_subject}{i_session} = file_match(fullfile(scan.running.directory.nii.epi4{i_subject}{i_session},'*.nii'),'absolute');
                end
            end

        case 'epi3:image'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
                for i_session = 1:n_session
                    scan.running.directory.nii.epi3.image{i_subject}{i_session} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi3',scan.parameter.path.session{u_session(i_session)},'image'));
                    scan.running.file.nii.epi3.image{i_subject}{i_session} = file_list(fullfile(scan.running.directory.nii.epi3.image{i_subject}{i_session},'*.nii'),'absolute');
                    scan.running.file.nii.epi3.image{i_subject}{i_session}(cellfun(@isscalar,strfind(scan.running.file.nii.epi3.image{i_subject}{i_session},'mean'))) = []; % remove mean image
                end
            end

        case 'epi3:slicetime'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
                for i_session = 1:n_session
                    scan.running.directory.nii.epi3.slicetime{i_subject}{i_session} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi3',scan.parameter.path.session{u_session(i_session)},'slicetime'));
                    scan.running.file.nii.epi3.slicetime{i_subject}{i_session} = file_list(fullfile(scan.running.directory.nii.epi3.slicetime{i_subject}{i_session},'*.nii'),'absolute');
                    scan.running.file.nii.epi3.slicetime{i_subject}{i_session}(cellfun(@isscalar,strfind(scan.running.file.nii.epi3.slicetime{i_subject}{i_session},'mean'))) = []; % remove mean image
                end
            end

        case 'epi3:realignment'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
                for i_session = 1:n_session
                    scan.running.directory.nii.epi3.realignment{i_subject}{i_session} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi3',scan.parameter.path.session{u_session(i_session)},'realignment'));
                    scan.running.file.nii.epi3.realignment{i_subject}{i_session} = file_list(fullfile(scan.running.directory.nii.epi3.realignment{i_subject}{i_session},'*.nii'),'absolute');
                    scan.running.file.nii.epi3.realignment{i_subject}{i_session}(cellfun(@isscalar,strfind(scan.running.file.nii.epi3.realignment{i_subject}{i_session},'mean'))) = []; % remove mean image
                end
            end

        case 'epi3:normalisation'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
                for i_session = 1:n_session
                    scan.running.directory.nii.epi3.normalisation{i_subject}{i_session} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi3',scan.parameter.path.session{u_session(i_session)},'normalisation',num2str(scan.parameter.analysis.voxs)));
                    scan.running.file.nii.epi3.normalisation{i_subject}{i_session} = file_list(fullfile(scan.running.directory.nii.epi3.normalisation{i_subject}{i_session},'*.nii'),'absolute');
                    scan.running.file.nii.epi3.normalisation{i_subject}{i_session}(cellfun(@isscalar,strfind(scan.running.file.nii.epi3.normalisation{i_subject}{i_session},'mean'))) = []; % remove mean image
                end
            end

        case 'epi3:smooth'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
                for i_session = 1:n_session
                    scan.running.directory.nii.epi3.smooth{i_subject}{i_session} = file_endsep(fullfile(scan.directory.nii,scan.parameter.path.subject{subject},'epi3',scan.parameter.path.session{u_session(i_session)},'smooth',num2str(scan.parameter.analysis.voxs),num2str(unique(spm_get_defaults('smooth.fwhm')))));
                    scan.running.file.nii.epi3.smooth{i_subject}{i_session} = file_list(fullfile(scan.running.directory.nii.epi3.smooth{i_subject}{i_session},'*.nii'),'absolute');
                    scan.running.file.nii.epi3.smooth{i_subject}{i_session}(cellfun(@isscalar,strfind(scan.running.file.nii.epi3.smooth{i_subject}{i_session},'mean'))) = []; % remove mean image
                end
            end
            
        case 'residual'
            for i_subject = 1:scan.running.subject.number
                subject = scan.running.subject.unique(i_subject);
                scan.running.file.residual.ms{i_subject}      = fullfile(scan.running.directory.copy.first.residual,sprintf('subject_%03i_MS.nii',subject));
                scan.running.file.residual.volumes{i_subject} = file_list(fullfile(scan.running.directory.copy.first.residual,sprintf('subject_%03i_*.nii',subject)),'absolute');
                scan.running.file.residual.volumes{i_subject}(strcmp(scan.running.file.residual.volumes{i_subject},scan.running.file.residual.ms{i_subject})) = []; % remove MS file
            end
            
        otherwise
            scan_tool_error(scan,'unknown folder "%s"',folder);
    end
end
