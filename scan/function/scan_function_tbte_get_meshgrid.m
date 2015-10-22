
function scan = scan_function_tbte_get_meshgrid(scan)
    %% scan = SCAN_FUNCTION_TBTE_GET_MESHGRID(scan)
    % define the function @get.meshgrid
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.function,   return; end
    scan.function.get.meshgrid = @auxiliar_meshgrid;
end

%% auxiliar
function varargout = auxiliar_meshgrid(varargin)
    varargout = cell(1,nargin);
    if ~nargin, return; end
    assertStruct(varargin{1});
    tcan = varargin{1};
    if nargin<3 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'mesh = @meshgrid(scan,name,mask[,v1][,v2][,v3][,..])','This function loads the estimated betas within the region of interest [mask] for a particular regressor [name]. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. [v#] are vectors with integers that specifies how the data should be splitted (i.e. categorical regressors). the returning value [mesh] is a tensor of size [nsubject,nsession,nv1,nv2,..] with the average beta within the ROI for each combination.');
        return;
    end

    % default
    [name,mask] = varargin{2:3};
    vector = cellfun(@mat2vec,varargin(4:end),'UniformOutput',false);

    % assert
    if ~ischar(mask), auxiliar_meshgrid(tcan,'help'); return; end
    if ~ischar(name), auxiliar_meshgrid(tcan,'help'); return; end

    % get values
    for i_subject = 1:tcan.running.subject.number
        for i_session = 1:tcan.running.subject.session(i_subject)
            beta{i_subject}{i_session}    = tcan.function.get.beta(tcan,i_subject,i_session,1,name,mask);
            subject{i_subject}{i_session} = tcan.function.get.vector(tcan,i_subject,i_session,1,name,'subject');
            session{i_subject}{i_session} = tcan.function.get.vector(tcan,i_subject,i_session,1,name,'session');
            for i_vector = 1:length(vector)
                values{i_vector}{i_subject}{i_session} = tcan.function.get.vector(tcan,i_subject,i_session,[],name,vector{i_vector});
            end
        end
    end
    
    % flatten betas
    beta = cellfun(@(b)cat(1,b{:}),beta,'UniformOutput',false);
    beta = cat(1,beta{:});
    
    % flatten subject
    subject = cellfun(@(s)cat(1,s{:}),subject,'UniformOutput',false);
    subject = cat(1,subject{:});
    
    % flatten session
    session = cellfun(@(r)cat(1,r{:}),session,'UniformOutput',false);
    session = cat(1,session{:});
    
    % flatten vector
    for i_vector = 1:length(vector)
        values{i_vector} = cellfun(@(v)cat(1,v{:}),values{i_vector},'UniformOutput',false);
        values{i_vector} = cat(1,values{i_vector}{:});
    end

    % assert
    assertSize(beta(:,1),subject,session,values{:});
    
    % get rid of nans
    ii_nan = cellfun(@isnan,values,'UniformOutput',false);
    ii_nan = cat(2,ii_nan{:});
    ii_nan = any(ii_nan,2);
    beta(ii_nan,:)  = [];
    subject(ii_nan) = [];
    session(ii_nan) = [];
    for i_vector = 1:length(vector), values{i_vector}(ii_nan) = []; end

    % average across voxels
    beta = nanmean(beta,2);
    
    % get matrix
    mesh = getm_mean(beta,subject,session,values{:});

    % return
    varargout = {mesh};
end
