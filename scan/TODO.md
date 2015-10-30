
TODO
09. slicetime correction
35. TBTE @get.second(name,vector) @plot.xjview(name)
47. RSA functions for ROI
59. RSA with beta/cont/spmT
60. TBTE first level generic contrasts (could be useful for RSA)
63. improve TBTE contrast functions with orthogonalisation
64. bypass orthogonalisation option
65. fix glm normalisation/smooth folders (add voxel size)
67. enable/disable first level GLM
74. mat_elements (using sub2ind or ind2sub!)
75. mat_squeeze([dim])
76. scan_tool_fixPaths
77. scan_view assert spm
78. scan_view threshold for highest t-stat
79. scan_glm assert lengths of conditions
80. scan_view glass brain
81. scan_view p-values must take into account the tail!!!!
82. scan_view FDR
83. scan_view control using tabs
84. scan add functions at the beginning
86. discard dummy scans from the preprocessing
88. check @scan_function_tbte_get_vector, line 71 (ii_onset)
90. scan_tool_print without progress
91. TFCE without normal second level (and copy)
92. TFCE in scan_view

LONG TERM
06. handle HDD writing depending on the size of [scan]
#A. MVPA
#V. leave-one-subject-out (LOSO) roi analysis
12. re-do the conversion with SPM's dicom importer
20. make @get.vector return a struct with multiple fields? (legend, etc...)
21. scan.pregeneration option in functions ?
22. functions @update
42. @scan_tool_mask_outside(scan,image)
46. RSA with less subjects
51. RSA results to MNI space, for realignment

DONE
01. *fix* the glm FIR function yields different results for equivalent first beta/contrast - and I don't know why
03. find an efficient way of defining models in fake_rsa
07. zip/unzip
08. scan_merge .... nah
09. dicom, expansion
09. preprocessing
#A. ppi (for real)
#B. TBTE functions
#C. plot options parser
#D. is it good that everything works with absolute paths? yeah. why not.
#E. it's "basis functions", not "function basis"
#G. spm_orth is not disabled with "cond.orth = false"
#H. when doing PPI, ztransf the regressor (SPM doesnt do it anyway) - you can choose if you want to do it
#I. option to ztransf any regressor
#J. use SPM function spm_get_defaults
#K. there was a bug, but the "remove_scans" didn't pop-up. check it's working properly.
#L. move everything to private? nah. at least not for now
#M. see notes in [scan_rsa]
#N. option to add realignment (not in autocomplete)
#O. regressors from mat-file
#P. subject masks, mask tools (mni2subject)
#Q. template mask library? no. there are multiple voxs possiblities, and all masks are relative to data/mask/
#T. warnings in scan_rmdir
#T. check warnings in scan_rmdir
#U. constants from concatenation fail if there's no realignment covariates
#U. fix concatenation
#W. using evalc around SPM function
#X. add "slicetime" to all menus/options
#Y. function scan_tool_physiological
#Z. fix PPI without concatenation
R1. the different columns will only match between RDM/model if you're lucky. make this robust to the order, to concatenation, to the onset marge
R3. enable concatenation
R4. use hamed's toolbox
R5. in TBTE all information about the onset type is lost. this is crucial when using this information for the RSA - find a better way
R6. in RSA we should recycle the onset information from the TBTE.
10. new order
11. add scan.function.rethrow
13. generic contrasts to specific names
14. total elapsed time
15. glm column version
16 @function.vector/beta
17. split get/plot functions
18. create a getv_/mat_/vec_ library, 
19. re-code the steplot/pipplot/errplot
23. add the order to the RSA vectors and to [scan.job.glm]
24. scan_glm_copy mask
25. scan.directory.mask
26. new GLM @plot.xjview
27. RSA don't ignore searchlight/distance/comparison/univariate/filter
28. RSA rmdir/flags
29. scan_load_scan
30. rmdir directory.save.scan
31. improved save
32. license
33. glm_*_assert
34. always functions? (no flag) .... nah
36. scan_tool_zip auto-initialize if required
37. @folder.zip for save.scan too
38. own searchlight script with GLM option
39. RSA glm
40. RSA z-score
41. save the Y from the GLM
41. RSA mahalanobis (with image residuals)
43. RSA to load the number of sessions from the glm
44. fisher's Z = 0.5 * log((1+R)./(1-R))
45. RSA we may not need a mask at all
47. RSA de-mean
47. RSA functions for searchlight
48. @get.vector in TBTE to handle cells
48. check the @get.vector and @get.beta , for concat and tbte
49. save xY in a better place
49. pre-load xY in mahalanobis distance for all sessions
50. a [scan.running.done] cell of strings list would help to re-run stuff
52. [scan.job.image] folders for each glm/rsa
53. wrap auto-completion as "first steps"
54. save all callers within a folder
55. make adding new jobs more straightforward
55. RSA within ROI
56. option in glm to remove first volumes
57. check for invalid fields in [scan] during scan_initialize
58. RSA with global transformations
61. fix struct_default when using empty struct vectors..
62. check the meshgrid function in TBTE
66. handel alarm
68. scan_view basics
69. change names to scan_load, scan_save
70. remove mean files from scan_tool_check 'first'
71. scan_view error if no files
72. scan_view center voxels in viewer
73. add viewer alpha range
85. scan_glm_copy force flags
87. add multiple durations to scan_glm
89. TFCE
