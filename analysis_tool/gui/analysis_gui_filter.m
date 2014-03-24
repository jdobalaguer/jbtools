% ANALYSIS internal script

%% gui
classdef analysis_gui_filter < handle
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
        function obj = analysis_gui_filter(a)
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
                                a.par.size_panellabel + 2*a.par.size_label(2) + a.par.size_listbox(2) + 4*a.par.size_space];
        end
        
        %% create panel
        function create_panel(obj,a)
            obj.panel = uipanel(...
                'Parent',a.obj.window.window,...
                'Title',' FILTER ',...
                'BackgroundColor',a.par.win_background,...
                'Units','pixels',...
                'Position',[obj.position obj.size]);
        end
        
        %% create objects
        function create_objects(obj,a)
            obj.objects = struct();
            
            % list
            item_size = [   obj.size(1) - 2*a.par.size_space, ...
                            a.par.size_listbox(2) ];
            item_pos =  [   a.par.size_space...
                            obj.size(2) - a.par.size_panellabel - a.par.size_space - item_size(2) ];
            obj.objects.list = uicontrol(...
                'Parent',obj.panel,...
                'BackgroundColor',a.par.win_background,...
                'Style','popup',...
                'Enable','off',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'HorizontalAlignment','left',...
                'String', ' ');
            
            % min label
            item_size = a.par.size_label;
            item_pos =  [   a.par.size_space ...
                            item_pos(2) - a.par.size_space-a.par.size_label(2) ];
            obj.objects.minlabel = uicontrol(...
                'Parent',obj.panel,...
                'BackgroundColor',a.par.win_background,...
                'Style','pushbutton',...
                'Enable','off',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'HorizontalAlignment','left',...
                'String', 'min');

            % min edit
            item_pos(1)  = item_pos(1) + item_size(1) + a.par.size_space;
            item_size(1) = obj.size(1) - 3*a.par.size_space - item_size(1);
            obj.objects.minedit = uicontrol(...
                'Parent',obj.panel,...
                'Style','edit',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'String', {' '});

            % max label
            item_size = a.par.size_label;
            item_pos =  [   a.par.size_space ...
                            item_pos(2) - a.par.size_space-a.par.size_label(2) ];
            obj.objects.maxlabel = uicontrol(...
                'Parent',obj.panel,...
                'BackgroundColor',a.par.win_background,...
                'Style','pushbutton',...
                'Enable','off',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'HorizontalAlignment','left',...
                'String', 'max');
            
            % max edit
            item_pos(1) =  item_pos(1) + item_size(1) + a.par.size_space;
            item_size(1) = obj.size(1) - 3*a.par.size_space - item_size(1);
            obj.objects.maxedit = uicontrol(...
                'Parent',obj.panel,...
                'Style','edit',...
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
                fields = evalin('base',sprintf('fieldnames(%s)',sdata{1}));
            end
            if isempty(fields)
                set(obj.objects.list,'Value',1);
                set(obj.objects.list,'String',' ');
                set(obj.objects.list,'Enable','off');
            else
                fields{end+1} = 'none';
                set(obj.objects.list,'Value',length(fields));
                set(obj.objects.list,'String',fields);
                set(obj.objects.list,'Enable','on');
            end
        end
        
        %% reposition
        function reposition(obj,a)
            previous_height = a.obj.axis.position(2);
            height          = previous_height - obj.size(2);
            obj.set_position([obj.position(1),height]);
        end
    end
end
