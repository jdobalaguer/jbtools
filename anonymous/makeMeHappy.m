%% MAKEMEHAPPY()
% this is a function to make chrissi
% feel better when she needs a hug
% (try calling it multiple times!)

%% function
function varargout = makeMeHappy(varargin)
    varargout = cell(1,nargout);
    
    [speed,link] = deal([],{});
    [speed(end+1),link{end+1}] = deal(0.05,'http://media.giphy.com/media/Vpdzoviaa1P3y/giphy.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'http://media.giphy.com/media/Z55SnPVWc1W3C/giphy.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'http://media.giphy.com/media/ZKt2uXG72suxG/giphy.gif');
    [speed(end+1),link{end+1}] = deal(0.08,'http://media.giphy.com/media/10R5vINNhdSCje/giphy.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'http://media.giphy.com/media/Jjq7X7QCYuRUc/giphy.gif');
    [speed(end+1),link{end+1}] = deal(0.20,'http://media.giphy.com/media/JzvALW6b4Plss/giphy.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'http://media.giphy.com/media/fR7EroQzUozxm/giphy.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'http://gifsec.com/wp-content/uploads/GIF/2014/07/bunny-popcorn-gif.gif?gs=a');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/8a2edcbe3f745e31dd67921874729de2/tumblr_n5w7g3TdkM1shxu82o2_400.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/797ca7857d59a583c48bd3bdf399587a/tumblr_mg46zs46ww1rlatyqo1_250.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://31.media.tumblr.com/tumblr_m81yf4JCjO1r9accbo1_500.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/b0c12a00e5f75097dfc311d9326da05a/tumblr_n0e2qlyx7H1s0jfv8o1_250.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/55e2b8603d7bef0979f46634e06adee6/tumblr_n0e2qlyx7H1s0jfv8o2_500.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/41d29a975e1ffa738305ed7a7395d3a2/tumblr_n0e2qlyx7H1s0jfv8o3_400.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://38.media.tumblr.com/bdd50bc8411c5fa73bad4dd86a43dd89/tumblr_n0e2qlyx7H1s0jfv8o4_500.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://38.media.tumblr.com/fc4c2889e50df2bcdbc797cc4b0e2709/tumblr_mkjtp20smM1qj827ro7_250.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/42be686f0a3d3d3ba1f79884941ae212/tumblr_mkjtp20smM1qj827ro3_250.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/0fe558b6f9df532356fdfa8584219553/tumblr_mkjtp20smM1qj827ro1_250.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://38.media.tumblr.com/db3e89d395b8e43613ecbbb1369a714a/tumblr_mkjtp20smM1qj827ro4_250.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/94e678ac39ad4bf58b73d13259d56084/tumblr_mkjtp20smM1qj827ro2_250.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://38.media.tumblr.com/d25ba57d2c53c1cce206dd33bcd8f2ac/tumblr_mkjtp20smM1qj827ro5_500.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://38.media.tumblr.com/d1ad03472b8d9f99ba2d13107a171463/tumblr_mkjtp20smM1qj827ro8_250.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/40a45ddeebc1f51a68d9f03652a576ea/tumblr_mkjtp20smM1qj827ro10_500.gif');
    [speed(end+1),link{end+1}] = deal(0.20,'https://33.media.tumblr.com/tumblr_m4fiobNlsY1qmpppfo1_500.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/556ece8d2e8a37778a669fec46cfc048/tumblr_mqpidzVPfu1syoorco1_500.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/df832d1dde07f0bfc32024f7b9493159/tumblr_n9e6kx40Fv1qbxi45o2_r1_500.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://38.media.tumblr.com/tumblr_mavsstaP5O1rqpdpvo1_250.gif');
    [speed(end+1),link{end+1}] = deal(0.10,'https://33.media.tumblr.com/2dad9adc466d2eff0d4928b919cd6914/tumblr_mo7pcvKSOy1ry1utqo1_400.gif');
    
    try
        if ~isunix(),         fprintf('bunnies like apples. find an apple and bunnies will come to you!\n'); return; end
        if nargin>1,          fprintf('hej, chri. no cheating. you''ll scare the bunnies!\n'); return; end
        i = randi(length(link)); if nargin==1, i = varargin{1}; end
        if ~isnumeric(i),     fprintf('hej, chri. no cheating. it needs to be a number\n'); return; end
        if ~isscalar(i),      fprintf('hej, chri. no cheating. it can''t be a vector. you need to go one by one :*\n'); return; end
        if isnan(i),          fprintf('hej, chri. no cheating. bunnies are not a number ><\n'); return; end
        if ~isfinite(i),      fprintf('infinite. really. mama bunny would be proud of you..\n'); return; end
        if i < 1,             fprintf('hej, chri. no cheating. it needs to be a *positive* number!\n'); return; end
        if i > length(speed), fprintf('schade, there are only %d GIFs :(\ncould you try with a smaller number?\n',length(link)); return; end
        if i ~= round(i),     fprintf('hej, chri. no cheating. this is a decimal. what were you expecting, a bit of GIF %d and a bit of GIF %d?\n',floor(i),ceil(i)); return; end
        if nargout > 1,       fprintf('hej, chri. no cheating. there''s only one output (the number of the GIF).\nyou cant take any bunny home..\n'); return; end

        if ~exist('websave','file'),urlwrite(link{i},'makemehappy.gif');
        else                        websave('makemehappy.gif',link{i});
        end
        evalc('!qlmanage -p makemehappy.gif');
        delete('makemehappy.gif');
        varargout = repmat({i},1,nargout);
    catch e
        if exist('makemehappy.gif','file'), delete('makemehappy.gif'); end
        fprintf('oh, no! bunnies are sleeping!\n you need to have an internet connection. if you''re connected, then something went wrong :(\ncopy this to jan:\n');
        fprintf('mess : %s\n',e.message);
        fprintf('file : %s\n',e.stack.file);
        fprintf('name : %s\n',e.stack.name);
        fprintf('line : %d\n',e.stack.line);
    end
end
