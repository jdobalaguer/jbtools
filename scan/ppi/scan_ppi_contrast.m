
function scan = scan_ppi_contrast(scan)
    %% SCAN_PPI_CONTRAST()
    % create contrasts for PPI
    % see also scan_ppi_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*FPARK,*NASGU>
    
    %% FUNCTION
    
    for i_subject = 1:scan.subject.n
        n_bid = length(scan.ppi.variables.bid{i_subject});
        
        % load SPM
        subject = scan.subject.u(i_subject);
        file_SPM = sprintf('%ssub_%02i/SPM.mat',scan.dire.glm.firstlevel,subject);
        SPM = load(file_SPM,'SPM');
        SPM = SPM.SPM;
        
        for i_bid = 1:n_bid
            name_contrast = scan.ppi.variables.bid{i_subject}(i_bid).name;
            conv_contrast = zeros(1,size(SPM.xX.X,2));
            conv_contrast(scan.ppi.variables.bid{i_subject}(i_bid).bid) = +1;
            scan.glm.contrast{i_subject}{i_bid} = struct('name',name_contrast,'convec',conv_contrast,'sessrep','none');    
        end
    end
    
end
