% ANALYSIS internal script

%% gui
classdef analysis_gfx_style < handle
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
        function obj = analysis_gfx_style(a)
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
                                a.par.size_panellabel + a.par.size_pushbutton(2) + 2*a.par.size_space];
        end
        
        %% create panel
        function create_panel(obj,a)
            obj.panel = uipanel(...
                'Parent',a.gfx.window.window,...
                'Title',' STYLE ',...
                'BackgroundColor',a.par.win_background,...
                'Units','pixels',...
                'Position',[obj.position obj.size]);
        end
        
        %% create objects
        function create_objects(obj,a)
            obj.objects = struct();
            
            % list
            item_pos =  [   a.par.size_space...
                            a.par.size_space];
            item_size = [   obj.size(1)-2*a.par.size_space...
                            a.par.size_pushbutton(2) ];
            obj.objects.list = uicontrol(...
                'Parent',   obj.panel,...
                'Style',    'popup',...
                'Units',    'pixel',...
                'Position', [item_pos item_size],...
                'String',   {'scatter','plot','fig_plot','fig_steplot','fig_spline','fig_bare'});
        end
        
        %% reposition
        function reposition(obj,a)
            previous_height = a.gfx.title.position(2);
            height          = previous_height - obj.size(2);
            obj.set_position([obj.position(1),height]);
        end
    end
end
