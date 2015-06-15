
# JBTools



## Paths

Add only the main folder to your path.
» addpath(fileparts(which('jbtools_root.m')));
.. and save your path. Whenever you want to use any of the toolbox, add it all (there are many dependencies) by executing
» jbtools_add
You can remove all folders from the path again with
» jbtools_rm
If you want to update the toolbox (only from UNIX/Linux), simply do
» jbtools_pull



## List of toolboxes

#### anonymous & rebuilt
[anonymous](anonymous) are general functions that I would have liked matlab to include.
[rebuilt](rebuilt) are overloaded functions that matlab already includes.

#### analysis
[analysis](analysis_tool) BROKEN - is a graphical tool for basic data analysis & plotting.

#### fig
[fig](figures) is a set of functions that help you make nicer figures out of your data

#### d3
[d3](d3) IN CONSTRUCTION - aims for the same as fig, but does it through d3.js!

#### matvec
[matvec](matvec) is a set of functions help you go from matrix to vector format, and run some functions over these different kinds of data. extremely useful for behavioural analyses.

#### model
[model](model) is a framework for model fitting

#### mturk_parse
[mturk](mturk) is a toolbox to import javascript data into matlab. it is very specific to the webserver in our lab. if you don't know what this is for, you probably don't need to use it. 

#### scan
[scan](scan) IN CONSTRUCTION - is a pipeline that runs many kinds of fMRI analyses with minimal effort. it requires SPM12.

#### stats
[stats](stats) IN CONSTRUCTION - is a set of functions for statistical analyses. it will hopefully include parametrical, non-parametrical and bayesian approaches (but who knows..)

#### struct & cell
[struct](struct) set of functions for manipulation of struct variables.
[cell](cell) set of functions for manipulation of cell variables.
