% ANALYSIS internal script

%% gui
classdef analysis_gui_graphics < handle
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
        function obj = analysis_gui_graphics(a)
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
                                a.par.size_panellabel + a.par.size_holdbutton(2) + 2*a.par.size_space];
        end
        
        %% create panel
        function create_panel(obj,a)
            obj.panel = uipanel(...
                'Parent',a.obj.window.window,...
                'Title',' GRAPHICS ',...
                'BackgroundColor',a.par.win_background,...
                'Units','pixels',...
                'Position',[obj.position obj.size]);
        end
        
        %% create objects
        function create_objects(obj,a)
            obj.objects = struct();

            % hold
            item_size = a.par.size_holdbutton;
            item_pos = [    0.5*obj.size(1) - 0.5*item_size(1) ...
                            a.par.size_space];
            obj.objects.hold = uicontrol(...
                'Parent',obj.panel,...
                'Style','togglebutton',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'String', {' '},...
                'Callback',@a.gfx_hold);

        end
        
        %% refresh
        function refresh(obj)
            visible = get(obj.analysis.gfx.window.window,'Visible');
            switch visible
                case 'on'
                    set(obj.objects.hold,'Value',1);
                    set(obj.objects.hold,'String',{'on'});
                case'off'
                    set(obj.objects.hold,'Value',0);
                    set(obj.objects.hold,'String',{'off'});
            end
        end
        
        %% reposition
        function reposition(obj,a)
            previous_height = a.obj.filter.position(2);
            height          = previous_height - obj.size(2);
            obj.set_position([obj.position(1),height]);
        end
    end
end
