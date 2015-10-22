
function html = d3_chart_plot(data,summ)
    %% html = D3_CHAT_PLOT(data)
    % plot(x,y)

    %% warnings
    %#ok<*INUSD,*AGROW>

    %% function
    html = '';
    html = [html,'<script type="text/javascript">',10];
    
    tab     = data.fig.handle;
    i_tab   = data.fig.number;
    
    html = [html,'  var fig = d3.select("#svg',num2str(tab),'");',10];
        
    html = [html,'  var WIDTH   = ',num2str(summ.fig.size.x(i_tab)),';',10];
    html = [html,'  var HEIGHT  = ',num2str(summ.fig.size.y(i_tab)),';',10];
    html = [html,'  var MARGINS = {top: 20,right: 20,bottom: 20,left: 50};',10];
    html = [html,'  var xRange  = d3.scale.linear().range([MARGINS.left, WIDTH - MARGINS.right] ).domain([',num2str(summ.axis.rng.x(i_tab,1)),',',num2str(summ.axis.rng.x(i_tab,2)),']);',10];
    html = [html,'  var yRange  = d3.scale.linear().range([HEIGHT - MARGINS.top, MARGINS.bottom]).domain([',num2str(summ.axis.rng.y(i_tab,1)),',',num2str(summ.axis.rng.y(i_tab,2)),']);',10];

    html = [html,'  var data',num2str(data.fig.layer),' = [];',10];
    html = [html,get_m('d3_matdata.m',data,['data',num2str(data.fig.layer)])];
    html = [html,'  var vals = m2j(data',num2str(data.fig.layer),'.vals);',10];

    html = [html,'  var lineFunc = d3.svg.line()',10];
    html = [html,'                   .x(function (d) { return xRange(d.x); })',10];
    html = [html,'                   .y(function (d) { return yRange(d.y); })',10];
    html = [html,'                   .interpolate("',data.styl.interp,'");',10];
    html = [html,'fig.append("svg:path")',10];
    html = [html,'   .attr("d",            lineFunc(vals))',10];
    html = [html,'   .attr("stroke",       "steelblue")',10];
    html = [html,'   .attr("stroke-width", 2)',10];
    html = [html,'   .attr("fill",         "none");',10];
    html = [html,'</script>',10];
end
