% ANALYSIS internal script

%% gui
classdef analysis_gui_axis < handle
    %% properties
    properties
        analysis
        position
        size
        panel
        objects
    end
    
    %% methods
    methods
        %% constructor
        function obj = analysis_gui_axis(a)
            obj.analysis = a;
            obj.set_position([0,0]);
            obj.set_size(a);
            obj.create_panel(a);
            obj.create_objects(a);
            set(a.obj.sdata.objects.list,'Callback',@obj.refresh);
        end
        
        %% set position
        function set_position(obj,position)
            obj.position = position;
            if ~isempty(obj.panel)
                set(obj.panel,'Position',[obj.position obj.size]);
            end
        end
        
        %% set size
        function set_size(obj,a)
            obj.size     = [    a.par.win_size(1),...
                                a.par.size_panellabel + 2*a.par.size_listbox(2) + 3*a.par.size_space];
        end
        
        %% create panel
        function create_panel(obj,a)
            obj.panel = uipanel(...
                'Parent',a.obj.window.window,...
                'Title',' AXIS ',...
                'BackgroundColor',a.par.win_background,...
                'Units','pixels',...
                'Position',[obj.position obj.size]);
        end
        
        %% create objects
        function create_objects(obj,a)
            obj.objects = struct();
            
            % x label
            item_size = a.par.size_label;
            item_pos =  [   a.par.size_space...
                            obj.size(2) - a.par.size_panellabel - a.par.size_space - item_size(2) ];
            obj.objects.xlabel = uicontrol(...
                'Parent',obj.panel,...
                'BackgroundColor',a.par.win_background,...
                'Style','pushbutton',...
                'Enable','off',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'HorizontalAlignment','left',...
                'String', 'x');

            % x list
            item_pos(1)  = item_pos(1) + item_size(1) + a.par.size_space;
            item_size(1) = obj.size(1) - 3*a.par.size_space - item_size(1);
            obj.objects.xlist = uicontrol(...
                'Parent',obj.panel,...
                'Style','popup',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'String', {' '});

            % y label
            item_size = a.par.size_label;
            item_pos =  [   a.par.size_space ...
                            item_pos(2) - a.par.size_space-a.par.size_label(2) ];
            obj.objects.ylabel = uicontrol(...
                'Parent',obj.panel,...
                'BackgroundColor',a.par.win_background,...
                'Style','pushbutton',...
                'Enable','off',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'HorizontalAlignment','left',...
                'String', 'y');
            
            % y list
            item_pos(1) =  item_pos(1) + item_size(1) + a.par.size_space;
            item_size(1) = obj.size(1) - 3*a.par.size_space - item_size(1);
            obj.objects.ylist = uicontrol(...
                'Parent',obj.panel,...
                'Style','popup',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'String', {' '});

        end
        
        %% refresh
        function refresh(obj,~,~)
            u_sdata = get(obj.analysis.obj.sdata.objects.list,'String');
            i_sdata = get(obj.analysis.obj.sdata.objects.list,'Value');
            sdata   = u_sdata(i_sdata);
            if strcmp(sdata,' ')
                fields = {};
            else
                fields = evalin('base',sprintf('fieldnames(%s);',sdata{1}));
            end
            if isempty(fields)
                set(obj.objects.xlist,'Value',1);
                set(obj.objects.ylist,'Value',1);
                set(obj.objects.xlist,'String',' ');
                set(obj.objects.ylist,'String',' ');
                set(obj.objects.xlist,'Enable','off');
                set(obj.objects.ylist,'Enable','off');
            else
                set(obj.objects.xlist,'Value',1);
                set(obj.objects.ylist,'Value',1);
                set(obj.objects.xlist,'String',fields);
                set(obj.objects.ylist,'String',fields);
                set(obj.objects.xlist,'Enable','on');
                set(obj.objects.ylist,'Enable','on');
            end
        end
        
        %% reposition
        function reposition(obj,a)
            previous_height = a.obj.sdata.position(2);
            height          = previous_height - obj.size(2);
            obj.set_position([obj.position(1),height]);
        end
    end
end
