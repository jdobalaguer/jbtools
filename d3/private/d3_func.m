
function [d3,response] = d3_func(d3,request)
    %% [d3,response] = D3_FUNC(d3,request)
    % private function. default return response for a particular request
    % see also d3_help
    
    %% warnings
    %#ok<*NASGU>
    
    %% function
    
    % open file
    [path,fid,found] = d3_func_file(d3,request);
    [d3,response] = d3_func_response(d3,path,fid,found);
end
