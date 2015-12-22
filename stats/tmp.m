
pars1 = [20, 6]; % [a,b]
pars2 = [ 2, 1];

%% analytical
bayes_beta2_plot(pars1,pars2);

%% ks-density
samples = 1e3;
n = 101;
z1 = betarnd(pars1(1),pars1(2),[samples,1]);
z2 = betarnd(pars2(1),pars2(2),[samples,1]);
zz = [z1,z2];

% density
z  = linspace(0,1,n);
bayes_pdf(zz,z,z);
fig_axis(struct('xlabel',{'\theta_1'},'ylabel',{'\theta_2'},'xtick',{[]},'ytick',{[]},'xlim',{[0,1]},'ylim',{[0,1]}));
axis('square'); fig_fontsize();

% histogram
% fig_figure();
% hist3(zz);

%% mcmc
samples = 1e3;
n = 101;
initial = [0.5,0.5];

beta = bayes_pdf_beta(pars1,pars2);
pdf  = @(z) beta(z(1),z(2));
zz   = slicesample(initial,samples,'pdf',pdf);

% density
z  = linspace(0,1,n);
bayes_pdf(zz,z,z);
fig_axis(struct('xlabel',{'\theta_1'},'ylabel',{'\theta_2'},'xtick',{[]},'ytick',{[]},'xlim',{[0,1]},'ylim',{[0,1]}));
axis('square'); fig_fontsize();

% histogram
% fig_figure();
% hist3(zz);
