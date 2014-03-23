% ANALYSIS internal script

%% gui
classdef analysis_gui_figure < handle
    %% properties
    properties
        analysis
        position
        size
        panel
        objects
        parameters
    end
    
    %% methods
    methods
        %% constructor
        function obj = analysis_gui_figure(a)
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
                                a.gui.size_panellabel + a.gui.size_holdbutton(2) + 2*a.gui.size_space];
        end
        
        %% create panel
        function create_panel(obj,a)
            obj.panel = uipanel(...
                'Parent',a.obj.window.window,...
                'Title',' FIGURE ',...
                'BackgroundColor',a.gui.win_background,...
                'Units','pixels',...
                'Position',[obj.position obj.size]);
        end
        
        %% create objects
        function create_objects(obj,a)
            obj.objects = struct();
            
            % list
            item_pos =  [   a.gui.size_space...
                            a.gui.size_space  ];
            item_size = [   obj.size(1)-3*a.gui.size_space - a.gui.size_holdbutton(1)...
                            a.gui.size_holdbutton(2) ];
            obj.objects.list = uicontrol(...
                'Parent',obj.panel,...
                'Style','popup',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'String',{' new figure'});
            
            % hold
            item_pos = [    item_pos(1) + item_size(1) + a.gui.size_space ...
                            item_pos(2) ];
            item_size = a.gui.size_holdbutton;
            obj.objects.hold = uicontrol(...
                'Parent',obj.panel,...
                'Style','togglebutton',...
                'Units','pixel',...
                'Position', [item_pos item_size],...
                'Visible','on',...
                'String','hold');
        end
        
        %% refresh
        function refresh(obj)
            % refresh titles
            nb_fig = length(obj.analysis.fig);
            u_fig  = cell(1,nb_fig);
            for i_fig = 1:nb_fig
                % get fig
                fig = obj.analysis.fig{i_fig};

                % set title
                fig.name     = ['figure ',num2str(fig.handle)];
                u_fig{i_fig} = fig.name;

                % set fig
                obj.analysis.fig{i_fig} = fig;
            end

            % add new figure
            u_fig{end+1} = 'new figure';

            % refresh gui list
            set(obj.objects.list,'String',u_fig);
        end
        
        %% reposition
        function reposition(obj,a)
            previous_height = a.obj.title.position(2);
            height          = previous_height - obj.size(2);
            obj.set_position([obj.position(1),height]);
        end
    end
end
