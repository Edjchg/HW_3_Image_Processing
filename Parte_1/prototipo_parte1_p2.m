clc; close all; clear

A = imread("resultado_parte_1.jpg");

[m n z] = size(A);

B = imread("maskara_2.png");

B = binaria(B);
%imshow(B)
a=0.073235; b=0.176765; 
c=0.125;

M=[a b a;b 0 b;a b a];

C=zeros(m,n,z);

for k=1:z
  C(:,:,k) = inpaint(A(:,:,k), B(:,:,1), M);
endfor

%C = inpaint(A,B,M);
subplot(1,3,1)
imshow(A)
title("Imagen original")

subplot(1,3,2)
imshow(B)
title("Máscara")

subplot(1,3,3)
imshow(C)
title("Imagen Restaurada")