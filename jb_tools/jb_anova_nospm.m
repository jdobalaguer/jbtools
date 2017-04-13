%jb_anova affords two different syntaxes:
%1: [Prob,Taffich, TERMSana]=jb_anova(Y, subj, {X1 X2 ..Xn}, options) where Y
%is the dependent variable vector, subj is the subject vector (variable of
%no interest), and X1, X2 ..Xn are the variable vectors, each of the same
%length( Y(k) is a measure corresponding to subject=subj(k), X1=X1(k),
%X2=X2(k)...
%
%2: [Prob,Taffich, TERMSana]=jb_anova(YMatrix, options) where Ymatrix is a
%matrix of n-dimensions, n being the number of variables (including
%subject). Here Y(s,x1,x2,..xn) is the unique measure for subject
%s corresponding to X1=x1, X2=x2..Xn=xn.
%
%Options:
%-'plotall'   :       plots all main effects & 2way
%interactions (default: only those significant at p<.2)
%-'noplot' :       noplot
%-{yname x1name x2name .. xnname}: replaces default names 'Y', 'X1', 'X2'... with
%custom names
%-{yname x1name x2name .. xnname {x1val1name x1val2name ...} {x2val1name x2val2name...} ...}: replaces default names 'X1', 'X2'... with
%custom names, and sets value names for each of the variables
%-'median' (syntax1 only) : computes medians for every combination of
%variables instead of means
%-includeboolean   (syntax1 only) : takes only measures where this vector
%of boolean is true
%

%% warnings

%#ok<*NCOMMA>
%#ok<*ISMAT>
%#ok<*AGROW>
%#ok<*ASGLU>
%#ok<*UDIM>
%#ok<*FNDSB>
%#ok<*TRYNC>

%% jb_anova
function [Prob,Taffich, TERMSana] = jb_anova(varargin)
    Y=varargin{1};
    if isnumeric(Y) && ndims(Y)>1,  syntax=2; nbdim=ndims(Y)-1; argoption = 2;
    else                            syntax=1; subjvect=varargin{2}; tabX=varargin{3}; nbdim=length(tabX); argoption = 4;
    end
    include=true(0); includename='all'; values=cell(1,nbdim); plotte=0; label={}; medianstyle=0; within =0; across =1; spss=0; fast=1;
    for narg=argoption:nargin
        switch class(varargin{narg})
            case 'logical' , include = varargin{narg}; includename=inputname(narg);
            case 'double', include = logical(varargin{narg}); includename=inputname(narg);
            case 'char',
                switch varargin{narg},
                    case 'mean', medianstyle=0;
                    case 'median', medianstyle=1;
                    case 'within', within=1; across=0;
                    case '+within', within=1;
                    case 'plotall', plotte=2;
                    case 'fast', fast=1;
                    case 'slow', fast=0;
                    case 'includeall', include=true(0); includename='all';
                    case 'spss', spss=1;
                    otherwise, plotte = ~sum(varargin{narg}=='n');
                end
            case 'cell',     label = varargin{narg};
        end
    end
    if plotte, glob; end
    if syntax==1,
        [Y, varyname]= valueandname(Y, 'Y');
        l=length(Y);
        if ~isempty(include),  else include=true(1,l); end
        trinclude=find(include);
        Yincl=Y(trinclude);
        valuename=cell(1,nbdim+1);
        matX=zeros(nbdim+1, length(trinclude));
        [matX(1,:), varname{1} allvalue{1}]= valueandname(subjvect, 'subject',trinclude, 'replace');
        for d=1:nbdim, [matX(d+1,:), varname{d+1}, allvalue{d+1} valuename{d+1}]= valueandname(tabX{d}, ['X' num2str(d)], trinclude, 'replace'); end
        matXincl=matX;
        l=length(Yincl);
        if across,
            if medianstyle,  MeanSubj =medianseparen(Yincl,matXincl);
            else             MeanSubj =meanseparen(Yincl,matXincl);
            end
            Prob.MeanSubj = MeanSubj;
            MeanSubj= missingsubj(MeanSubj, allvalue{1});
            [MeanSubj matXin]=enligne(MeanSubj);
        end
    else
        Prob.MeanSubj=Y;
        [Y matXin]=enligne(Y);
        MeanSubj=Y;
        l=length(Y);
        varyname='Y';
        include=true(1,l);
        trinclude=1:l;
        [subjvect varname{1} allvalue{1}]= valueandname(matXin(1,:), 'subject');
        within=0; across=1;
        for d=1:nbdim, [tabX{d}, varname{d+1}, allvalue{d+1}, valuename{d+1}]= valueandname(matXin(d+1,:), ['X' num2str(d)]); end
    end
    if ~isempty(label), varname = label; end
    if ~isempty(label) && ~isempty(label{1}), varyname=label{1}; end
    for d=1:nbdim,
        if length(label)>d && isempty(label{d+1}), varname{d+1}=label{d+1}; end
        if length(label)>nbdim+d && ~isempty(label{nbdim+d+1}), valuename{d+1}=label{nbdim+d+1}; end
    end
    if spss,
        Prob = reshape(MeanSubj, size(MeanSubj,1), numel(MeanSubj)/size(MeanSubj,1));
        uisave(Prob);
        return;
    end
    if within,
        subjpos = separe(matXincl(1,:));
        for s=1:length(allvalue{1}),
            Ys = Yincl(subjpos{s});
            matXs = matXincl(2:end, subjpos{s});
            matXs2 = mat2cell(matXs', length(Ys), ones(1,nbdim));
            [P,Tab,STATS,TERMS]=anovan_t(Ys, matXs2,'varnames', varname(2:end),'model','full', 'display', 'off');
            Ps(s,:)= P';
        end
        Prob.withinanovaall=Ps;
        Prob.withinanova = sum(Ps<.05,1);
        if ~across,
            Prob.name=['within_subj_anova,' varyname ';'];
            Prob.include=includename;
        end
        Onemoreline = {'Nb subj'};
        Onemoreline = [ Onemoreline num2cell(Prob.withinanova) cell(1,2)];
        if ~across,
            Tab(:,end+1) = Onemoreline';
            figh = statdisptable_t(Tab, 'N-Way ANOVA', 'Analysis of Variance', 'Constrained (Type III) sums of squares.');
        end
    end
    if across && ~fast,
        matXin2=mat2cell(matXin', length(MeanSubj), ones(1,nbdim+1));
        [P,Tab,STATS,TERMS]=anovan_t(MeanSubj, matXin2,'varnames', varname, 'random',1 ,'model','full', 'display', 'off');
        inclana=~TERMS(:,1)';
        inclline=inclana;
        inclline(end)=1;
        inclline=[1 inclline 1 1];
        Taffich=Tab(find(inclline),[1 2 3 5 6 7]);
        if within,
            Onemoreline(end+1)={ []};
            Taffich(:,end+1) = Onemoreline';
        end
        figh = statdisptable_t(Taffich, 'N-Way ANOVA', 'Analysis of Variance', 'Constrained (Type III) sums of squares.');
        Pfull=P;
        P=P(inclana);
        TERMSana=TERMS(inclana,:);
        Prob.anova=P';
        Prob.name=['anova,' varyname ';'];
        Prob.include=includename;
        for ana=1:length(P),
            factors{ana} = TERMSana(ana,:);
            factors{ana} = find(factors{ana});
            effectname{ana} = Taffich(ana+1,1);
            effectname{ana} = effectname{ana}{1};
        end
    end
    if across && fast,
        siz = max(matXin');
        MeanSubj2 = reshape(MeanSubj, siz);
        MeanSubj2 = permute(MeanSubj2, [1 nbdim+1:-1:2]);  %invert all dimensions (except subjects)
        MeanSubj2 = reshape(MeanSubj2, siz(1), prod(siz(2:end)));
        [efs F cdfs P eps dfs b] = repanova(MeanSubj2, siz(2:end), varname(2:end));
        for ana=1:length(P)
            factors{ana} = 1 + efs{ana} ;       %all inverted
        effectname{ana} = varname(factors{ana});
        effectname{ana} = cellfun(@(x) [x ', '], effectname{ana}, 'UniformOutput', false);   %aa a coma after each variable
        effectname{ana} = cell2mat(effectname{ana});                  %into a single string
        effectname{ana} = effectname{ana}(1:end-2);
        end
        Prob.name=['anova,' varyname ';'];
        Prob.anova =P;
        Prob.include=includename;
    end
    if across  && ~fast,
        if plotte, strinput='pd'; else strinput='nd'; end
        for ana=1:length(P)
            signif=P(ana)<[.2 .05 .01];
            if signif(1) %on continue si effet au moins trendy
                tailledeffet={'trendy' 'significatif' 'highly significant'};
                disp(' ');
                disp(['effet ' effectname{ana} ' : ' tailledeffet{sum(signif)}   '(' num2str(P(ana)) ' )' ]);
            end
            if signif(1) || plotte==2      %on plotte aussi si plot all

                switch length(factors{ana}) %type d'effet
                    case 1, %main effects
                        effecttype='main effect';
                        dimm=factors{ana} ;  %dim du main effect
                        Prob.(varname{dimm}) = myttest(Y,subjvect, tabX{dimm-1}, include ,strinput,  { varyname varname{dimm} valuename{dimm}});

                    case 2, %2way interaction
                        effecttype='interaction';
                        dimm=factors{ana} ;  %les deux dimensions croisŽes
                        Prob.([varname{dimm(1)} '_' varname{dimm(2)}])  = myttestint(Y, subjvect, tabX{dimm(1)-1}, tabX{dimm(2)-1}, ...
                            include, strinput,  { varyname varname{dimm(1)} varname{dimm(2)} valuename{dimm(1)} valuename{dimm(2)}});

                    case 3, %3way interaction
                                     effecttype='3way interaction';
                        dimm=factors{ana} ;  %les deux dimensions croisŽes
                        Prob.([varname{dimm(1)} '_' varname{dimm(2)} '_' varname{dimm(3)}])  = myttest3(Y, subjvect, tabX{dimm(1)-1}, tabX{dimm(2)-1}, tabX{dimm(3)-1},...
                            include, strinput,  { varyname varname{dimm(1)} varname{dimm(2)} varname{dimm(3)} valuename{dimm(1)} valuename{dimm(2)} valuename{dimm(3)}});

                end
            end
        end

    end
end

%% enligne
function [numat, regress] = enligne(mat)
    siz = size(mat);
    ndim = length(siz);
    numat(1,:)= reshape( mat, [1 prod(siz)]);
    if nargout>=2
        for d=1:ndim
            nushape = ones(1,ndim);
            nushape(d) = siz(d);
            vect = reshape(1:siz(d), nushape);
            siz2 = siz;
            siz2(d) =1 ;
            dimmat{d} = repmat( vect, siz2);
        end
        for d=1:ndim, regress(d,:) = reshape(dimmat{d}, [1 prod(siz)]); end
    end
end

%% valueandname
function [vect, varname, values, valuename]= valueandname(var, defname, include, doreplace)
    switch class(var)
        %if isstr(var)  %le nom rentr? en param?tre, faut donc extraire la valeur
        case 'char'
            varname=var;
            vect= evalin('base', var);
            if nargin>2, vect=vect(include); end
            if nargout>3, %si valuename demand?
                ya=0;
                try ya=evalin ('base', ['isfield (label, ' var ')']); end
                if ya, valuename=evalin('base', ['label.(' var ')']);
                else valuename=num2cell(num2str(sortsingle(vect)'));
                end
            end
        case {'double' 'logical'}
            var=double(var);
            varname=defname;
            vect=var;
            if nargin>2, vect=vect(include); end
            if nargout>3,
                valuename=num2cell(num2str(sortsingle(vect)'));
            end
        case 'struct'
            varname=var.name;
            vect=var.vect;
            if nargin>2, vect=vect(include); end
            if nargout>3,
                valuename={};
                for val=1:length(var.allvalues)
                    if ~isempty(find(vect==var.allvalues(val),1)), valuename{end+1}=var.valuename{val}; end
                end
            end
    end
    if nargin>=4 && strcmp(doreplace, 'replace'),   [vect values]=replace(vect);
    else                                            values = [];
    end
end

%% sortsingle
function Tab=sortsingle(Tab)
    Tab=sort(Tab);
    if isempty(Tab), return; end
    if isnumeric(Tab),changes = (Tab~= decale(Tab));
    else changes = ~streq(Tab, decale(Tab)); end
    changes(1)=true;
    Tab = Tab(changes);
end

%% decale
function u = decale(x,n,memetaille, defvalue)
    [a b]=size(x);
    if nargin<2, n=1; end
    if nargin<3, memetaille=1; end
    if nargin<4, defvalue=0; end
    if n>0
        u=[defvalue*ones(a,n) x];
        if memetaille, u=u(1:a, 1:b); end
    else
        u=x(:,-n+1:b);
        if memetaille, u(1:a,b+n+1:b)=defvalue*ones(a,-n); end
    end
end

%% repanova
function [efs,F,cdfs,p,eps,dfs,b]=repanova(d,D,fn)
    if nargin<3, for f=1:length(D); fn{f}=sprintf('%d',f); end; end
    Nf = length(D);
    Nd = prod(D);
    Ne = 2^Nf - 1;
    Nr = size(d,1);
    assert(size(d,2)==Nd,sprintf('data has %d conditions; design only %d',size(d,2),Nd));
    sc = cell(Nf,2);
    for f = 1 : Nf
        sc{f,1} = ones(D(f),1);
        sc{f,2} = detrend(eye(D(f)),0);
    end 
    for e = 1:Ne
        cw = num2binvec(e,Nf)+1;
        c  = sc{1,cw(Nf)};
        for f = 2:Nf, c = kron(c,sc{f,cw(Nf-f+1)}); end
        y = d * c;
        nc = size(y,2);
        df1 = rank(c);
        df2 = df1*(Nr-1);
        b{e} = mean(y);
        ss   =  sum(y*b{e}');
        mse  = (sum(diag(y'*y)) - ss)/df2;
        mss  =  ss/df1;
        V      = cov(y);
        eps(e) = trace(V)^2 / (df1*trace(V'*V));
        efs{e} = Nf+1-find(cw==2);
        F(e)   = mss/mse;
        dfs(e,:)  = [df1 df2];
        cdfs(e,:) = eps(e)*dfs(e,:);
        p(e) = 1-fcdf(F(e),cdfs(e,1),cdfs(e,2));
        en=fn{efs{e}(1)};
        for f = 2:length(efs{e}), en = [en fn{efs{e}(f)}]; end
        fprintf('Effect %02d: %-18s F(%3.2f,%3.2f)=%4.3f,\tp=%4.3f \n',e,en,cdfs(e,1),cdfs(e,2),F(e),p(e));
    end
end

%% num2binvec
function b = num2binvec(d,p)
    if nargin<2, p=0; end
    d=abs(round(d));
    if(d==0), b = 0; else b=[]; while d>0, b=[rem(d,2) b]; d=floor(d/2); end; end
    b=[zeros(1,p-length(b)) b];
end
    