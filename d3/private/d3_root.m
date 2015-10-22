
function path = d3_root()
    %% path = D3_ROOT()
    % private function. returns root directory
    % see also d3_help
    
    %% function
    path = file_parts(which('d3_figure'));
end