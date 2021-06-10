clc;clear all;clear;

pkg load image

%Cargar la imagen con el fondo verde:
imagen = imread("fondo_verde.jpg");
[m,n,k] =size(imagen);
subplot(2,3,1)
imshow(imagen)
title("Imagen con fondo verde.")

%Cargar el fondo que se desea poner a la imagen:
fondo_deseado = imread("playa.jpg");
subplot(2,3,2)
imshow(fondo_deseado)
title("Fondo deseado")

%Poner el borde a la imagen y componerla:
tol = 0.34;
imagen_compuesta = poner_fondo(imagen, fondo_deseado, tol, 0);
subplot(2,3,3)
imshow(imagen_compuesta)
title("Imagen compuesta")


%Extraer la silueta del fondo verde:
silueta = poner_fondo(imagen, fondo_deseado, tol, 1);

%Hacer a la silueta totalmente binaria:
silueta_binaria = binaria(silueta(:,:,2));

%Creando elemento estructurado:
C=ones(3);

%Borde interno: A-(A erosion B)
erosion=imerode(silueta_binaria,C);
borde_silueta=silueta_binaria&~erosion;


%Ensanchar bordes:
D=ones(3);
bordes_anchos = imdilate(borde_silueta, D);
subplot(2,3,4)
imshow(bordes_anchos)
title("Bordes ensanchandos de la silueta")


%Imagen a restaurar y su mascara:

imagen_compuesta(:,:,1) = imagen_compuesta(:,:,1)+bordes_anchos*255;
imagen_compuesta(:,:,2) = imagen_compuesta(:,:,2)+bordes_anchos*255;
imagen_compuesta(:,:,3) = imagen_compuesta(:,:,3)+bordes_anchos*255;

subplot(2,3,5)
imshow(imagen_compuesta)
title("Imagen a restaurar y su mascara")

%Restaurar imagen:
a=0.073235; b=0.176765; 
c=0.125;

M=[a b a;b 0 b;a b a];
imagen_restaurada=zeros(m,n,3);
imagen_restaurada(:,:,1)=inpaint(imagen_compuesta(:,:,1), bordes_anchos, M, 200);
imagen_restaurada(:,:,2)=inpaint(imagen_compuesta(:,:,2), bordes_anchos, M, 200);
imagen_restaurada(:,:,3)=inpaint(imagen_compuesta(:,:,3), bordes_anchos, M, 200);

subplot(2,3,6)
imshow(imagen_restaurada)
title("Imagen restaurada")


