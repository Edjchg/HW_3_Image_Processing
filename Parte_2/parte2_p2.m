

clc; clear; close all;
pkg load image

A=imread('lena.jpg');
%A=imresize(A,0.5);

subplot(121)
imshow(A)
title('Imagen Original')

%La imagen se convierte a double para realizar calculos.
A=im2double(A);
[m,n,_]=size(A);
%Se crea una celda de mxn para guardar 
%entrada 4x4 transfromada discreta de fuorier.
B=cell([m,n]);

%Recorrido de las entrada de B
for u=1:m
  u
  for v=1:n
    B(u,v)=zeros(4,4);
    %Recorrido para la suma.
    for r=0:m-1
      for s=0:n-1
        B(u,v) = cell2mat(B(u,v))+E(r,u,m)*F(A(r+1,s+1,:))*E(s,v,n);
      endfor
    endfor
    %Se termina de aplicar la formula.
    B(u,v)=(1/sqrt(m*n))*cell2mat(B(u,v));
  endfor
endfor

%Se calcula la norma de cada entrada de la 
% tranformada discreta de fuorier.
C=zeros(m,n);
for i=1:m 
  for j=1:n
    C(i,j)=norm(cell2mat(B(i,j)), 'fro');
  endfor
endfor

%Se muestra el resultado.
subplot(122)
imshow(log(1+fftshift(C)),[])
title('DFT-2D de una imagen a color')


