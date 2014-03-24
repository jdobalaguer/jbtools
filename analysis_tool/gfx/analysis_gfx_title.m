% ANALYSIS internal script

%% gfx
classdef analysis_gfx_title < handle
    %% properties
    properties
        position
        size
        panel
        objects
    end
    
    %% methods
    methods
        %% constructor
        function obj = analysis_gfx_title(a)
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
            obj.size     = [    a.par.win_size(1)-2*a.par.size_space ...
                                a.par.size_panellabel + a.par.size_title(2) + 2*a.par.size_space];
        end
        
        %% create panel
        function create_panel(obj,a)
            obj.panel = uipanel(...
                'Parent',a.gfx.window.window,...
                'Title',[],...
                'BorderType','none',...
                'BackgroundColor',a.par.win_background,...
                'Units','pixels',...
                'Position',[obj.position obj.size]);
        end
        
        %% create objects
        function create_objects(obj,a)
            obj.objects = struct();
            
            % title
            item_size = [   obj.size(1) ...
                            a.par.size_title(2)];
            item_pos = [    a.par.size_space ...
                            a.par.size_space];
            obj.objects.title = uicontrol(...
                'Parent',obj.panel,...
                'BackgroundColor',a.par.win_background,...
                'Style','text',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'String', ' GRAPHICS ');
        end
        
        %% reposition
        function reposition(obj,a)
            previous_height = a.gfx.window.size(2);
            height          = previous_height - obj.size(2);
            obj.set_position([obj.position(1),height]);
        end
    end
end
