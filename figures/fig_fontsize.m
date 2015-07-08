    

function fig_fontsize(cf,fs)
    %% fig_fontsize(cf)
    % set font size for all text in figure [cf]
    
    %% default
    if ~exist('cf','var')||isempty(cf); cf=gcf();   end
    if ~exist('fs','var')||isempty(fs); fs=24; end
    
    %% text
    labelText(cf,'FontSize',fs);

end

function h = labelText(varargin)
    %% labelText
    % labelText(handle) returns handles to all the labels in children of the given handles.
    % If there are titles, axis labels, etc., it returns those also.
    %
    % labelText(handle,'Prop1','Val1',...) sets the values of the specified properties.
    %
    % if handle is omitted, the current figure is used.
    
    %% default
    if (~nargin)||(ischar(varargin{1}))
        parent = gcf;
        args = varargin;
    else
        parent = varargin{1};
        args = varargin(2:end);
    end;

    %% set
    ah = findobj(parent,'Type','axes');
    th = get(ah,'Title');
    xh = get(ah,'XLabel');
    yh = get(ah,'YLabel');
    sh = findobj(parent,'Type','text');
    if (length(ah) > 1) h = [ah',cat(1,th{:})',cat(1,xh{:})',cat(1,yh{:})',sh'];
    else                h = [ah',th',xh',yh',sh'];
    end;
    if ~isempty(args); set(h,args{:}); end
end
