
function [web,response] = web_func(web,request)
    %% [web,response] = WEB_FUNC(web,request)
    % default return response for a particular request
    
    %% warnings
    
    %% function
    opts = web.opts;
    
    if(isfieldp(request,'Get.Filename'))
        filename = request.Get.Filename;
    elseif(isfieldp(request,'Post.Filename'))
        filename = request.Post.Filename;
    else
        warning('Unknown Type of Request');
        return;
    end
    if any(filename=='?'), filename(find(filename=='?',1,'first'):end) = []; end
    if(strcmp(filename,'/')), filename  = opts.defaultfile; end
    fullfilename = [opts.www_folder,filename];
    fid = fopen(fullfilename, 'r');
    if(fid<0)
        filename = '/404.html';
        found = false;
    else
        found = true;
        fclose(fid);
    end
    fullfilename = [opts.www_folder,filename];
    [pathstr,name,ext] = fileparts(fullfilename);

    % Generate response
    switch(ext)
        case {'.m'}
            addpath(pathstr)
            fhandle = str2func(name);
            try
                html = feval(fhandle,request,opts);
            catch ME
                html = ['<html><body><font color="#FF0000">Error in file : ',name,'.m</font><br><br><font color="#990000"> The file returned the following error: <br>',ME.message,'</font></body></html>'];
            end
            rmpath(pathstr)
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