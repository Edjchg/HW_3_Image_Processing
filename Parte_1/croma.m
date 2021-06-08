function imagen_restaurada = croma(imagen_verde, imagen_fondo, tol)
  [m n k] = size(imagen_verde);
  %Uniendo la imagen con fondo verde y el fondo deseado.
  imagen_compuesta=poner_fondo(imagen_verde, imagen_fondo, tol);
  %Extraer la silueta del fondo verde:
  silueta = extraer_verde(imagen_verde, 0.3);
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
  
  
  imagen_compuesta(:,:,1) = imagen_compuesta(:,:,1)+bordes_anchos*255;
  imagen_compuesta(:,:,2) = imagen_compuesta(:,:,2)+bordes_anchos*255;
  imagen_compuesta(:,:,3) = imagen_compuesta(:,:,3)+bordes_anchos*255;
  
  %Restaurar imagen:
  a=0.073235; b=0.176765; 
  c=0.125;

  M=[a b a;b 0 b;a b a];
  imagen_restaurada=zeros(m,n,k);
  imagen_restaurada(:,:,1)=inpaint(imagen_compuesta(:,:,1), bordes_anchos, M, 200);
  imagen_restaurada(:,:,2)=inpaint(imagen_compuesta(:,:,2), bordes_anchos, M, 200);
  imagen_restaurada(:,:,3)=inpaint(imagen_compuesta(:,:,3), bordes_anchos, M, 200);
endfunction