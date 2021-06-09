clc;clear all;
pkg load image

%Leyendo la imagen con fondo verde:
A = imread("fondo_verde.jpg");
subplot(1,3,1);
imshow(A)
title("Imagen fondo verde")

%Leyendo la imagen con el fondo deseado:
B = imread("playa.jpg");
subplot(1,3,2)
imshow(B)
title("Imagen de fondo")

%Combinando la imagen con fondo verde y el fondo deseado:
tol = 0.3333;
C = poner_fondo(A,B, tol);
subplot(1,3,3)
imshow(C)
title("Imagen compuesta")


imshow(C)
