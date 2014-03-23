% ANALYSIS internal script

%% gui
classdef analysis_gui_sdata < handle
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
        function obj = analysis_gui_sdata(a)
            obj.analysis = a;
            obj.set_position([0,0]);
            obj.set_size(a);
            obj.create_panel(a);
            obj.create_objects(a);
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
            obj.size     = [    a.gui.win_size(1),...
                                a.gui.size_panellabel + a.gui.size_pushbutton(2) + 2*a.gui.size_space];
        end
        
        %% create panel
        function create_panel(obj,a)
            obj.panel = uipanel(...
                'Parent',a.obj.window.window,...
                'Title',' SDATA ',...
                'BackgroundColor',a.gui.win_background,...
                'Units','pixels',...
                'Position',[obj.position obj.size]);
        end
        
        %% create objects
        function create_objects(obj,a)
            obj.objects = struct();
            
            % list
            item_pos =  [   a.gui.size_space...
                            a.gui.size_space];
            item_size = [   obj.size(1)-3*a.gui.size_space-a.gui.size_pushbutton(1)...
                            a.gui.size_pushbutton(2) ];
            obj.objects.list = uicontrol(...
                'Parent',   obj.panel,...
                'Style',    'popup',...
                'Units',    'pixel',...
                'Position', [item_pos item_size],...
                'String',   {' '});

            % refresh
            item_pos = [item_pos(1)+item_size(1)+a.gui.size_space item_pos(2)];
            item_size = a.gui.size_pushbutton;
            obj.objects.refresh = uicontrol(...
                'Parent',obj.panel,...
                'Style','pushbutton',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'Visible','on',...
                'String','refresh',...
                'Callback', @obj.refresh);
        end
        
        %% refresh
        function refresh(obj,~,~)
            string = evalin('base','who()');
            string(strcmp(string,'ans')) = [];
            if isempty(string)
                set(obj.objects.list,'String',' ');
                set(obj.objects.list,'Enable','off');
            else
                set(obj.objects.list,'String',string);
                set(obj.objects.list,'Enable','on');
            end
            obj.analysis.obj.axis.refresh();
        end
        
        %% reposition
        function reposition(obj,a)
            previous_height = a.obj.figure.position(2);
            height          = previous_height - obj.size(2);
            obj.set_position([obj.position(1),height]);
        end
    end
end
