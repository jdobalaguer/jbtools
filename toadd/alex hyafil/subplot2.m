function [theAxis m1 m2] = subplot2(varargin)
%[theAxis n1 n2] = subplot2(n1, n2, x1, x2)
% ou [theAxis n1 n2] = subplot(n, x)

if nargin==2,
    n1 = varargin{1};
    n2 = 1;
    x1 = varargin{2};
    x2 =1;
    theAxis = subplot(n1, n2, x);
    
else
    n1 = varargin{1};
    n2 = varargin{2};
    x1 = varargin{3};
    x2 = varargin{4};
end


if (n1==1 | n2==1) & n1*n2>=4
    n = n1*n2;
    x = x1*x2;
    m1 = ceil( sqrt(n));
    m2 = ceil(n / m1);
else
    x = x1 + n1*(x2-1);
    m1 = n1;
    m2 =n2;
end

theAxis = subplot(m1, m2, x);
