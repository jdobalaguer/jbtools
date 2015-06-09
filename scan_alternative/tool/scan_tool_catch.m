
function scan = scan_tool_catch(scan,e)
    %% scan = SCAN_TOOL_CATCH(scan,e)
    % catch an error and do whatever
    
    %% function
    switch scan.job.type
        case 'conversion'
            scan_tool_warning(scan,false,'Conversion not completed');
        case 'preprocess'
            scan_tool_warning(scan,false,'Preprocessing not completed');
            scan_tool_warning(scan,false,'Saving file..');
            scan_job_save_scan(scan);
        case 'glm'
            scan_tool_warning(scan,false,'GLM not completed');
            scan_tool_warning(scan,false,'Saving file..');
            scan_job_save_scan(scan);
        case 'tbte'
            scan_tool_warning(scan,false,'TBTE not completed');
            scan_tool_warning(scan,false,'Saving file..');
            scan_job_save_scan(scan);
        case 'rsa'
            scan_tool_warning(scan,false,'RSA not completed');
            scan_tool_warning(scan,false,'Saving file..');
            scan_job_save_scan(scan);
    end
    scan_tool_warning(scan,false,'use "rethrow(scan.result.error);" to see the error');
    cd(scan.directory.root);
    scan_tool_warning(scan,false,e.message);
    scan.result.error = e;
end
