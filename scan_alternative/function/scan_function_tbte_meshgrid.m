
function scan = scan_function_tbte_meshgrid(scan)
    %% scan = SCAN_FUNCTION_TBTE_MESHGRID(scan)
    % define "meshgrid" function
    % to list main functions, try
    %   >> help scan;
    
    %% notes
    % 1. this function calls function @roi, which loads all onsets rather than only the one of interest. so, it's far from efficient..
    % 2. it always takes the columns with first order (whatever that order is)

    %% function
    if ~scan.running.flag.function,   return; end
    
    scan_tool_print(scan,false,'\nAdd function (meshgrid) : ');
    scan.function.meshgrid = @auxiliar_meshgrid;
    
    %% nested
    function varargout = auxiliar_meshgrid(varargin)
        varargout = {};
        if nargin<2 || strcmp(varargin{1},'help')
            scan_tool_help('mesh = @meshgrid(mask,main,subject,session,vector1,vector2,vector3,...)','This function loads the estimated betas within the region of interest for a particular kind of onset [main]. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. ''onset'' is a string corresponding to a kind of onset in {scan.running.design.column.main}. [subject], [session] and [vector#] are vectors with integers that specifies how the data should be splitted. the returning value [mesh] is a tensor of size [nsubject,nsession,nvector1,nvector2,..] with the average beta within the ROI for each combination. If no subject/session/vector is specified, all beta patterns are returned within a vector.');
            return;
        end
        
        % default
        [mask,main,subject,session] = deal(varargin{1:4});
        vector = varargin(5:end);
        if    ~isempty(subject) && ~isempty(session) && ~isempty(vector)
            assertSize(subject,session,vector{:});
            vector = cell2mat(cellfun(@mat2vec,vector,'UniformOutput',false));
        elseif isempty(subject) &&  isempty(session) &&  isempty(vector)
            subject = mat2vec(scan.job.condition(strcmp(main,{scan.job.condition.name})).subject);
            session = mat2vec(scan.job.condition(strcmp(main,{scan.job.condition.name})).session);
            vector  = mat2vec(get_count(subject,session));
        else
            auxiliar_meshgrid('help');
            return;
        end
        
        % assert
        if ~ischar(mask), auxiliar_meshgrid('help'); return; end
        if ~ischar(main), auxiliar_meshgrid('help'); return; end
        
        % get values
        roi = scan.function.roi(mask);
        roi = roi.(main);
        for i_subject = 1:scan.running.subject.number
            ii_subject = (subject == scan.running.subject.unique(i_subject));
            for i_session = 1:scan.running.subject.session(i_subject)
                ii_session = (session == i_session);
                t_vector(ii_subject & ii_session,:)
                beta = roi(:,1,i_session,:)
            end
        end
    end
end
