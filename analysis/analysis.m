%% help
% 
% ANALYSIS tool
% 

%% supress warnings
%#ok<*MANU>
%#ok<*INUSD>

%% class
classdef analysis < handle
    %% properties
    properties
        gui
        obj
        fig
    end
    
    %% methods
    methods
        %% constructor
        function obj = analysis(),      analysis_constructor;           end
        function refresh(obj),          analysis_constructor_refresh;   end
                
        %% figure
        function figure_new(obj),       analysis_figure_new;            end
        function figure_current(obj),   analysis_figure_current;        end
        function figure_hold(obj),      analysis_figure_hold;           end
        function figure_closeall(obj),  analysis_figure_closeall;       end
        function figure_closed(obj),    analysis_figure_closed;         end
        function figure_refresh(obj),   analysis_figure_refresh;        end
        
        %% sdata
        function sdata_refresh(obj),    analysis_sdata_refresh;         end
        function sdata_set(obj),        analysis_sdata_set;             end
        
        %% plot
        function plot_refresh(obj),     analysis_plot_refresh;          end
        
        %% graphics
        function graphics_refresh(obj), analysis_graphics_refresh;      end
        
        %% export
        function export(obj),           analysis_export;                end
        
        %% destructor
        function destructor(obj,gcbf,~),analysis_destructor;            end
    end
end
