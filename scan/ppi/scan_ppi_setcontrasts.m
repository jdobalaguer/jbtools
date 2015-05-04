
function scan = scan_ppi_setcontrasts(scan)
    %% SCAN_PPI_SETCONTRASTS()
    % create contrasts for PPI
    % see also scan_ppi_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*FPARK,*NASGU>
    
    %% ASSERT
    assert(strcmp(scan.glm.function,'hrf'));
    assert(all(scan.glm.hrf.ord==[0,0]));

    %% FUNCTION
    if ~scan.ppi.do.firstlevel, return; end
    
    for i_subject = 1:scan.subject.n
        n_bid = length(scan.ppi.variables.bid{i_subject});
        
        % load SPM
        subject = scan.subject.u(i_subject);
        file_SPM = sprintf('%ssub_%02i/SPM.mat',scan.dire.glm.firstlevel,subject);
        SPM = load(file_SPM,'SPM');
        SPM = SPM.SPM;
        
        % generic contrasts
        if scan.ppi.contrasts.generic
            for i_bid = 1:n_bid
                name_contrast = scan.ppi.variables.bid{i_subject}(i_bid).name;
                conv_contrast = zeros(1,size(SPM.xX.X,2));
                conv_contrast(scan.ppi.variables.bid{i_subject}(i_bid).bid) = +1;
                scan.glm.contrast{i_subject}{end+1} = struct('name',name_contrast,'convec',conv_contrast,'sessrep','none');    
            end
        end
        
        % extra contrasts
        for i_contrast = 1:length(scan.ppi.contrasts.extra)
            contrast = scan.ppi.contrasts.extra(i_contrast);
            name_contrast = contrast.name;
            conv_contrast = zeros(1,size(SPM.xX.X,2));
            for i_regressor = 1:length(scan.ppi.contrasts.extra(i_contrast).regressor)
                for i_ppi = 1:length(scan.ppi.variables.bid{i_subject})
                    regressor = contrast.regressor{i_regressor};
                    ppi       = scan.ppi.variables.bid{i_subject}(i_ppi);
                    if strcmp(regressor,ppi.name)
                        conv_contrast(ppi.bid) = contrast.weight(i_regressor);
                    end
                end
            end
            scan.glm.contrast{i_subject}{end+1} = struct('name',name_contrast,'convec',conv_contrast,'sessrep','none');
        end
    end
    
end
