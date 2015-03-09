function html = d3_axis(d3) 
    %% html = D3_AXIS(d3)
    % set axis

    %% warnings
    %#ok<*AGROW>

    %% function
    
    html = '';
    html = [html,'<script type="text/javascript">',10];
    summ  = d3.opts.summ;
    u_tab = summ.fig.handle;
    n_tab = length(u_tab);
    for i_tab = 1:n_tab
        tab = u_tab(i_tab);
        html = [html,'  var fig = d3.select("#svg',num2str(tab),'");',10];
        html = [html,'  var WIDTH = ',num2str(summ.fig.size.x(i_tab)),';',10];
        html = [html,'  var HEIGHT = ',num2str(summ.fig.size.y(i_tab)),';',10];
        html = [html,'  var MARGINS = {top: 20,right: 20,bottom: 20,left: 50};',10];
        html = [html,'  var xRange = d3.scale.linear().range([MARGINS.left, WIDTH - MARGINS.right] ).domain([',num2str(summ.axis.rng.x(i_tab,1)),',',num2str(summ.axis.rng.x(i_tab,2)),']);',10];
        html = [html,'  var yRange = d3.scale.linear().range([HEIGHT - MARGINS.top, MARGINS.bottom]).domain([',num2str(summ.axis.rng.y(i_tab,1)),',',num2str(summ.axis.rng.y(i_tab,2)),']);',10];
        html = [html,'  var xAxis = d3.svg.axis().scale(xRange).tickSize(1).tickSubdivide(true);',10];
        html = [html,'  var yAxis = d3.svg.axis().scale(yRange).tickSize(1).orient("left").tickSubdivide(true);',10];
        html = [html,'  fig.append("svg:g").attr("transform", "translate(0," + (HEIGHT - MARGINS.bottom) + ")").call(xAxis);',10];
        html = [html,'  fig.append("svg:g").attr("transform", "translate(" + (MARGINS.left) + ",0)").call(yAxis);',10];
    end
    html = [html,'</script>',10];
end
