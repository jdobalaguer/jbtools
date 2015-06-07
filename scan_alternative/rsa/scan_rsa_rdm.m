
function scan = scan_rsa_rdm(scan)
    %% scan = SCAN_RSA_RDM(scan)
    % build representation dissimilarity matrix
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.rdm, return; end
    
    % print
    scan_tool_print(scan,false,'\nBuild RDM : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % build the rdm
    scan.running.rdm = {};
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            for i_mask = 1:length(scan.running.mask)
                % rdm
                switch scan.job.distance
                    case 'function_handle'
                        scan.running.rdm{i_subject}{i_session}(i_mask).vector = pdist(scan.running.bm{i_subject}{i_session}(i_mask).matrix',scan.job.distance);
                    case 'char'
                        switch scan.job.distance
                            case {'euclidean','seuclidean','cityblock''minkowski','chebychev','mahalanobis','cosine','correlation','spearman','hamming','jaccard'}
                                scan.running.rdm{i_subject}{i_session}(i_mask).vector = pdist(scan.running.bm{i_subject}{i_session}(i_mask).matrix',scan.job.distance);
                            case {'linear0','linear1'}
                                scan_tool_error('distance "%s" has not been implemented yet',scan.job.distance);
                            otherwise
                                scan_tool_error('distance "%s" is not valid',scan.job.distance);
                        end
                    otherwise
                        scan_tool_error('[scan.job.distance] must be of class "char" or "function_handle"');
                end
                % column
                scan.running.rdm{i_subject}{i_session}(i_mask).column = scan.running.bm{i_subject}{i_session}(i_mask).column;
            end
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);

end
