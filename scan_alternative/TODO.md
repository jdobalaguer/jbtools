

K. there was a bug, but the "remove_scans" didn't pop-up. check it's working properly.
N. option to add realignment (not in autocomplete)
2. in tbte all information about the onset type is lost. this is crucial when using this information for the RSA - find a better way
4. filter RSA, concatenate RSA
5. re-sort RDMs, shrink RDMs
6. handle HDD writing depending on the size of [scan]
7. zip/unzip
8. scan_merge and scan_from
9. preprocessing / dicom
A. MVPA
B. TBTE functions
C. plot options parser
L. move everything to private?
M. see notes in [scan_rsa]

DONE
1. *fix* the glm FIR function yields different results for equivalent first beta/contrast - and I don't know why
3. find an efficient way of defining models in fake_rsa
E. it's "basis functions", not "function basis"
I. option to ztransf any regressor
J. use SPM function spm_get_defaults
A. ppi (for real)
G. spm_orth is not disabled with "cond.orth = false"
D. is it good that everything works with absolute paths? yeah. why not.
H. when doing PPI, ztransf the regressor (SPM doesnt do it anyway) - you can choose if you want to do it

