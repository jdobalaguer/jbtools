
function scan = scan_rsa_roi_estimation(scan)
    %% scan = SCAN_RSA_ROI_ESTIMATION(scan)
    % RSA estimation (roi)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.estimation, return; end
    
    % print
    scan_tool_print(scan,false,'\nRSA estimation : ');
    scan = scan_tool_progress(scan,sum(cellfun(@numel,scan.running.subject.session)));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
        for i_session = 1:n_session
        
            % get models
            u_model = nan(length(scan.running.model(1).rdm{i_subject}{i_session}.rdm),numel(scan.job.model));
            u_filter = false(size(u_model));
            for i_model = 1:numel(scan.job.model)
                u_model(:,i_model)  = scan.running.model(i_model).rdm{i_subject}{i_session}.rdm;
                u_filter(:,i_model) = scan.running.model(i_model).rdm{i_subject}{i_session}.filter;
            end

            % get beta
            beta = scan_tool_rsa_fMRIDataPreparation(scan,scan.running.subject.unique(i_subject),u_session(i_session));

            % get mask
            mask = scan.running.mask(i_subject);
            mask.valid = false(size(mask.mask));
            mask.valid = mask.mask & all(beta,2) & all(~isnan(beta),2);
            beta = beta(mask.valid,:);
            beta = beta';

            % whitening
            if scan.job.whitening
                R = getResiduals(scan,i_subject,mask);
                beta = scan_tool_rsa_whitening(scan,beta,R,i_subject,i_session);
            end

            % build RDM and compare it with models
            beta = scan_tool_rsa_transformation(scan,beta);
            rdm  = scan_tool_rsa_buildrdm(scan,beta,i_subject,i_session);
            [r,p] = scan_tool_rsa_comparison(scan,rdm,u_model,u_filter);
            
            % save
            scan.result.zero{i_subject}{i_session}.r = r;
            scan.result.zero{i_subject}{i_session}.p = p;
            if scan.job.saveRDM, scan.result.rdm{i_subject}{i_session} = rdm; end
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end

%% auxiliar: getResiduals
function R = getResiduals(scan,i_subject,mask)
    R = {};
    if ~scan.job.whitening, return; end
    R = scan_nifti_load(scan.running.glm.running.file.residual.volumes{i_subject},mask.valid);
    R = cat(2,R{:})';
    u_session = unique(scan.running.glm.running.subject.session{i_subject});
    R = mat2cell(R,arrayfun(@(s)sum(scan.running.glm.running.design(i_subject).row.session==s),u_session),size(R,2));
end
