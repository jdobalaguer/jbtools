% ANALYSIS internal script

%% supress warnings
%#ok<*MANU>
%#ok<*INUSD>
%#ok<*STOUT>

%% class
classdef analysis_class < handle
    %% properties
    properties
        par % gui parameters
        obj % gui objects
        gfx % gfx objects
        fig % list of figures
    end
    
    %% methods
    methods
        %% constructor
        function obj = analysis_class(varargin),    analysis_constructor;           end
        function       refresh(obj),                analysis_constructor_refresh;   end
                
        %% figure
        function       figure_new(obj),             analysis_figure_new;            end
        function       figure_current(obj),         analysis_figure_current;        end
        function       figure_hold(obj),            analysis_figure_hold;           end
        function       figure_closeall(obj,~,~),    analysis_figure_closeall;       end
        function       figure_closed(obj,gcbf,~),   analysis_figure_closed;         end
        
        %% sdata
        %% axis
        %% graphics
        function       gfx_hold(obj,~,~),           analysis_gfx_hold;              end
        
        %% plot
        function       plot_run(obj,~,~),           analysis_plot_run;             end
        function       plot_export(obj,~,~),        analysis_plot_export;           end
        
        %% destructor
        function       destructor(obj,gcbf,~),      analysis_destructor;            end
        
        %% auxiliar
        function       warning(obj,message),        analysis_auxiliar_warning;      end
        function       error(obj,message),          analysis_auxiliar_error;        end
        function ret = assert(obj,cond,message),    analysis_auxiliar_assert;       end
    end
end
