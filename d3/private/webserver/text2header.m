

function header = text2header(requestdata,config)
    %% header = TEXT2HEADER(requestdata,config)
    % private funciton. parse header text and save it as a struct.

    %% function
    request_text=char(requestdata);
    request_lines = regexp(request_text, '\r\n+', 'split');
    request_words = regexp(request_lines, '\s+', 'split');
    for i=1:length(request_lines)
        line=request_lines{i};
        if(isempty(line)), break; end
        type=request_words{i}{1};
        switch(lower(type))
            case 'get'
                header.Get.Filename=request_words{i}{2};
                header.Get.Protocol=request_words{i}{3};
            case 'post'
                header.Post.Filename=request_words{i}{2};
                header.Post.Protocol=request_words{i}{3};
            case 'host:'
                header.Host=strtrim(line(7:end));
            case 'user-agent:'
                header.UserAgent=strtrim(line(13:end));
            case 'accept:'
                header.Accept=strtrim(line(9:end));
            case 'accept-language:'
                header.AcceptLanguage=strtrim(line(18:end));
            case 'accept-encoding:'
                header.AcceptEncoding=strtrim(line(18:end));
            case 'accept-charset:'
                header.AcceptCharset=strtrim(line(17:end));
            case 'keep-alive:'
                header.KeepAlive=strtrim(line(13:end));
            case 'connection:'
                header.Connection=strtrim(line(13:end));
            case 'content-length:'
                header.ContentLength=strtrim(line(17:end));
            case 'content-type:'
                %lines=strtrim(line(15:end));
                switch strtrim(request_words{i}{2})
                    case {'application/x-www-form-urlencoded','application/x-www-form-urlencoded;'}
                        header.ContentType.Type='application/x-www-form-urlencoded';
                        header.ContentType.Boundary='&';
                    case {'multipart/form-data','multipart/form-data;'}
                        header.ContentType.Type='multipart/form-data';
                        str=request_words{i}{3};
                        header.ContentType.Boundary=str(10:end);
                    otherwise
                        disp('unknown')
                end
            otherwise
        end
    end
    header.Content=struct;
    if(isfield(header,'ContentLength'))
        cl=str2double(header.ContentLength);
        str=request_text(end-cl+1:end);
        data=requestdata(end-cl+1:end);
        if(~isfield(header,'ContentType'))
            header.ContentType.Type=''; header.ContentType.Boundary='&';
        end
        switch (header.ContentType.Type)
            case {'application/x-www-form-urlencoded',''}
                str=strtrim(str);
                words = regexp(str, '&', 'split');
                for i=1:length(words)
                    words2 = regexp(words{i}, '=', 'split');
                    header.Content.(words2{1})=words2{2};
                end
            case 'multipart/form-data'
                pos=strfind(str,header.ContentType.Boundary);
                while((pos(1)>1)&&(str(pos(1)-1)=='-'))
                    header.ContentType.Boundary=['-' header.ContentType.Boundary];
                    pos=strfind(str,header.ContentType.Boundary);
                end

                for i=1:(length(pos)-1)
                    pstart=pos(i)+length(header.ContentType.Boundary);
                    pend=pos(i+1)-3; % Remove "13 10" End-line characters
                    subrequestdata=data(pstart:pend);
                    subdata= multipart2struct(subrequestdata,config);
                    header.Content.(subdata.Name).Filename=subdata.Filename;
                    header.Content.(subdata.Name).ContentType=subdata.ContentType;
                    header.Content.(subdata.Name).ContentData=subdata.ContentData;
                end
            otherwise
                disp('unknown')
        end
    end
end

%% auxiliar
function subdata=multipart2struct(subrequestdata,config)
    request_text=char(subrequestdata);
    request_lines = regexp(request_text, '\n+', 'split');
    request_words = regexp(request_lines, '\s+', 'split');

    i=1;
    subdata=struct;
    subdata.Name='';
    subdata.Filename='';
    subdata.ContentType='';
    subdata.ContentData='';
    while(true)
        i=i+1; if((i>length(request_lines))||(uint8(request_lines{i}(1)==13))), break; end
        line=request_lines{i};
        type=request_words{i}{1};
        switch(type)
            case 'Content-Disposition:'
                for j=3:length(request_words{i})
                    line_words=regexp(request_words{i}{j}, '"', 'split');
                    switch(line_words{1})
                        case 'name='
                            subdata.Name=line_words{2};
                        case 'filename='
                            subdata.Filename=line_words{2};
                    end
                end
            case 'Content-Type:'
                 subdata.ContentType=strtrim(line(15:end));
        end
    end
    w=find(subrequestdata==10);
    switch(subdata.ContentType) 
        case ''
            subdata.ContentData=char(subrequestdata(w(i)+1:end));
        otherwise
            subdata.ContentData=subrequestdata(w(i)+1:end);
            [pathstr,name,ext] = fileparts(subdata.Filename);
            filename=['/' char(round(rand(1,32)*9)+48)];
            fullfilename=[config.temp_folder filename ext];
            fid = fopen(fullfilename,'w'); fwrite(fid,subdata.ContentData,'int8'); fclose(fid);
            subdata.Filename=fullfilename;
    end
end
