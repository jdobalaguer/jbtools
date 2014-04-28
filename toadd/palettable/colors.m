% colors for plotting. options include 'ColourLovers' and 'Wong'.
function colors = colors(whichColors,n)
  
  if(nargin < 1)
    whichColors = 'ColourLovers';
  end
  
  if(nargin < 2)
    n = 20;
  end
  
  switch whichColors
    
    case 'Wong'

      allColors = [119, 168,  64;   % green
                   148, 188, 218;   % light blue
                   144,  55,  28;   % brick red
                    71,   6,	47;   % eggplant  
                   143, 119,  44;   % tan
                   216, 199, 225];  % lavender
  
  
    case 'ColourLovers'
    
      allColors = [233, 127,   2;   % party confetti
                   189,  21,  80;   % sugar hearts you
                    73,  10,  61;   % sugar cocktail
                    11,  72, 107;   % adrift in dreams
      						 138, 155,  15;   % happy balloon
      							 3,  54,  73;]; % acqua profonda
  end
                
  colors = allColors(1 + mod(0:n-1, length(allColors)),:)./255;
end