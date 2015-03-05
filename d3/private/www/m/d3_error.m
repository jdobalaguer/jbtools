
function html = d3_error(ME)
    %% html = D3_ERROR(ME)

    %% warnings
    
    %% function
    
    %warning(ME.identifier,ME.message);
    
    html = '';
    html = [html,'<html>',10];
    html = [html,'  <body>',10];
    html = [html,'    <br>',10];
    html = [html,'    <h1><font color="#FF0000">',10];
    html = [html,'      Error',10];
    html = [html,'    </font></h1>',10];
    html = [html,'    <font color="#000000">',10];
    html = [html,'      The file returned the following error:',10];
    html = [html,'      <br>',10];
    html = [html,'      <br>',10];
    html = [html,'      <i>',ME.message,'</i>',10];
    html = [html,'      <br>',10];
    html = [html,'      <br>',10];
    for i_stack = 1:length(ME.stack)
    html = [html,'      In <u>',ME.stack(i_stack).name,' at ',num2str(ME.stack(i_stack).line),'</u>',10];
    html = [html,'      <br>',10];
    end
    html = [html,'      <br>',10];
    html = [html,'    </font>',10];
    html = [html,'  </body>',10];
    html = [html,'</html>'];
    

end