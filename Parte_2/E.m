
%Forma la matriz que representa la formula de Euler
%Entrada : p,q,r: parametros de seno y coseno.
%Salida: Matriz 4x4.
function A=E(p,q,r)
  J1=[0 1 -(3)^(1/2) 1; 
      1 0 -1 (3)^(1/2); 
      (3)^(1/2) -1 0 1; 
      1 -(3)^(1/2) 1 0];
  %J1=1/(sqrt(3))*[0 -1 -1 -1; 1 0 -1 1; 1 1 0 -1; 1 -1 1 0]; 
  %A=exp(-2*pi*J1*(p*q)/r);
   A=eye(4)*cos(2*pi*(p*q/r))-J1*sin(2*pi*(p*q/r));
endfunction

