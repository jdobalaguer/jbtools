function class = func_is(func)
    %% class = FUNC_IS(func)
    % checks the nature of a function
    % func  : file / function handle
    % class : description of the function

    %% adapted from..
    % ISFUNCTION - true for valid matlab functions
    % version 3.1 (feb 2014)
    % (c) Jos van der Geest
    % email: jos@jasen.nl

    %% function
    class = local_isfunction(func);
end

%% auxiliar
function class = local_isfunction(FUNNAME)
    try    
        nargin(FUNNAME); % nargin errors when FUNNAME is not a function
        if isa(FUNNAME,'function_handle')
            class = 'function handle';
        else
            class = 'function filename';
        end
    catch ME
        switch (ME.identifier)        
            case 'MATLAB:nargin:isScript',                  class = 'script filename';
            case 'MATLAB:narginout:notValidMfile',          class = 'error: not valid';
            case 'MATLAB:narginout:functionDoesnotExist',   class = 'error: doesnt exist';
            case 'MATLAB:narginout:BadInput',               class = 'error: bad input (or a variable)';
            otherwise,                                      class = 'error: unknown';
        end
    end
end
