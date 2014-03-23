% 
% ANALYSIS
%
% graphical toolbox for behavioural analysis and plot
% >> analysis();

function analysis(varargin)
    delete(get(0,'Children')); % close every figure open
    a = analysis_class(varargin);
end
