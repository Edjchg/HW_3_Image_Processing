
%Funciion que aplica la transformada de un 
%pixel a color en una matriz 4x4.
%Entrada: Matriz 1x1x3.
%Salida:Matriz 4x4.
function A=F(P)
  r=P(1,1,1);
  g=P(1,1,2);
  b=P(1,1,3);
  A=[0 -r -g -b;
     r 0 -b g;
     g b 0 -r; 
     b -g r 0];
endfunction