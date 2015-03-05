
function html = d3_chart_plot(data)
    %% html = D3_CHAT_PLOT(data)
    % plot(x,y)

    %% warnings
    %#ok<*INUSD,*AGROW>

    %% function
    html = '';
    html = [html,'<script type="text/javascript">',10];
    html = [html,get_m('d3_matdata.m',data,'data')];
    html = [html,'      var vals = m2j(data.vals);',10];
%     html = [html,'      console.log(vals);',10];
    html = [html,'      var myChart = new dimple.chart(svg[',num2str(data.fig),'], vals);',10];
    html = [html,'      myChart.setBounds(60, 30, 505, 305);',10];
    html = [html,'      var x = myChart.addCategoryAxis("x", "x");',10];
    html = [html,'      x.addOrderRule("Date");',10];
    html = [html,'      myChart.addMeasureAxis("y", "y");',10];
    html = [html,'      var s = myChart.addSeries(null, dimple.plot.line);',10];
    html = [html,'      myChart.draw();',10];
    html = [html,'  </script>',10];
end

%% auxiliar

% get m files
function html = get_m(varargin)
    filename = [jbtools_root(),'/d3/private/www/m/',varargin{1}];
    [pathstr,name,ext] = fileparts(filename);
    addpath(pathstr);
    fhandle = str2func(name);
    html = feval(fhandle,varargin{2:end});
end

