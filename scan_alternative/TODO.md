
06. handle HDD writing depending on the size of [scan]
#M. see notes in [scan_rsa]

LONG TERM
08. scan_merge and scan_from
09. preprocessing
#A. MVPA
#P. subject masks, mask tools (mni2subject)
#V. leave-one-subject-out (LOSO) roi analysis
12. re-do the conversion with SPM's dicom importer
20. make @get.vector a struct with multiple fields? (legend, etc...)

DONE
01. *fix* the glm FIR function yields different results for equivalent first beta/contrast - and I don't know why
03. find an efficient way of defining models in fake_rsa
07. zip/unzip
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
#N. option to add realignment (not in autocomplete)
#O. regressors from mat-file
#Q. template mask library? no. there are multiple voxs possiblities, and all masks are relative to data/mask/
#T. warnings in scan_rmdir
#T. check warnings in scan_rmdir
#U. constants from concatenation fail if there's no realignment covariates
#U. fix concatenation
#W. using evalc around SPM function
#X. add "slicetime" to all menus/options
#Y. function scan_tool_physiological
#Z. fix PPI without concatenation
10. new order
11. add scan.function.rethrow
13. generic contrasts to specific names
14. total elapsed time
15. glm column version
16 @function.vector/beta
-17. split get/plot functions
18. create a getv_/mat_/vec_ library, 
19. re-code the steplot/pipplot/errplot
