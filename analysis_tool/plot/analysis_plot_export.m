%  ANALYSIS internal script

%% assert figure
u_fig  = get(obj.obj.figure.objects.list,'String');
nb_fig = length(u_fig);
i_fig  = get(obj.obj.figure.objects.list,'Value');
if obj.assert(i_fig~=nb_fig,'no figure selected'), return; end

%% explorer
formats = { '*.pdf',    'PDF file (*.pdf)' ; ...
            '*.fig',    'MATLAB Figure (*.fig)' ; ...
            '*.eps',    'EPS file(*.eps)' ; ...
            '*.jpg',    'JPEG image (*.jpeg)' ; ...
            '*.tiff',   'TIFF image (*.tiff)' ; ...
            '*.png',    'Portable Network Graphics (*.png)' };
        
[file,path,~] = uiputfile(formats,'Select file');

%% export
if ischar(file) && ischar(path)
    pathfile = [path,filesep,file];
    h_fig    = obj.fig{i_fig}.handle;
    fig_export(pathfile,h_fig);
else
    obj.warning('no file selected');
end
