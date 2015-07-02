
TODO
09. preprocessing
26. new GLM @plot.xjview
35. TBTE @get.xjview(name,vector) @plot.xjview(name,vector)
42. @scan_tool_mask_outside(scan,image)
46. RSA with less subjects
47. RSA functions (also when ROI)
48. check the @get.vector and @get.beta , for concat and tbte
49. saveY in a better place (and pre-load in mahalanobis distance for all sessions)
50. a [scan.running.done] cell of strings list would help to re-run stuff
51. RSA results to MNI space, for realignment

LONG TERM
06. handle HDD writing depending on the size of [scan]
#A. MVPA
#V. leave-one-subject-out (LOSO) roi analysis
12. re-do the conversion with SPM's dicom importer
20. make @get.vector return a struct with multiple fields? (legend, etc...)
21. scan.pregeneration option in functions ?
22. functions @update

DONE
01. *fix* the glm FIR function yields different results for equivalent first beta/contrast - and I don't know why
03. find an efficient way of defining models in fake_rsa
07. zip/unzip
08. scan_merge .... nah
09. dicom, expansion
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
48. @get.vector in TBTE to handle cells
