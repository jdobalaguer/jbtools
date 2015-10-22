
function [path,fid,found] = d3_func_file(d3,request)
    %% [d3,response] = D3_FUNC_FILE(d3,request)
    % private function. default return response for a particular request
    % see also d3_help
    
    %% function
    
    % requested file
    if(struct_isfield(request,'Get.Filename'))
        file = request.Get.Filename;
    elseif(struct_isfield(request,'Post.Filename'))
        file = request.Post.Filename;
    else
        % no file requested
        warning('Unknown Type of Request');
        return;
    end
    
    % remove GET variables
    if any(file=='?'), file(find(file=='?',1,'first'):end) = []; end
    
    % if root, send to default file
    if(strcmp(file,'/')), file  = d3.opts.defaultfile; end
    
    % set path
    path = fullfile(d3.opts.www_folder,file);
    fid = fopen(path,'r');
    if(fid<0)
        % cannot read
        file = d3.opts.defaultnone;
        found = false;
        path = fullfile(d3.opts.www_folder,file);
        fid = fopen(path,'r');
    else
        % file succesfully opened
        found = true;
    end
end
