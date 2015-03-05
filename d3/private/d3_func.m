
function [d3,response] = d3_func(d3,request)
    %% [d3,response] = D3_FUNC(d3,request)
    % default return response for a particular request
    % see also d3_start
    %          d3_default
    %          d3_close
    %          d3_reply
    %          d3_browser
    %          d3_figure
    %          d3_example
    
    %% warnings
    %#ok<*NASGU>
    
    %% function
    if(isfieldp(request,'Get.Filename'))
        filename = request.Get.Filename;
    elseif(isfieldp(request,'Post.Filename'))
        filename = request.Post.Filename;
    else
        warning('Unknown Type of Request');
        return;
    end
    if any(filename=='?'), filename(find(filename=='?',1,'first'):end) = []; end
    if(strcmp(filename,'/')), filename  = d3.opts.defaultfile; end
    fullfilename = [d3.opts.www_folder,filename];
    fid = fopen(fullfilename, 'r');
    if(fid<0)
        filename = d3.opts.defaultnone;
        found = false;
    else
        found = true;
        fclose(fid);
    end
    fullfilename = [d3.opts.www_folder,filename];
    [pathstr,name,ext] = fileparts(fullfilename);

    % Generate response
    switch(ext)
        case {'.m'}
            addpath(pathstr);
            fhandle = str2func(name);
            try
                html = feval(fhandle,d3,request);
            catch ME
                rmpath(pathstr);
                fullfilename = [d3.opts.www_folder,d3.opts.defaulterr];
                [pathstr,name,ext] = fileparts(fullfilename);
                addpath(pathstr);
                fhandle = str2func(name);
                html = feval(fhandle,ME);
                header = make_html_http_header(html,found);
                response = struct('html',html,'header',header2text(header));
                JavaTcpServer('write',d3.TCP,int8(response.header),d3.opts);
                JavaTcpServer('write',d3.TCP,int8(response.html),  d3.opts);
                rethrow(ME);
            end
            rmpath(pathstr);
            header = make_html_http_header(html,found);
            response = struct('html',html,'header',header2text(header));
        case {'.html','.htm'}
            fid = fopen(fullfilename, 'r');
            html = fread(fid, inf, 'int8')';
            fclose(fid);
            header = make_html_http_header(html,found);
            response = struct('html',html,'header',header2text(header));
        case {'.jpg','.png','.gif','.ico'}
            fid = fopen(fullfilename, 'r');
            html = fread(fid, inf, 'int8')';
            fclose(fid);
            header = make_image_http_header(html,found);
            response = struct('html',html,'header',header2text(header));
        otherwise
            fid = fopen(fullfilename, 'r');
            html = fread(fid, inf, 'int8')';
            fclose(fid);
            header = make_bin_http_header(html,found);
            response = struct('html',html,'header',header2text(header));
    end

end