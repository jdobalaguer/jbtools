
function [d3,response] = d3_func_response(d3,path,fid,found)
    %% [d3,response] = D3_FUNC_RESPONSE(d3,request)
    % private function. default return response for a particular request
    % see also d3_help
    
    %% warnings
    %#ok<*NASGU>
    
    %% function
    
    % Generate response
    switch file_ext(path)
        
        % MATLAB function
        case {'.m'}
            if fid>0, fclose(fid); end
            try html = func_run(path,{d3});
            catch ME
                % error
                path = fullfile(d3.opts.www_folder,d3.opts.defaulterr);
                html = func_run(path,{ME});
                header = webserver_run('make_html_http_header',html,found);
                response = struct('html',html,'header',webserver_run('header2text',header));
                webserver_run('JavaTcpServer','write',d3.TCP,int8(response.header),d3.opts);
                webserver_run('JavaTcpServer','write',d3.TCP,int8(response.html),  d3.opts);
                rethrow(ME);
            end
            header = webserver_run('make_html_http_header',html,found);
            response = struct('html',html,'header',webserver_run('header2text',header));
            
        % HTML text
        case {'.html','.htm'}
            html = fread(fid, inf, 'int8')';
            fclose(fid);
            header = webserver_run('make_html_http_header',html,found);
            response = struct('html',html,'header',webserver_run('header2text',header));
            
        % Pictures
        case {'.jpg','.png','.gif','.ico'}
            html = fread(fid, inf, 'int8')';
            fclose(fid);
            header = webserver_run('make_image_http_header',html,found);
            response = struct('html',html,'header',webserver_run('header2text',header));
            
        % Unknown format
        otherwise
            html = fread(fid, inf, 'int8')';
            fclose(fid);
            header = webserver_run('make_bin_http_header',html,found);
            response = struct('html',html,'header',webserver_run('header2text',header));
    end
end