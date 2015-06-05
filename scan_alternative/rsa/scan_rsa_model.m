
function scan = scan_rsa_model(scan)
    %% scan = SCAN_RSA_MODEL(scan)
    % build model RDM matrix
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.model, return; end
    
    % print
    scan_tool_print(scan,false,'\nBuild model : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % build model
    scan.running.model = {};
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            for i_model = 1:length(scan.job.model)
                
                % model
                scan.running.model{i_subject}{i_session}(i_model).model = scan.job.model(i_model).model;
                
                % column
                for i_name = 1:length(scan.job.model(i_model).name)
                    ii_subject = (scan.job.model(i_model).subject{i_name} == scan.running.subject.unique(i_subject));
                    ii_session = (scan.job.model(i_model).session{i_name} == i_session);
                    f_column = find(ii_subject & ii_session);
                    for i_column = 1:length(f_column)
                        column = struct('name',scan.job.model(i_model).name(i_name),'subject',{i_subject},'session',{i_session},'number',i_column,'onset',{scan.job.model(1).onset{i_name}(f_column(i_column))},'level',{struct()});
                        for i_level = 1:length(scan.job.model(i_model).level{i_name})
                            column.level.(matlab.lang.makeValidName(scan.job.model(i_model).subname{i_name}{i_level})) = scan.job.model(i_model).level{i_name}{i_level}(f_column(i_column));
                        end
                        scan.running.model{i_subject}{i_session}(i_model).column{i_name}(i_column) = column;
                    end
                end
                
                % RDM
                y = mat2vec([scan.running.model{i_subject}{i_session}(i_model).column{:}]);
                x = y';
                X = num2cell(repmat(x,[length(x),1]));
                Y = num2cell(repmat(y,[1,length(y)]));
                scan.running.model{i_subject}{i_session}(i_model).vector = double(squareform(cellfun(scan.job.model(i_model).function,X,Y)));
            end
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);

end
