% #{
% Funccion que implementa el metodo
% Fast Digital Image Inpaiting con un numero de iteraciones.
% Entradas:
%   img:Imagen a restaurar
%   mask:region de la imagen a restaurar del mismo tamaño que img
%   kernel:kernel promedio con el que se aplicara la convolucion en el proceso de
%          restauracion
%   itermax: numero de veces que se aplicara el proceso de restauracion.
% Salida:
%   Y:Imagen restaurada del mismo tamaño que img
% #}
function Y=inpaint(img, mask, kernel, itermax=10)
  A=im2double(img); %Conversion a doubles para realizar la convolucion
  mask=im2double(mask); 
  mask=binaria(mask);% Aseguramiento de una mascara como imagen binaria.
  for i=1:itermax
    T=conv2(A, kernel, 'same'); %Convolucion con un filtro promedio
    %Para la restauracion solo se afectan los valores de la region a restaurar
    T(mask==0)=0;
    A(mask==1)=0;
    A=A+T;
  endfor
  Y=A;
endfunction