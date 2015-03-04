
function [TCP,data] = JavaTcpServer(action,TCP,data,config)
    %% [TCP,data] = JavaTcpServer(action,TCP,data,config)
    % Java Web Server
    
    %% warnings
    %#ok<*TRYNC>
    
    %% function
    
    % initialize java
    import java.net.Socket;
    import java.io.*;
    import java.net.ServerSocket;

    % global variables
    global GlobalserverSocket;
    
    switch(action)
        case 'initialize'
            try
                serverSocket = ServerSocket(config.port);
            catch 
                try
                    GlobalserverSocket.close();
                    serverSocket = ServerSocket(config.port);
                catch
                    error('JavaTcpServer : error(initialize). Failed to open server port.');
                end
            end
            serverSocket.setSoTimeout(config.timeout);
            TCP.port = config.port;
            TCP.socket = nan;
            TCP.serverSocket = serverSocket;
            GlobalserverSocket = serverSocket;
            if(config.verbose),
                cprintf('*black','JavaTcpServer: initialize: ');
                fprintf('webserver available on http://localhost:%d \n',config.port);
            end
            
        case 'accept'
            while(true),
                try socket = TCP.serverSocket.accept();  break; end
            end
            TCP.socket = socket;
            TCP.remoteHost = char(socket.getInetAddress);
            TCP.outputStream = socket.getOutputStream;
            TCP.inputStream = socket.getInputStream;
            
        case 'read'
            data = zeros(1,1000000,'int8');
            tBytes = 0;
            tstart = tic();
            input_stream = BufferedInputStream(TCP.inputStream);
            while(true)
                nBytes = TCP.inputStream.available();
                partdata = zeros(1, nBytes, 'int8');
                for i = 1:nBytes
                    partdata(i) = input_stream.read();
                end
                data(tBytes+1 : tBytes+nBytes) = partdata;
                tBytes = tBytes + nBytes;
                % Only exist if the buffer is empty and some request-data is received, or if the time is larger than 1.5 seconds
                t = toc(tstart);
                if(isempty(partdata)&&(t>config.mtime1)&&(tBytes>0)), break; end
                if(isempty(partdata)&&(t>config.mtime2)), break; end
            end
            data = data(1:tBytes);
            if(config.verbose),
                cprintf('*black','JavaTcpServer: read: \n');
                fprintf('%s \n',strrep(char(data(1:min(1000,end))),char([13,10]),char(10)));
            end
            
        case 'write'
            if(~isa(data,'int8')), error('JavaTcpServer : error(write). Data must be of type int8'); end
            output_stream = DataOutputStream(TCP.outputStream);
            try output_stream.write(data,0,length(data)); end
            try output_stream.flush();                    end
        
        case 'close'
            TCP.serverSocket.close();
            TCP.socket = -1;
    end
end
