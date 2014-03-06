%FIG_EXPORT  Exports figures suitable for publication
%
% Examples:
%   im = fig_export
%   [im alpha] = fig_export
%   fig_export filename
%   fig_export filename -format1 -format2
%   fig_export ... -nocrop
%   fig_export ... -transparent
%   fig_export ... -native
%   fig_export ... -m<val>
%   fig_export ... -r<val>
%   fig_export ... -a<val>
%   fig_export ... -q<val>
%   fig_export ... -<renderer>
%   fig_export ... -<colorspace>
%   fig_export ... -append
%   fig_export ... -bookmark
%   fig_export(..., handle)
%
% This function saves a figure or single axes to one or more vector and/or
% bitmap file formats, and/or outputs a rasterized version to the
% workspace, with the following properties:
%   - Figure/axes reproduced as it appears on screen
%   - Cropped borders (optional)
%   - Embedded fonts (vector formats)
%   - Improved line and grid line styles
%   - Anti-aliased graphics (bitmap formats)
%   - Render images at native resolution (optional for bitmap formats)
%   - Transparent background supported (pdf, eps, png)
%   - Semi-transparent patch objects supported (png only)
%   - RGB, CMYK or grayscale output (CMYK only with pdf, eps, tiff)
%   - Variable image compression, including lossless (pdf, eps, jpg)
%   - Optionally append to file (pdf, tiff)
%   - Vector formats: pdf, eps
%   - Bitmap formats: png, tiff, jpg, bmp, export to workspace 
%   
% This function is especially suited to exporting figures for use in
% publications and presentations, because of the high quality and
% portability of media produced.
%
% Note that the background color and figure dimensions are reproduced
% (the latter approximately, and ignoring cropping & magnification) in the
% output file. For transparent background (and semi-transparent patch
% objects), use the -transparent option or set the figure 'Color' property
% to 'none'. To make axes transparent set the axes 'Color' property to
% 'none'. Pdf, eps and png are the only file formats to support a
% transparent background, whilst the png format alone supports transparency
% of patch objects.
%
% The choice of renderer (opengl, zbuffer or painters) has a large impact
% on the quality of output. Whilst the default value (opengl for bitmaps,
% painters for vector formats) generally gives good results, if you aren't
% satisfied then try another renderer.  Notes: 1) For vector formats (eps,
% pdf), only painters generates vector graphics. 2) For bitmaps, only
% opengl can render transparent patch objects correctly. 3) For bitmaps,
% only painters will correctly scale line dash and dot lengths when
% magnifying or anti-aliasing. 4) Fonts may be substitued with Courier when
% using painters.
%
% When exporting to vector format (pdf & eps) and bitmap format using the
% painters renderer, this function requires that ghostscript is installed
% on your system. You can download this from:
%   http://www.ghostscript.com
% When exporting to eps it additionally requires pdftops, from the Xpdf
% suite of functions. You can download this from:
%   http://www.foolabs.com/xpdf
%
%IN:
%   filename - string containing the name (optionally including full or
%              relative path) of the file the figure is to be saved as. If
%              a path is not specified, the figure is saved in the current
%              directory. If no name and no output arguments are specified,
%              the default name, 'fig_export_out', is used. If neither a
%              file extension nor a format are specified, a ".png" is added
%              and the figure saved in that format.
%   -format1, -format2, etc. - strings containing the extensions of the
%                              file formats the figure is to be saved as.
%                              Valid options are: '-pdf', '-eps', '-png',
%                              '-tif', '-jpg' and '-bmp'. All combinations
%                              of formats are valid.
%   -nocrop - option indicating that the borders of the output are not to
%             be cropped.
%   -transparent - option indicating that the figure background is to be
%                  made transparent (png, pdf and eps output only).
%   -m<val> - option where val indicates the factor to magnify the
%             on-screen figure pixel dimensions by when generating bitmap
%             outputs. Default: '-m1'.
%   -r<val> - option val indicates the resolution (in pixels per inch) to
%             export bitmap and vector outputs at, keeping the dimensions
%             of the on-screen figure. Default: '-r864' (for vector output
%             only). Note that the -m option overides the -r option for
%             bitmap outputs only.
%   -native - option indicating that the output resolution (when outputting
%             a bitmap format) should be such that the vertical resolution
%             of the first suitable image found in the figure is at the
%             native resolution of that image. To specify a particular
%             image to use, give it the tag 'fig_export_native'. Notes:
%             This overrides any value set with the -m and -r options. It
%             also assumes that the image is displayed front-to-parallel
%             with the screen. The output resolution is approximate and
%             should not be relied upon. Anti-aliasing can have adverse
%             effects on image quality (disable with the -a1 option).
%   -a1, -a2, -a3, -a4 - option indicating the amount of anti-aliasing to
%                        use for bitmap outputs. '-a1' means no anti-
%                        aliasing; '-a4' is the maximum amount (default).
%   -<renderer> - option to force a particular renderer (painters, opengl
%                 or zbuffer) to be used over the default: opengl for
%                 bitmaps; painters for vector formats.
%   -<colorspace> - option indicating which colorspace color figures should
%                   be saved in: RGB (default), CMYK or gray. CMYK is only
%                   supported in pdf, eps and tiff output.
%   -q<val> - option to vary bitmap image quality (in pdf, eps and jpg
%             files only).  Larger val, in the range 0-100, gives higher
%             quality/lower compression. val > 100 gives lossless
%             compression. Default: '-q95' for jpg, ghostscript prepress
%             default for pdf & eps. Note: lossless compression can
%             sometimes give a smaller file size than the default lossy
%             compression, depending on the type of images.
%   -append - option indicating that if the file (pdfs only) already
%             exists, the figure is to be appended as a new page, instead
%             of being overwritten (default).
%   -bookmark - option to indicate that a bookmark with the name of the
%               figure is to be created in the output file (pdf only).
%   handle - The handle of the figure, axes or uipanels (can be an array of
%            handles, but the objects must be in the same figure) to be
%            saved. Default: gcf.
%
%OUT:
%   im - MxNxC uint8 image array of the figure.
%   alpha - MxN single array of alphamatte values in range [0,1], for the
%           case when the background is transparent.
%
%   Some helpful examples and tips can be found at:
%      http://sites.google.com/site/oliverwoodford/software/fig_export
%
%   See also PRINT, SAVEAS.

% Copyright (C) Oliver Woodford 2008-2012

% The idea of using ghostscript is inspired by Peder Axensten's SAVEFIG
% (fex id: 10889) which is itself inspired by EPS2PDF (fex id: 5782).
% The idea for using pdftops came from the MATLAB newsgroup (id: 168171).
% The idea of editing the EPS file to change line styles comes from Jiro
% Doke's FIXPSLINESTYLE (fex id: 17928).
% The idea of changing dash length with line width came from comments on
% fex id: 5743, but the implementation is mine :)
% The idea of anti-aliasing bitmaps came from Anders Brun's MYAA (fex id:
% 20979).
% The idea of appending figures in pdfs came from Matt C in comments on the
% FEX (id: 23629)

% Thanks to Roland Martin for pointing out the colour MATLAB
% bug/feature with colorbar axes and transparent backgrounds.
% Thanks also to Andrew Matthews for describing a bug to do with the figure
% size changing in -nodisplay mode. I couldn't reproduce it, but included a
% fix anyway.
% Thanks to Tammy Threadgill for reporting a bug where an axes is not
% isolated from gui objects.

% 23/02/12: Ensure that axes limits don't change during printing
% 14/03/12: Fix bug in fixing the axes limits (thanks to Tobias Lamour for
%           reporting it).
% 02/05/12: Incorporate patch of Petr Nechaev (many thanks), enabling
%           bookmarking of figures in pdf files.
% 09/05/12: Incorporate patch of Arcelia Arrieta (many thanks), to keep
%           tick marks fixed.
% 12/12/12: Add support for isolating uipanels. Thanks to michael for
%           suggesting it.
% 25/09/13: Add support for changing resolution in vector formats. Thanks
%           to Jan Jaap Meijer for suggesting it.

function [im, alpha] = fig_export(varargin)
% Make sure the figure is rendered correctly _now_ so that properties like
% axes limits are up-to-date.
drawnow;
% Parse the input arguments
[fig, options] = parse_args(nargout, varargin{:});
% Isolate the subplot, if it is one
cls = all(ismember(get(fig, 'Type'), {'axes', 'uipanel'}));
if cls
    % Given handles of one or more axes, so isolate them from the rest
    fig = isolate_axes(fig);
else
    % Check we have a figure
    if ~isequal(get(fig, 'Type'), 'figure');
        error('Handle must be that of a figure, axes or uipanel');
    end
    % Get the old InvertHardcopy mode
    old_mode = get(fig, 'InvertHardcopy');
end
% Hack the font units where necessary (due to a font rendering bug in
% print?). This may not work perfectly in all cases. Also it can change the
% figure layout if reverted, so use a copy.
magnify = options.magnify * options.aa_factor;
if isbitmap(options) && magnify ~= 1
    fontu = findobj(fig, 'FontUnits', 'normalized');
    if ~isempty(fontu)
        % Some normalized font units found
        if ~cls
            fig = copyfig(fig);
            set(fig, 'Visible', 'off');
            fontu = findobj(fig, 'FontUnits', 'normalized');
            cls = true;
        end
        set(fontu, 'FontUnits', 'points');
    end
end
% MATLAB "feature": axes limits and tick marks can change when printing
Hlims = findall(fig, 'Type', 'axes');
if ~cls
    % Record the old axes limit and tick modes
    Xlims = make_cell(get(Hlims, 'XLimMode'));
    Ylims = make_cell(get(Hlims, 'YLimMode'));
    Zlims = make_cell(get(Hlims, 'ZLimMode'));
    Xtick = make_cell(get(Hlims, 'XTickMode'));
    Ytick = make_cell(get(Hlims, 'YTickMode'));
    Ztick = make_cell(get(Hlims, 'ZTickMode'));
end
% Set all axes limit and tick modes to manual, so the limits and ticks can't change
set(Hlims, 'XLimMode', 'manual', 'YLimMode', 'manual', 'ZLimMode', 'manual', 'XTickMode', 'manual', 'YTickMode', 'manual', 'ZTickMode', 'manual');
% Set to print exactly what is there
set(fig, 'InvertHardcopy', 'off');
% Set the renderer
switch options.renderer
    case 1
        renderer = '-opengl';
    case 2
        renderer = '-zbuffer';
    case 3
        renderer = '-painters';
    otherwise
        renderer = '-opengl'; % Default for bitmaps
end
% Do the bitmap formats first
if isbitmap(options)
    % Get the background colour
    if options.transparent && (options.png || options.alpha)
        % Get out an alpha channel
        % MATLAB "feature": black colorbar axes can change to white and vice versa!
        hCB = findobj(fig, 'Type', 'axes', 'Tag', 'Colorbar');
        if isempty(hCB)
            yCol = [];
            xCol = [];
        else
            yCol = get(hCB, 'YColor');
            xCol = get(hCB, 'XColor');
            if iscell(yCol)
                yCol = cell2mat(yCol);
                xCol = cell2mat(xCol);
            end
            yCol = sum(yCol, 2);
            xCol = sum(xCol, 2);
        end
        % MATLAB "feature": apparently figure size can change when changing
        % colour in -nodisplay mode
        pos = get(fig, 'Position');
        % Set the background colour to black, and set size in case it was
        % changed internally
        tcol = get(fig, 'Color');
        set(fig, 'Color', 'k', 'Position', pos);
        % Correct the colorbar axes colours
        set(hCB(yCol==0), 'YColor', [0 0 0]);
        set(hCB(xCol==0), 'XColor', [0 0 0]);
        % Print large version to array
        B = print2array(fig, magnify, renderer);
        % Downscale the image
        B = downsize(single(B), options.aa_factor);
        % Set background to white (and set size)
        set(fig, 'Color', 'w', 'Position', pos);
        % Correct the colorbar axes colours
        set(hCB(yCol==3), 'YColor', [1 1 1]);
        set(hCB(xCol==3), 'XColor', [1 1 1]);
        % Print large version to array
        A = print2array(fig, magnify, renderer);
        % Downscale the image
        A = downsize(single(A), options.aa_factor);
        % Set the background colour (and size) back to normal
        set(fig, 'Color', tcol, 'Position', pos);
        % Compute the alpha map
        alpha = round(sum(B - A, 3)) / (255 * 3) + 1;
        A = alpha;
        A(A==0) = 1;
        A = B ./ A(:,:,[1 1 1]);
        clear B
        % Convert to greyscale
        if options.colourspace == 2
            A = rgb2grey(A);
        end
        A = uint8(A);
        % Crop the background
        if options.crop
            [alpha, v] = crop_background(alpha, 0);
            A = A(v(1):v(2),v(3):v(4),:);
        end
        if options.png
            % Compute the resolution
            res = options.magnify * get(0, 'ScreenPixelsPerInch') / 25.4e-3;
            % Save the png
            imwrite(A, [options.name '.png'], 'Alpha', double(alpha), 'ResolutionUnit', 'meter', 'XResolution', res, 'YResolution', res);
            % Clear the png bit
            options.png = false;
        end
        % Return only one channel for greyscale
        if isbitmap(options)
            A = check_greyscale(A);
        end
        if options.alpha
            % Store the image
            im = A;
            % Clear the alpha bit
            options.alpha = false;
        end
        % Get the non-alpha image
        if isbitmap(options)
            alph = alpha(:,:,ones(1, size(A, 3)));
            A = uint8(single(A) .* alph + 255 * (1 - alph));
            clear alph
        end
        if options.im
            % Store the new image
            im = A;
        end
    else
        % Print large version to array
        if options.transparent
            % MATLAB "feature": apparently figure size can change when changing
            % colour in -nodisplay mode
            pos = get(fig, 'Position');
            tcol = get(fig, 'Color');
            set(fig, 'Color', 'w', 'Position', pos);
            A = print2array(fig, magnify, renderer);
            set(fig, 'Color', tcol, 'Position', pos);
            tcol = 255;
        else
            [A, tcol] = print2array(fig, magnify, renderer);
        end
        % Crop the background
        if options.crop
            A = crop_background(A, tcol);
        end
        % Downscale the image
        A = downsize(A, options.aa_factor);
        if options.colourspace == 2
            % Convert to greyscale
            A = rgb2grey(A);
        else
            % Return only one channel for greyscale
            A = check_greyscale(A);
        end
        % Outputs
        if options.im
            im = A;
        end
        if options.alpha
            im = A;
            alpha = zeros(size(A, 1), size(A, 2), 'single');
        end
    end
    % Save the images
    if options.png
        res = options.magnify * get(0, 'ScreenPixelsPerInch') / 25.4e-3;
        imwrite(A, [options.name '.png'], 'ResolutionUnit', 'meter', 'XResolution', res, 'YResolution', res);
    end
    if options.bmp
        imwrite(A, [options.name '.bmp']);
    end
    % Save jpeg with given quality
    if options.jpg
        quality = options.quality;
        if isempty(quality)
            quality = 95;
        end
        if quality > 100
            imwrite(A, [options.name '.jpg'], 'Mode', 'lossless');
        else
            imwrite(A, [options.name '.jpg'], 'Quality', quality);
        end
    end
    % Save tif images in cmyk if wanted (and possible)
    if options.tif
        if options.colourspace == 1 && size(A, 3) == 3
            A = double(255 - A);
            K = min(A, [], 3);
            K_ = 255 ./ max(255 - K, 1);
            C = (A(:,:,1) - K) .* K_;
            M = (A(:,:,2) - K) .* K_;
            Y = (A(:,:,3) - K) .* K_;
            A = uint8(cat(3, C, M, Y, K));
            clear C M Y K K_
        end
        append_mode = {'overwrite', 'append'};
        imwrite(A, [options.name '.tif'], 'Resolution', options.magnify*get(0, 'ScreenPixelsPerInch'), 'WriteMode', append_mode{options.append+1});
    end
end
% Now do the vector formats
if isvector(options)
    % Set the default renderer to painters
    if ~options.renderer
        renderer = '-painters';
    end
    % Generate some filenames
    tmp_nam = [tempname '.eps'];
    if options.pdf
        pdf_nam = [options.name '.pdf'];
    else
        pdf_nam = [tempname '.pdf'];
    end
    % Generate the options for print
    p2eArgs = {renderer, sprintf('-r%d', options.resolution)};
    if options.colourspace == 1
        p2eArgs = [p2eArgs {'-cmyk'}];
    end
    if ~options.crop
        p2eArgs = [p2eArgs {'-loose'}];
    end
    try
        % Generate an eps
        print2eps(tmp_nam, fig, p2eArgs{:});
        % Remove the background, if desired
        if options.transparent && ~isequal(get(fig, 'Color'), 'none')
            eps_remove_background(tmp_nam);
        end
        % Add a bookmark to the PDF if desired
        if options.bookmark
            fig_nam = get(fig, 'Name');
            if isempty(fig_nam)
                warning('fig_export:EmptyBookmark', 'Bookmark requested for figure with no name. Bookmark will be empty.');
            end
            add_bookmark(tmp_nam, fig_nam);
        end
        % Generate a pdf
        eps2pdf(tmp_nam, pdf_nam, 1, options.append, options.colourspace==2, options.quality);
    catch ex
        % Delete the eps
        delete(tmp_nam);
        rethrow(ex);
    end
    % Delete the eps
    delete(tmp_nam);
    if options.eps
        try
            % Generate an eps from the pdf
            pdf2eps(pdf_nam, [options.name '.eps']);
        catch ex
            if ~options.pdf
                % Delete the pdf
                delete(pdf_nam);
            end
            rethrow(ex);
        end
        if ~options.pdf
            % Delete the pdf
            delete(pdf_nam);
        end
    end
end
if cls
    % Close the created figure
    close(fig);
else
    % Reset the hardcopy mode
    set(fig, 'InvertHardcopy', old_mode);
    % Reset the axes limit and tick modes
    for a = 1:numel(Hlims)
        set(Hlims(a), 'XLimMode', Xlims{a}, 'YLimMode', Ylims{a}, 'ZLimMode', Zlims{a}, 'XTickMode', Xtick{a}, 'YTickMode', Ytick{a}, 'ZTickMode', Ztick{a});
    end
end
return
end

function [fig, options] = parse_args(nout, varargin)
% Parse the input arguments
% Set the defaults
fig = get(0, 'CurrentFigure');
options = struct('name', 'fig_export_out', ...
                 'crop', false, ...
                 'transparent', false, ...
                 'renderer', 0, ... % 0: default, 1: OpenGL, 2: ZBuffer, 3: Painters
                 'pdf', false, ...
                 'eps', false, ...
                 'png', false, ...
                 'tif', false, ...
                 'jpg', false, ...
                 'bmp', false, ...
                 'colourspace', 0, ... % 0: RGB/gray, 1: CMYK, 2: gray
                 'append', false, ...
                 'im', nout == 1, ...
                 'alpha', nout == 2, ...
                 'aa_factor', 3, ...
                 'magnify', [], ...
                 'resolution', [], ...
                 'bookmark', false, ...
                 'quality', []);
native = false; % Set resolution to native of an image

% Go through the other arguments
for a = 1:nargin-1
    if all(ishandle(varargin{a}))
        fig = varargin{a};
    elseif ischar(varargin{a}) && ~isempty(varargin{a})
        if varargin{a}(1) == '-'
            switch lower(varargin{a}(2:end))
                case 'nocrop'
                    options.crop = false;
                case {'trans', 'transparent'}
                    options.transparent = true;
                case 'opengl'
                    options.renderer = 1;
                case 'zbuffer'
                    options.renderer = 2;
                case 'painters'
                    options.renderer = 3;
                case 'pdf'
                    options.pdf = true;
                case 'eps'
                    options.eps = true;
                case 'png'
                    options.png = true;
                case {'tif', 'tiff'}
                    options.tif = true;
                case {'jpg', 'jpeg'}
                    options.jpg = true;
                case 'bmp'
                    options.bmp = true;
                case 'rgb'
                    options.colourspace = 0;
                case 'cmyk'
                    options.colourspace = 1;
                case {'gray', 'grey'}
                    options.colourspace = 2;
                case {'a1', 'a2', 'a3', 'a4'}
                    options.aa_factor = str2double(varargin{a}(3));
                case 'append'
                    options.append = true;
                case 'bookmark'
                    options.bookmark = true;
                case 'native'
                    native = true;
                otherwise
                    val = str2double(regexp(varargin{a}, '(?<=-(m|M|r|R|q|Q))(\d*\.)?\d+(e-?\d+)?', 'match'));
                    if ~isscalar(val)
                        error('option %s not recognised', varargin{a});
                    end
                    switch lower(varargin{a}(2))
                        case 'm'
                            options.magnify = val;
                        case 'r'
                            options.resolution = val;
                        case 'q'
                            options.quality = max(val, 0);
                    end
            end
        else
            [p, options.name, ext] = fileparts(varargin{a});
            if ~isempty(p)
                options.name = [p filesep options.name];
            end
            switch lower(ext)
                case {'.tif', '.tiff'}
                    options.tif = true;
                case {'.jpg', '.jpeg'}
                    options.jpg = true;
                case '.png'
                    options.png = true;
                case '.bmp'
                    options.bmp = true;
                case '.eps'
                    options.eps = true;
                case '.pdf'
                    options.pdf = true;
                otherwise
                    options.name = varargin{a};
            end
        end
    end
end

% Compute the magnification and resolution
if isempty(options.magnify)
    if isempty(options.resolution)
        options.magnify = 1;
        options.resolution = 864;
    else
        options.magnify = options.resolution ./ get(0, 'ScreenPixelsPerInch');
    end
elseif isempty(options.resolution)
    options.resolution = 864;
end
    

% Check we have a figure handle
if isempty(fig)
    error('No figure found');
end

% Set the default format
if ~isvector(options) && ~isbitmap(options)
    options.png = true;
end

% Check whether transparent background is wanted (old way)
if isequal(get(ancestor(fig(1), 'figure'), 'Color'), 'none')
    options.transparent = true;
end

% If requested, set the resolution to the native vertical resolution of the
% first suitable image found
if native && isbitmap(options)
    % Find a suitable image
    list = findobj(fig, 'Type', 'image', 'Tag', 'fig_export_native');
    if isempty(list)
        list = findobj(fig, 'Type', 'image', 'Visible', 'on');
    end
    for hIm = list(:)'
        % Check height is >= 2
        height = size(get(hIm, 'CData'), 1);
        if height < 2
            continue
        end
        % Account for the image filling only part of the axes, or vice
        % versa
        yl = get(hIm, 'YData');
        if isscalar(yl)
            yl = [yl(1)-0.5 yl(1)+height+0.5];
        else
            if ~diff(yl)
                continue
            end
            yl = yl + [-0.5 0.5] * (diff(yl) / (height - 1));
        end
        hAx = get(hIm, 'Parent');
        yl2 = get(hAx, 'YLim');
        % Find the pixel height of the axes
        oldUnits = get(hAx, 'Units');
        set(hAx, 'Units', 'pixels');
        pos = get(hAx, 'Position');
        set(hAx, 'Units', oldUnits);
        if ~pos(4)
            continue
        end
        % Found a suitable image
        % Account for stretch-to-fill being disabled
        pbar = get(hAx, 'PlotBoxAspectRatio');
        pos = min(pos(4), pbar(2)*pos(3)/pbar(1));
        % Set the magnification to give native resolution
        options.magnify = (height * diff(yl2)) / (pos * diff(yl));
        break
    end
end
return
end

function A = downsize(A, factor)
% Downsample an image
if factor == 1
    % Nothing to do
    return
end
try
    % Faster, but requires image processing toolbox
    A = imresize(A, 1/factor, 'bilinear');
catch
    % No image processing toolbox - resize manually
    % Lowpass filter - use Gaussian as is separable, so faster
    % Compute the 1d Gaussian filter
    filt = (-factor-1:factor+1) / (factor * 0.6);
    filt = exp(-filt .* filt);
    % Normalize the filter
    filt = single(filt / sum(filt));
    % Filter the image
    padding = floor(numel(filt) / 2);
    for a = 1:size(A, 3)
        A(:,:,a) = conv2(filt, filt', single(A([ones(1, padding) 1:end repmat(end, 1, padding)],[ones(1, padding) 1:end repmat(end, 1, padding)],a)), 'valid');
    end
    % Subsample
    A = A(1+floor(mod(end-1, factor)/2):factor:end,1+floor(mod(end-1, factor)/2):factor:end,:);
end
return
end

function A = rgb2grey(A)
A = cast(reshape(reshape(single(A), [], 3) * single([0.299; 0.587; 0.114]), size(A, 1), size(A, 2)), class(A));
return
end

function A = check_greyscale(A)
% Check if the image is greyscale
if size(A, 3) == 3 && ...
        all(reshape(A(:,:,1) == A(:,:,2), [], 1)) && ...
        all(reshape(A(:,:,2) == A(:,:,3), [], 1))
    A = A(:,:,1); % Save only one channel for 8-bit output
end
return
end

function [A, v] = crop_background(A, bcol)
% Map the foreground pixels
[h, w, c] = size(A);
if isscalar(bcol) && c > 1
    bcol = bcol(ones(1, c));
end
bail = false;
for l = 1:w
    for a = 1:c
        if ~all(A(:,l,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bail = false;
for r = w:-1:l
    for a = 1:c
        if ~all(A(:,r,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bail = false;
for t = 1:h
    for a = 1:c
        if ~all(A(t,:,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
bail = false;
for b = h:-1:t
    for a = 1:c
        if ~all(A(b,:,a) == bcol(a))
            bail = true;
            break;
        end
    end
    if bail
        break;
    end
end
% Crop the background, leaving one boundary pixel to avoid bleeding on
% resize
v = [max(t-1, 1) min(b+1, h) max(l-1, 1) min(r+1, w)];
A = A(v(1):v(2),v(3):v(4),:);
return
end

function eps_remove_background(fname)
% Remove the background of an eps file
% Open the file
fh = fopen(fname, 'r+');
if fh == -1
    error('Not able to open file %s.', fname);
end
% Read the file line by line
while true
    % Get the next line
    l = fgets(fh);
    if isequal(l, -1)
        break; % Quit, no rectangle found
    end
    % Check if the line contains the background rectangle
    if isequal(regexp(l, ' *0 +0 +\d+ +\d+ +rf *[\n\r]+', 'start'), 1)
        % Set the line to whitespace and quit
        l(1:regexp(l, '[\n\r]', 'start', 'once')-1) = ' ';
        fseek(fh, -numel(l), 0);
        fprintf(fh, l);
        break;
    end
end
% Close the file
fclose(fh);
return
end

function b = isvector(options)
b = options.pdf || options.eps;
return
end

function b = isbitmap(options)
b = options.png || options.tif || options.jpg || options.bmp || options.im || options.alpha;
return
end

% Helper function
function A = make_cell(A)
if ~iscell(A)
    A = {A};
end
return
end

function add_bookmark(fname, bookmark_text)
% Adds a bookmark to the temporary EPS file after %%EndPageSetup
% Read in the file
fh = fopen(fname, 'r');
if fh == -1
    error('File %s not found.', fname);
end
try
    fstrm = fread(fh, '*char')';
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);

% Include standard pdfmark prolog to maximize compatibility
fstrm = strrep(fstrm, '%%BeginProlog', sprintf('%%%%BeginProlog\n/pdfmark where {pop} {userdict /pdfmark /cleartomark load put} ifelse'));
% Add page bookmark
fstrm = strrep(fstrm, '%%EndPageSetup', sprintf('%%%%EndPageSetup\n[ /Title (%s) /OUT pdfmark',bookmark_text));

% Write out the updated file
fh = fopen(fname, 'w');
if fh == -1
    error('Unable to open %s for writing.', fname);
end
try
    fwrite(fh, fstrm, 'char*1');
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);
return
end

function eps2pdf(source, dest, crop, append, gray, quality)
% Intialise the options string for ghostscript
options = ['-q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile="' dest '"'];
% Set crop option
if nargin < 3 || crop
    options = [options ' -dEPSCrop'];
end
% Set the font path
fp = font_path();
if ~isempty(fp)
    options = [options ' -sFONTPATH="' fp '"'];
end
% Set the grayscale option
if nargin > 4 && gray
    options = [options ' -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray'];
end
% Set the bitmap quality
if nargin > 5 && ~isempty(quality)
    options = [options ' -dAutoFilterColorImages=false -dAutoFilterGrayImages=false'];
    if quality > 100
        options = [options ' -dColorImageFilter=/FlateEncode -dGrayImageFilter=/FlateEncode -c ".setpdfwrite << /ColorImageDownsampleThreshold 10 /GrayImageDownsampleThreshold 10 >> setdistillerparams"'];
    else
        options = [options ' -dColorImageFilter=/DCTEncode -dGrayImageFilter=/DCTEncode'];
        v = 1 + (quality < 80);
        quality = 1 - quality / 100;
        s = sprintf('<< /QFactor %.2f /Blend 1 /HSample [%d 1 1 %d] /VSample [%d 1 1 %d] >>', quality, v, v, v, v);
        options = sprintf('%s -c ".setpdfwrite << /ColorImageDict %s /GrayImageDict %s >> setdistillerparams"', options, s, s);
    end
end
% Check if the output file exists
if nargin > 3 && append && exist(dest, 'file') == 2
    % File exists - append current figure to the end
    tmp_nam = tempname;
    % Copy the file
    copyfile(dest, tmp_nam);
    % Add the output file names
    options = [options ' -f "' tmp_nam '" "' source '"'];
    try
        % Convert to pdf using ghostscript
        [status message] = ghostscript(options);
    catch
        % Delete the intermediate file
        delete(tmp_nam);
        rethrow(lasterror);
    end
    % Delete the intermediate file
    delete(tmp_nam);
else
    % File doesn't exist or should be over-written
    % Add the output file names
    options = [options ' -f "' source '"'];
    % Convert to pdf using ghostscript
    [status message] = ghostscript(options);
end
% Check for error
if status
    % Report error
    if isempty(message)
        error('Unable to generate pdf. Check destination directory is writable.');
    else
        error(message);
    end
end
return
end

% Function to return (and create, where necessary) the font path
function fp = font_path()
fp = user_string('gs_font_path');
if ~isempty(fp)
    return
end
% Create the path
% Start with the default path
fp = getenv('GS_FONTPATH');
% Add on the typical directories for a given OS
if ispc
    if ~isempty(fp)
        fp = [fp ';'];
    end
    fp = [fp getenv('WINDIR') filesep 'Fonts'];
else
    if ~isempty(fp)
        fp = [fp ':'];
    end
    fp = [fp '/usr/share/fonts:/usr/local/share/fonts:/usr/share/fonts/X11:/usr/local/share/fonts/X11:/usr/share/fonts/truetype:/usr/local/share/fonts/truetype'];
end
user_string('gs_font_path', fp);
return
end

function fh = copyfig(fh)
% Set the default
if nargin == 0
    fh = gcf;
end
% Is there a legend?
if isempty(findall(fh, 'Type', 'axes', 'Tag', 'legend'))
    % Safe to copy using copyobj
    fh = copyobj(fh, 0);
else
    % copyobj will change the figure, so save and then load it instead
    tmp_nam = [tempname '.fig'];
    hgsave(fh, tmp_nam);
    fh = hgload(tmp_nam);
    delete(tmp_nam);
end
return
end

function fix_lines(fname, fname2)
% Read in the file
fh = fopen(fname, 'r');
if fh == -1
    error('File %s not found.', fname);
end
try
    fstrm = fread(fh, '*char')';
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);

% Move any embedded fonts after the postscript header
if strcmp(fstrm(1:15), '%!PS-AdobeFont-')
    % Find the start and end of the header
    ind = regexp(fstrm, '[\n\r]%!PS-Adobe-');
    [ind2 ind2] = regexp(fstrm, '[\n\r]%%EndComments[\n\r]+');
    % Put the header first
    if ~isempty(ind) && ~isempty(ind2) && ind(1) < ind2(1)
        fstrm = fstrm([ind(1)+1:ind2(1) 1:ind(1) ind2(1)+1:end]);
    end
end

% Make sure all line width commands come before the line style definitions,
% so that dash lengths can be based on the correct widths
% Find all line style sections
ind = [regexp(fstrm, '[\n\r]SO[\n\r]'),... % This needs to be here even though it doesn't have dots/dashes!
       regexp(fstrm, '[\n\r]DO[\n\r]'),...
       regexp(fstrm, '[\n\r]DA[\n\r]'),...
       regexp(fstrm, '[\n\r]DD[\n\r]')];
ind = sort(ind);
% Find line width commands
[ind2 ind3] = regexp(fstrm, '[\n\r]\d* w[\n\r]');
% Go through each line style section and swap with any line width commands
% near by
b = 1;
m = numel(ind);
n = numel(ind2);
for a = 1:m
    % Go forwards width commands until we pass the current line style
    while b <= n && ind2(b) < ind(a)
        b = b + 1;
    end
    if b > n
        % No more width commands
        break;
    end
    % Check we haven't gone past another line style (including SO!)
    if a < m && ind2(b) > ind(a+1)
        continue;
    end
    % Are the commands close enough to be confident we can swap them?
    if (ind2(b) - ind(a)) > 8
        continue;
    end
    % Move the line style command below the line width command
    fstrm(ind(a)+1:ind3(b)) = [fstrm(ind(a)+4:ind3(b)) fstrm(ind(a)+1:ind(a)+3)];
    b = b + 1;
end

% Find any grid line definitions and change to GR format
% Find the DO sections again as they may have moved
ind = int32(regexp(fstrm, '[\n\r]DO[\n\r]'));
if ~isempty(ind)
    % Find all occurrences of what are believed to be axes and grid lines
    ind2 = int32(regexp(fstrm, '[\n\r] *\d* *\d* *mt *\d* *\d* *L[\n\r]'));
    if ~isempty(ind2)
        % Now see which DO sections come just before axes and grid lines
        ind2 = repmat(ind2', [1 numel(ind)]) - repmat(ind, [numel(ind2) 1]);
        ind2 = any(ind2 > 0 & ind2 < 12); % 12 chars seems about right
        ind = ind(ind2);
        % Change any regions we believe to be grid lines to GR
        fstrm(ind+1) = 'G';
        fstrm(ind+2) = 'R';
    end
end

% Isolate line style definition section
first_sec = strfind(fstrm, '% line types:');
[second_sec remaining] = strtok(fstrm(first_sec+1:end), '/');
[remaining remaining] = strtok(remaining, '%');

% Define the new styles, including the new GR format
% Dot and dash lengths have two parts: a constant amount plus a line width
% variable amount. The constant amount comes after dpi2point, and the
% variable amount comes after currentlinewidth. If you want to change
% dot/dash lengths for a one particular line style only, edit the numbers
% in the /DO (dotted lines), /DA (dashed lines), /DD (dot dash lines) and
% /GR (grid lines) lines for the style you want to change.
new_style = {'/dom { dpi2point 1 currentlinewidth 0.08 mul add mul mul } bdef',... % Dot length macro based on line width
             '/dam { dpi2point 2 currentlinewidth 0.04 mul add mul mul } bdef',... % Dash length macro based on line width
             '/SO { [] 0 setdash 0 setlinecap } bdef',... % Solid lines
             '/DO { [1 dom 1.2 dom] 0 setdash 0 setlinecap } bdef',... % Dotted lines
             '/DA { [4 dam 1.5 dam] 0 setdash 0 setlinecap } bdef',... % Dashed lines
             '/DD { [1 dom 1.2 dom 4 dam 1.2 dom] 0 setdash 0 setlinecap } bdef',... % Dot dash lines
             '/GR { [0 dpi2point mul 4 dpi2point mul] 0 setdash 1 setlinecap } bdef'}; % Grid lines - dot spacing remains constant

if nargin < 2
    % Overwrite the input file
    fname2 = fname;
end

% Save the file with the section replaced
fh = fopen(fname2, 'w');
if fh == -1
    error('Unable to open %s for writing.', fname2);
end
try
    fwrite(fh, fstrm(1:first_sec), 'char*1');
    fwrite(fh, second_sec, 'char*1');
    fprintf(fh, '%s\r', new_style{:});
    fwrite(fh, remaining, 'char*1');
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);
return
end

function varargout = ghostscript(cmd)
% Initialize any required system calls before calling ghostscript
shell_cmd = '';
if isunix
    shell_cmd = 'export LD_LIBRARY_PATH=""; '; % Avoids an error on Linux with GS 9.07
end
% Call ghostscript
[varargout{1:nargout}] = system(sprintf('%s"%s" %s', shell_cmd, gs_path, cmd));
return
end

function path_ = gs_path
% Return a valid path
% Start with the currently set path
path_ = user_string('ghostscript');
% Check the path works
if check_gs_path(path_)
    return
end
% Check whether the binary is on the path
if ispc
    bin = {'gswin32c.exe', 'gswin64c.exe', 'gs'};
else
    bin = {'gs'};
end
for a = 1:numel(bin)
    path_ = bin{a};
    if check_store_gs_path(path_)
        return
    end
end
% Search the obvious places
if ispc
    default_location = 'C:\Program Files\gs\';
    dir_list = dir(default_location);
    if isempty(dir_list)
        default_location = 'C:\Program Files (x86)\gs\'; % Possible location on 64-bit systems 
        dir_list = dir(default_location);
    end
    executable = {'\bin\gswin32c.exe', '\bin\gswin64c.exe'};
    ver_num = 0;
    % If there are multiple versions, use the newest
    for a = 1:numel(dir_list)
        ver_num2 = sscanf(dir_list(a).name, 'gs%g');
        if ~isempty(ver_num2) && ver_num2 > ver_num
            for b = 1:numel(executable)
                path2 = [default_location dir_list(a).name executable{b}];
                if exist(path2, 'file') == 2
                    path_ = path2;
                    ver_num = ver_num2;
                end
            end
        end
    end
    if check_store_gs_path(path_)
        return
    end
else
    bin = {'/usr/bin/gs', '/usr/local/bin/gs'};
    for a = 1:numel(bin)
        path_ = bin{a};
        if check_store_gs_path(path_)
            return
        end
    end
end
% Ask the user to enter the path
while 1
    if strncmp(computer, 'MAC', 3) % Is a Mac
        % Give separate warning as the uigetdir dialogue box doesn't have a
        % title
        uiwait(warndlg('Ghostscript not found. Please locate the program.'))
    end
    base = uigetdir('/', 'Ghostcript not found. Please locate the program.');
    if isequal(base, 0)
        % User hit cancel or closed window
        break;
    end
    base = [base filesep];
    bin_dir = {'', ['bin' filesep], ['lib' filesep]};
    for a = 1:numel(bin_dir)
        for b = 1:numel(bin)
            path_ = [base bin_dir{a} bin{b}];
            if exist(path_, 'file') == 2
                if check_store_gs_path(path_)
                    return
                end
            end
        end
    end
end
error('Ghostscript not found. Have you installed it from www.ghostscript.com?');
end

function good = check_store_gs_path(path_)
% Check the path is valid
good = check_gs_path(path_);
if ~good
    return
end
% Update the current default path to the path found
if ~user_string('ghostscript', path_)
    warning('Path to ghostscript installation could not be saved. Enter it manually in ghostscript.txt.');
    return
end
return
end

function good = check_gs_path(path_)
% Check the path is valid
[good, message] = system(sprintf('"%s" -h', path_));
good = good == 0;
return
end

function fh = isolate_axes(ah, vis)
% Make sure we have an array of handles
if ~all(ishandle(ah))
    error('ah must be an array of handles');
end
% Check that the handles are all for axes or uipanels, and are all in the same figure
fh = ancestor(ah(1), 'figure');
nAx = numel(ah);
for a = 1:nAx
    if ~ismember(get(ah(a), 'Type'), {'axes', 'uipanel'})
        error('All handles must be axes or uipanel handles.');
    end
    if ~isequal(ancestor(ah(a), 'figure'), fh)
        error('Axes must all come from the same figure.');
    end
end
% Tag the objects so we can find them in the copy
old_tag = get(ah, 'Tag');
if nAx == 1
    old_tag = {old_tag};
end
set(ah, 'Tag', 'ObjectToCopy');
% Create a new figure exactly the same as the old one
fh = copyfig(fh); %copyobj(fh, 0);
if nargin < 2 || ~vis
    set(fh, 'Visible', 'off');
end
% Reset the object tags
for a = 1:nAx
    set(ah(a), 'Tag', old_tag{a});
end
% Find the objects to save
ah = findall(fh, 'Tag', 'ObjectToCopy');
if numel(ah) ~= nAx
    close(fh);
    error('Incorrect number of objects found.');
end
% Set the axes tags to what they should be
for a = 1:nAx
    set(ah(a), 'Tag', old_tag{a});
end
% Keep any legends and colorbars which overlap the subplots
lh = findall(fh, 'Type', 'axes', '-and', {'Tag', 'legend', '-or', 'Tag', 'Colorbar'});
nLeg = numel(lh);
if nLeg > 0
    set([ah(:); lh(:)], 'Units', 'normalized');
    ax_pos = get(ah, 'OuterPosition');
    if nAx > 1
        ax_pos = cell2mat(ax_pos(:));
    end
    ax_pos(:,3:4) = ax_pos(:,3:4) + ax_pos(:,1:2);
    leg_pos = get(lh, 'OuterPosition');
    if nLeg > 1;
        leg_pos = cell2mat(leg_pos);
    end
    leg_pos(:,3:4) = leg_pos(:,3:4) + leg_pos(:,1:2);
    ax_pos = shiftdim(ax_pos, -1);
    % Overlap test
    M = bsxfun(@lt, leg_pos(:,1), ax_pos(:,:,3)) & ...
        bsxfun(@lt, leg_pos(:,2), ax_pos(:,:,4)) & ...
        bsxfun(@gt, leg_pos(:,3), ax_pos(:,:,1)) & ...
        bsxfun(@gt, leg_pos(:,4), ax_pos(:,:,2));
    ah = [ah; lh(any(M, 2))];
end
% Get all the objects in the figure
axs = findall(fh);
% Delete everything except for the input objects and associated items
delete(axs(~ismember(axs, [ah; allchildren(ah); allancestors(ah)])));
return
end

function ah = allchildren(ah)
ah = findall(ah);
if iscell(ah)
    ah = cell2mat(ah);
end
ah = ah(:);
return
end

function ph = allancestors(ah)
ph = [];
for a = 1:numel(ah)
    h = get(ah(a), 'parent');
    while h ~= 0
        ph = [ph; h];
        h = get(h, 'parent');
    end
end
return
end

function pdf2eps(source, dest)
% Construct the options string for pdftops
options = ['-q -paper match -eps -level2 "' source '" "' dest '"'];
% Convert to eps using pdftops
[status message] = pdftops(options);
% Check for error
if status
    % Report error
    if isempty(message)
        error('Unable to generate eps. Check destination directory is writable.');
    else
        error(message);
    end
end
% Fix the DSC error created by pdftops
fid = fopen(dest, 'r+');
if fid == -1
    % Cannot open the file
    return
end
fgetl(fid); % Get the first line
str = fgetl(fid); % Get the second line
if strcmp(str(1:min(13, end)), '% Produced by')
    fseek(fid, -numel(str)-1, 'cof');
    fwrite(fid, '%'); % Turn ' ' into '%'
end
fclose(fid);
return
end

function varargout = pdftops(cmd)
% Call pdftops
[varargout{1:nargout}] = system(sprintf('"%s" %s', xpdf_path, cmd));
return
end

function path_ = xpdf_path
% Return a valid path
% Start with the currently set path
path_ = user_string('pdftops');
% Check the path works
if check_xpdf_path(path_)
    return
end
% Check whether the binary is on the path
if ispc
    bin = 'pdftops.exe';
else
    bin = 'pdftops';
end
if check_store_xpdf_path(bin)
    path_ = bin;
    return
end
% Search the obvious places
if ispc
    path_ = 'C:\Program Files\xpdf\pdftops.exe';
else
    path_ = '/usr/local/bin/pdftops';
end
if check_store_xpdf_path(path_)
    return
end
% Ask the user to enter the path
while 1
    if strncmp(computer,'MAC',3) % Is a Mac
        % Give separate warning as the uigetdir dialogue box doesn't have a
        % title
        uiwait(warndlg('Pdftops not found. Please locate the program, or install xpdf-tools from http://users.phg-online.de/tk/MOSXS/.'))
    end
    base = uigetdir('/', 'Pdftops not found. Please locate the program.');
    if isequal(base, 0)
        % User hit cancel or closed window
        break;
    end
    base = [base filesep];
    bin_dir = {'', ['bin' filesep], ['lib' filesep]};
    for a = 1:numel(bin_dir)
        path_ = [base bin_dir{a} bin];
        if exist(path_, 'file') == 2
            break;
        end
    end
    if check_store_xpdf_path(path_)
        return
    end
end
error('pdftops executable not found.');
end

function good = check_store_xpdf_path(path_)
% Check the path is valid
good = check_xpdf_path(path_);
if ~good
    return
end
% Update the current default path to the path found
if ~user_string('pdftops', path_)
    warning('Path to pdftops executable could not be saved. Enter it manually in pdftops.txt.');
    return
end
return
end

function good = check_xpdf_path(path_)
% Check the path is valid
[good message] = system(sprintf('"%s" -h', path_));
% system returns good = 1 even when the command runs
% Look for something distinct in the help text
good = ~isempty(strfind(message, 'PostScript'));
return
end

function [A, bcol] = print2array(fig, res, renderer)
% Generate default input arguments, if needed
if nargin < 2
    res = 1;
    if nargin < 1
        fig = gcf;
    end
end
% Warn if output is large
old_mode = get(fig, 'Units');
set(fig, 'Units', 'pixels');
px = get(fig, 'Position');
set(fig, 'Units', old_mode);
npx = prod(px(3:4)*res)/1e6;
if npx > 30
    % 30M pixels or larger!
    warning('MATLAB:LargeImage', 'print2array generating a %.1fM pixel image. This could be slow and might also cause memory problems.', npx);
end
% Retrieve the background colour
bcol = get(fig, 'Color');
% Set the resolution parameter
res_str = ['-r' num2str(ceil(get(0, 'ScreenPixelsPerInch')*res))];
% Generate temporary file name
tmp_nam = [tempname '.tif'];
if nargin > 2 && strcmp(renderer, '-painters')
    % Print to eps file
    tmp_eps = [tempname '.eps'];
    print2eps(tmp_eps, fig, renderer, '-loose');
    try
        % Initialize the command to export to tiff using ghostscript
        cmd_str = ['-dEPSCrop -q -dNOPAUSE -dBATCH ' res_str ' -sDEVICE=tiff24nc'];
        % Set the font path
        fp = font_path();
        if ~isempty(fp)
            cmd_str = [cmd_str ' -sFONTPATH="' fp '"'];
        end
        % Add the filenames
        cmd_str = [cmd_str ' -sOutputFile="' tmp_nam '" "' tmp_eps '"'];
        % Execute the ghostscript command
        ghostscript(cmd_str);
    catch me
        % Delete the intermediate file
        delete(tmp_eps);
        rethrow(me);
    end
    % Delete the intermediate file
    delete(tmp_eps);
    % Read in the generated bitmap
    A = imread(tmp_nam);
    % Delete the temporary bitmap file
    delete(tmp_nam);
    % Set border pixels to the correct colour
    if isequal(bcol, 'none')
        bcol = [];
    elseif isequal(bcol, [1 1 1])
        bcol = uint8([255 255 255]);
    else
        for l = 1:size(A, 2)
            if ~all(reshape(A(:,l,:) == 255, [], 1))
                break;
            end
        end
        for r = size(A, 2):-1:l
            if ~all(reshape(A(:,r,:) == 255, [], 1))
                break;
            end
        end
        for t = 1:size(A, 1)
            if ~all(reshape(A(t,:,:) == 255, [], 1))
                break;
            end
        end
        for b = size(A, 1):-1:t
            if ~all(reshape(A(b,:,:) == 255, [], 1))
                break;
            end
        end
        bcol = uint8(median(single([reshape(A(:,[l r],:), [], size(A, 3)); reshape(A([t b],:,:), [], size(A, 3))]), 1));
        for c = 1:size(A, 3)
            A(:,[1:l-1, r+1:end],c) = bcol(c);
            A([1:t-1, b+1:end],:,c) = bcol(c);
        end
    end
else
    if nargin < 3
        renderer = '-opengl';
    end
    err = false;
    % Set paper size
    old_pos_mode = get(fig, 'PaperPositionMode');
    old_orientation = get(fig, 'PaperOrientation');
    set(fig, 'PaperPositionMode', 'auto', 'PaperOrientation', 'portrait');
    try
        % Print to tiff file
        print(fig, renderer, res_str, '-dtiff', tmp_nam);
        % Read in the printed file
        A = imread(tmp_nam);
        % Delete the temporary file
        delete(tmp_nam);
    catch ex
        err = true;
    end
    % Reset paper size
    set(fig, 'PaperPositionMode', old_pos_mode, 'PaperOrientation', old_orientation);
    % Throw any error that occurred
    if err
        rethrow(ex);
    end
    % Set the background color
    if isequal(bcol, 'none')
        bcol = [];
    else
        bcol = bcol * 255;
        if isequal(bcol, round(bcol))
            bcol = uint8(bcol);
        else
            bcol = squeeze(A(1,1,:));
        end
    end
end
% Check the output size is correct
if isequal(res, round(res))
    px = [px([4 3])*res 3];
    if ~isequal(size(A), px)
        % Correct the output size
        A = A(1:min(end,px(1)),1:min(end,px(2)),:);
    end
end
return
end

function print2eps(name, fig, varargin)
options = {'-depsc2'};
if nargin < 2
    fig = gcf;
elseif nargin > 2
    options = [options varargin];
end
% Construct the filename
if numel(name) < 5 || ~strcmpi(name(end-3:end), '.eps')
    name = [name '.eps']; % Add the missing extension
end
% Find all the used fonts in the figure
font_handles = findall(fig, '-property', 'FontName');
fonts = get(font_handles, 'FontName');
if ~iscell(fonts)
    fonts = {fonts};
end
% Map supported font aliases onto the correct name
fontsl = lower(fonts);
for a = 1:numel(fonts)
    f = fontsl{a};
    f(f==' ') = [];
    switch f
        case {'times', 'timesnewroman', 'times-roman'}
            fontsl{a} = 'times-roman';
        case {'arial', 'helvetica'}
            fontsl{a} = 'helvetica';
        case {'newcenturyschoolbook', 'newcenturyschlbk'}
            fontsl{a} = 'newcenturyschlbk';
        otherwise
    end
end
fontslu = unique(fontsl);
% Determine the font swap table
matlab_fonts = {'Helvetica', 'Times-Roman', 'Palatino', 'Bookman', 'Helvetica-Narrow', 'Symbol', ...
                'AvantGarde', 'NewCenturySchlbk', 'Courier', 'ZapfChancery', 'ZapfDingbats'};
matlab_fontsl = lower(matlab_fonts);
require_swap = find(~ismember(fontslu, matlab_fontsl));
unused_fonts = find(~ismember(matlab_fontsl, fontslu));
font_swap = cell(3, min(numel(require_swap), numel(unused_fonts)));
fonts_new = fonts;
for a = 1:size(font_swap, 2)
    font_swap{1,a} = find(strcmp(fontslu{require_swap(a)}, fontsl));
    font_swap{2,a} = matlab_fonts{unused_fonts(a)};
    font_swap{3,a} = fonts{font_swap{1,a}(1)};
    fonts_new(font_swap{1,a}) = {font_swap{2,a}};
end
% Swap the fonts
if ~isempty(font_swap)
    fonts_size = get(font_handles, 'FontSize');
    if iscell(fonts_size)
        fonts_size = cell2mat(fonts_size);
    end
    M = false(size(font_handles));
    % Loop because some changes may not stick first time, due to listeners
    c = 0;
    update = zeros(1000, 1);
    for b = 1:10 % Limit number of loops to avoid infinite loop case
        for a = 1:numel(M)
            M(a) = ~isequal(get(font_handles(a), 'FontName'), fonts_new{a}) || ~isequal(get(font_handles(a), 'FontSize'), fonts_size(a));
            if M(a)
                set(font_handles(a), 'FontName', fonts_new{a}, 'FontSize', fonts_size(a));
                c = c + 1;
                update(c) = a;
            end
        end
        if ~any(M)
            break;
        end
    end
    % Compute the order to revert fonts later, without the need of a loop
    [update, M] = unique(update(1:c));
    [M, M] = sort(M);
    update = reshape(update(M), 1, []);
end
% Set paper size
old_pos_mode = get(fig, 'PaperPositionMode');
old_orientation = get(fig, 'PaperOrientation');
set(fig, 'PaperPositionMode', 'auto', 'PaperOrientation', 'portrait');
% MATLAB bug fix - black and white text can come out inverted sometimes
% Find the white and black text
white_text_handles = findobj(fig, 'Type', 'text');
M = get(white_text_handles, 'Color');
if iscell(M)
    M = cell2mat(M);
end
M = sum(M, 2);
black_text_handles = white_text_handles(M == 0);
white_text_handles = white_text_handles(M == 3);
% Set the font colors slightly off their correct values
set(black_text_handles, 'Color', [0 0 0] + eps);
set(white_text_handles, 'Color', [1 1 1] - eps);
% MATLAB bug fix - white lines can come out funny sometimes
% Find the white lines
white_line_handles = findobj(fig, 'Type', 'line');
M = get(white_line_handles, 'Color');
if iscell(M)
    M = cell2mat(M);
end
white_line_handles = white_line_handles(sum(M, 2) == 3);
% Set the line color slightly off white
set(white_line_handles, 'Color', [1 1 1] - 0.00001);
% Print to eps file
print(fig, options{:}, name);
% Reset the font and line colors
set(black_text_handles, 'Color', [0 0 0]);
set(white_text_handles, 'Color', [1 1 1]);
set(white_line_handles, 'Color', [1 1 1]);
% Reset paper size
set(fig, 'PaperPositionMode', old_pos_mode, 'PaperOrientation', old_orientation);
% Correct the fonts
if ~isempty(font_swap)
    % Reset the font names in the figure
    for a = update
        set(font_handles(a), 'FontName', fonts{a}, 'FontSize', fonts_size(a));
    end
    % Replace the font names in the eps file
    font_swap = font_swap(2:3,:);
    try
        swap_fonts(name, font_swap{:});
    catch
        warning('swap_fonts() failed. This is usually because the figure contains a large number of patch objects. Consider exporting to a bitmap format in this case.');
        return
    end
end
% Fix the line styles
try
    fix_lines(name);
catch
    warning('fix_lines() failed. This is usually because the figure contains a large number of patch objects. Consider exporting to a bitmap format in this case.');
end
return
end

function swap_fonts(fname, varargin)
% Read in the file
fh = fopen(fname, 'r');
if fh == -1
    error('File %s not found.', fname);
end
try
    fstrm = fread(fh, '*char')';
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);

% Replace the font names
for a = 1:2:numel(varargin)
    fstrm = regexprep(fstrm, [varargin{a} '-?[a-zA-Z]*\>'], varargin{a+1}(~isspace(varargin{a+1})));
end

% Write out the updated file
fh = fopen(fname, 'w');
if fh == -1
    error('Unable to open %s for writing.', fname2);
end
try
    fwrite(fh, fstrm, 'char*1');
catch ex
    fclose(fh);
    rethrow(ex);
end
fclose(fh);
return
end

function string = user_string(string_name, string)
if ~ischar(string_name)
    error('string_name must be a string.');
end
% Create the full filename
string_name = fullfile(fileparts(mfilename('fullpath')), '.ignore', [string_name '.txt']);
if nargin > 1
    % Set string
    if ~ischar(string)
        error('new_string must be a string.');
    end
    % Make sure the save directory exists
    dname = fileparts(string_name);
    if ~exist(dname, 'dir')
        % Create the directory
        try
            if ~mkdir(dname)                
                string = false;
                return
            end
        catch
            string = false;
            return
        end
        % Make it hidden
        try
            fileattrib(dname, '+h');
        catch
        end
    end
    % Write the file
    fid = fopen(string_name, 'wt');
    if fid == -1
        string = false;
        return
    end
    try
        fprintf(fid, '%s', string);
    catch
        fclose(fid);
        string = false;
        return
    end
    fclose(fid);
    string = true;
else
    % Get string
    fid = fopen(string_name, 'rt');
    if fid == -1
        string = '';
        return
    end
    string = fgetl(fid);
    fclose(fid);
end
return
end

