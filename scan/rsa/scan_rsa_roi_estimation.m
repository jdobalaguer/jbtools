
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
    scan = scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % subject
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
        
            % get models
            u_model = nan(length(scan.running.model(1).rdm{i_subject}{i_session}.rdm),numel(scan.job.model));
            u_filter = false(size(u_model));
            for i_model = 1:numel(scan.job.model)
                u_model(:,i_model)  = scan.running.model(i_model).rdm{i_subject}{i_session}.rdm;
                u_filter(:,i_model) = scan.running.model(i_model).rdm{i_subject}{i_session}.filter;
            end

            % get beta
            beta = scan_tool_rsa_fMRIDataPreparation(scan,i_subject,i_session);

            % get mask
            mask = scan.running.mask(i_subject);
            mask.valid = false(size(mask.mask));
            mask.valid = mask.mask & all(beta,2) & all(~isnan(beta),2);
            beta = beta(mask.valid,:);

            % mahalanobis projection
            [X,Y] = mahalanobisProjection(scan,i_subject,i_session);

            % transformation
            beta = beta';
            beta = scan_tool_rsa_transformation(scan,beta);
            
            % build RDM
            rdm  = scan_tool_rsa_buildrdm(scan,beta,X,Y);
            % compare RDM with models
            [r,p] = scan_tool_rsa_comparison(scan,rdm,u_model,u_filter);
            scan.result.zero{i_subject}{i_session}.r = r;
            scan.result.zero{i_subject}{i_session}.p = p;
            
            % wait
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end

%% auxiliar: mahalanobisProjection
function [X,Y] = mahalanobisProjection(scan,i_subject,i_session)
    [X,Y] = deal([]);
    if ~strcmp(scan.job.distance,'mahalanobis'), return; end
    ii_session_column = (scan.running.glm.running.design(i_subject).column.session == i_session);
    ii_session_row    = (scan.running.glm.running.design(i_subject).row.session    == i_session);
    if scan.job.concatSessions, ii_session_column(:) = true; end
    if scan.job.concatSessions, ii_session_row(:) = true; end
    X = scan.running.glm.running.design(i_subject).matrix(ii_session_row,ii_session_column);
    Y = file_loadvar(fullfile(scan.directory.xY,sprintf('subject_%03i.mat',scan.running.subject.unique(i_subject))),'y');
    Y = Y(ii_session_row,:);
end
