%=========================================================================%
%                                                                         %
%  Autors: Enrico Bertolazzi                                              %
%          Department of Industrial Engineering                           %
%          University of Trento                                           %
%          enrico.bertolazzi@unitn.it                                     %
%          m.fregox@gmail.com                                             %
%                                                                         %
%=========================================================================%
% Driver test program to check Clothoids lib                              %
%=========================================================================%

addpath('../matlab');

clear all ;
close all ;

X = [2.9265642,2.6734362,2.5109322,1.9078122,1.1859282,1.9249962, ...
     2.8265562,0.00468420000000025,-2.826567,-1.9437558,-1.1859438, ...
     -1.9062558,-2.501565,-2.6734386,-2.9265642,-2.6187522,-1.1406318, ...
     -0.8968758,-1.4562558,-1.9062558,-0.00468780000000013,1.9078122, ...
     1.4468682,0.8968722,1.1406282,2.6187522, 2.9265642 ] ;
Y = [-1.707808758,-1.707808758,-2.367185958,-2.582810358,-2.582810358, ...
     -1.167184758,0.915619242,3.178123242,0.915619242,-1.150000758, ...
     -2.582810358,-2.582810358,-2.393750358,-1.707808758,-1.707808758, ...
     -3.178123242,-3.178123242,-2.989063158,-0.915616758,0.925003242, ...
     2.953123242,0.925003242,-0.915616758,-2.989063158,-3.178123242,-3.178123242, -1.707808758 ] ;

S  = ClothoidSplineG2() ;
SL = S.buildP2( X, Y ) ;


%DX = X(2:end)-X(1:end-1);
%DY = Y(2:end)-Y(1:end-1);
%T  = [0,cumsum(hypot(DX,DY))];
[ T, ~, ~ ] = SL.getSTK();

ppX = spline( T, X );
ppY = spline( T, Y );

subplot(2,1,1);



TT = T(1):(T(end)-T(1))/1000:T(end);
XX = ppval(ppX,TT);
YY = ppval(ppY,TT);
DXX = ppval(fnder(ppX,1),TT);
DYY = ppval(fnder(ppY,1),TT);
DDXX = ppval(fnder(ppX,2),TT);
DDYY = ppval(fnder(ppY,2),TT);
plot(8+XX,YY,'Linewidth',3);
hold on
SL.plot() ;


axis equal

subplot(2,1,2);

KUR = (DXX.*DDYY-DYY.*DDXX)./hypot(DXX,DYY);
plot( TT, KUR );
hold on
SL.plotCurvature(1000) ;


axis equal
