//bon alors la resgression hein

// ordre : vivaldi
// handel
// vexento
// adhesive wombat

X = [59.524279 98.790711 15.664274  58.049465   62.39803 ;
     55.704163 90.675298 23.371763  54.55436  60.88922  ;
     92.329056 195.34717 173.21853  81.29567 51.82131 ;
     94.201679 205.56836 108.96227  80.67663  48.50983 ];
     
Y = [ 100  100  -100 -100];

[a,b,sig] = reglin(X',Y);
