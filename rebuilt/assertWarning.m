
function assertWarning(varargin)
%ASSERTWARNING Generate a warning when a condition is violated.
%   ASSERTWARNING(EXPRESSION) evaluates EXPRESSION and, if it is false, displays the
%   warning message 'Assertion Failed'.
%
%   ASSERTWARNING(EXPRESSION, ERRMSG) evaluates EXPRESSION and, if it is false,
%   displays the string contained in ERRMSG. When ERRMSG is the last input to
%   ASSERTWARNING, MATLAB displays it literally, without performing any substitutions
%   on the characters in ERRMSG.
%
%   ASSERTWARNING(EXPRESSION, ERRMSG, VALUE1, VALUE2, ...) evaluates EXPRESSION and, if
%   it is false, displays the formatted string contained in ERRMSG. The ERRMSG
%   string can include escape sequences such as \t or \n as well as any of the C
%   language conversion specifiers supported by the SPRINTF function (e.g., %s
%   or %d). Additional arguments VALUE1, VALUE2, etc. provide values that
%   correspond to the format specifiers and are only required when the ERRMSG
%   string includes conversion specifiers.
%
%   MATLAB makes substitutions for escape sequences and conversion specifiers in
%   ERRMSG in the same way that it does for the SPRINTF function. Type HELP SPRINTF
%   for more information on escape sequences and format specifiers.
%   
%   See also error, sprintf


    %% WARNINGS
    %#ok<*WNTAG,*SPWRN>
    
    %% FUNCTION
    assert(islogical(varargin{1}),'The condition input argument must be a scalar logical.');
    if varargin{1}, return; end
    switch nargin
        case 1
            cprintf([1,0.5,0],'Assertion failed.');
        case 2
            cprintf([1,0.5,0],varargin{2});
        otherwise
            cprintf([1,0.5,0],varargin{2:end});
    end
    fprintf('\n');
end