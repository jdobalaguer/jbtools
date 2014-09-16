
function scan_dcm2nii(scan)
    %% SCAN_DCM2NII(scan)
    % converts "dicom" files into 4d "nifti" files
    % see also scan_expand
    
    %% VARIABLES
    scan.subject.n = size(scan.dire.dcm.subs, 1);
    scan.subject.u = 1:scan.subject.n;
    
    %% CONVERT SUBJECTS
    for i_subject = 1:length(u_subject)
        path_dcm = '';
        path_nii = '';
        i_subject  = u_subject(i_subject);
        convert_str();
        convert_epi4_1();
        convert_epi4_2();
        convert_epi4_3();
        convert_epi4_4();
        convert_epi4_5();
    end
    
    %% CONVERT STRUCTURAL
    function convert_str()
        path_dcm = dir_dcm_strs(i_subject,:);
        path_nii = sprintf('%ssub_%02i/str/',dir_nii,i_subject);
        mkdirp(path_nii);
        dicm2nii(path_dcm,path_nii,'.nii');
        delete([path_nii,'dcmHeaders.mat']);
        file_from = sprintf('%st1_mpr_sag_p2_iso.nii',path_nii);
        file_to   = sprintf('%simages_000_mprax111recommended1001.nii',path_nii);
        movefile(file_from,file_to);
    end
    
    %% CONVERT EPI4
    function convert_epi4_1()
        path_dcm = dir_dcm_epis4_1(i_subject,:);
        path_nii = sprintf('%ssub_%02i/epi4/',dir_nii,i_subject);
        mkdirp(path_nii);
        dicm2nii(path_dcm,path_nii,'.nii');
        delete([path_nii,'dcmHeaders.mat']);
        file_from = sprintf('%sep2d_64mx_3_5mm_TE_30ms.nii',path_nii);
        file_to   = sprintf('%simages_ep2dP2RUN1.nii',path_nii);
        movefile(file_from,file_to);
    end
    
    function convert_epi4_2()
        path_dcm = dir_dcm_epis4_2(i_subject,:);
        path_nii = sprintf('%ssub_%02i/epi4/',dir_nii,i_subject);
        mkdirp(path_nii);
        dicm2nii(path_dcm,path_nii,'.nii');
        delete([path_nii,'dcmHeaders.mat']);
        file_from = sprintf('%sep2d_64mx_3_5mm_TE_30ms.nii',path_nii);
        file_to   = sprintf('%simages_ep2dP2RUN2.nii',path_nii);
        movefile(file_from,file_to);
    end
    
    function convert_epi4_3()
        path_dcm = dir_dcm_epis4_3(i_subject,:);
        path_nii = sprintf('%ssub_%02i/epi4/',dir_nii,i_subject);
        mkdirp(path_nii);
        dicm2nii(path_dcm,path_nii,'.nii');
        delete([path_nii,'dcmHeaders.mat']);
        file_from = sprintf('%sep2d_64mx_3_5mm_TE_30ms.nii',path_nii);
        file_to   = sprintf('%simages_ep2dP2RUN3.nii',path_nii);
        movefile(file_from,file_to);
    end
    
    function convert_epi4_4()
        path_dcm = dir_dcm_epis4_4(i_subject,:);
        path_nii = sprintf('%ssub_%02i/epi4/',dir_nii,i_subject);
        mkdirp(path_nii);
        dicm2nii(path_dcm,path_nii,'.nii');
        delete([path_nii,'dcmHeaders.mat']);
        file_from = sprintf('%sep2d_64mx_3_5mm_TE_30ms.nii',path_nii);
        file_to   = sprintf('%simages_ep2dP2RUN4.nii',path_nii);
        movefile(file_from,file_to);
    end
    
    function convert_epi4_5()
        path_dcm = dir_dcm_epis4_5(i_subject,:);
        path_nii = sprintf('%ssub_%02i/epi4/',dir_nii,i_subject);
        mkdirp(path_nii);
        dicm2nii(path_dcm,path_nii,'.nii');
        delete([path_nii,'dcmHeaders.mat']);
        file_from = sprintf('%sep2d_64mx_3_5mm_TE_30ms.nii',path_nii);
        file_to   = sprintf('%simages_ep2dP2RUN5.nii',path_nii);
        movefile(file_from,file_to);
    end
    
end