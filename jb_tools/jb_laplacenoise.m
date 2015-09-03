function u = laplace_noise(n,m,sigma)
  % JB_LAPLACENOISE(n,m,sigma)
  % n : size(1)
  % m : size(2)
  % sigma is the standard deviation
  % taken from http://uk.mathworks.com/matlabcentral/newsreader/view_thread/33550

  x=rand(n,m);
  j=find(x<1/2);
  k=find(x>=1/2);
  u(j)=(sigma/sqrt(2)).*log(2.*x(j));
  u(k)=-(sigma/sqrt(2)).*log(2.*(1-x(k)));
  u=reshape(u,n,m);
end