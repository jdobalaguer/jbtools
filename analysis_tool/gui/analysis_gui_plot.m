% ANALYSIS internal script

%% gui
classdef analysis_gui_plot < handle
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
        function obj = analysis_gui_plot(a)
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
            obj.size     = [    a.par.win_size(1),...
                                a.par.size_panellabel + 2*a.par.size_pushbutton(2) + 3*a.par.size_space];
        end
        
        %% create panel
        function create_panel(obj,a)
            obj.panel = uipanel(...
                'Parent',a.obj.window.window,...
                'Title',' PLOT ',...
                'BackgroundColor',a.par.win_background,...
                'Units','pixels',...
                'Position',[obj.position obj.size]);
        end
        
        %% create objects
        function create_objects(obj,a)
            obj.objects = struct();

            % plot
            item_size = a.par.size_pushbutton;
            item_pos  = [   0.5*obj.size(1) - 0.5*item_size(1) ...
                            obj.size(2) - a.par.size_panellabel - a.par.size_space - item_size(2) ];
            obj.objects.run = uicontrol(...
                'Parent',obj.panel,...
                'Style','pushbutton',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'String', {'run'},...
                'Callback',@a.plot_run);

            % export
            item_size   = a.par.size_pushbutton;
            item_pos(2) = item_pos(2) - a.par.size_space - item_size(2);
            obj.objects.export = uicontrol(...
                'Parent',obj.panel,...
                'Style','pushbutton',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'String', {'export'},...
                'Callback',@a.plot_export);

        end
        
        %% refresh
        function refresh(obj)
            string = evalin('base','who()');
            string(strcmp(string,'ans')) = [];
            set(obj.objects.list,'String',string);
        end
        
        %% reposition
        function reposition(obj,a)
            previous_height = a.obj.graphics.position(2);
            height          = previous_height - obj.size(2);
            obj.set_position([obj.position(1),height]);
        end
    end
end
