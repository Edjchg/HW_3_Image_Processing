function C = poner_fondo(A,B,tol, solo_verde)
  % Esta funcion toma una imagen con fondo verde y el fondo deseado y las 
  % compone en una sola imagen. Esto anterior si el parametro solo_verde está en
  % 0. Si este parametro se encuentra en 1, entonces solo extrae el color verde
  % de la imagen.
  % Entradas: - Imagen A con fondo verde.
  %           - Imagen B que es el fondo deseado.
  %           - Una toleracia tol para la aceptación del rango de verdes.
  %           - Un boolean solo_verde que indica la operacion a realizar por la
  %             función.
  %Salidas: - La imagen C, ya sea ambas imagenes A y B compuestas, o solo
  %           la parte verde de la imagen A.
  [m n z] = size(B);
  C=zeros(m,n,z);
  a=zeros(m,n,z);
  rango=round(255-255*tol);
  % Analizando el canal rojo:
  a(:,:,1) = and(0 <= A(:,:,1), A(:,:,1) <= rango); 
  % Analizando el canal verde:
  a(:,:,2) = and(rango <= A(:,:,2), A(:,:,2) <= 255); 
  % Analizando el canal azul:
  a(:,:,3) = and(0 <= A(:,:,3), A(:,:,3) <= rango);
  a = and(a(:,:,1), a(:,:,2), a(:,:,3), a);
  % Los indices que coinciden con el anterior analisis entonces son
  % tomados del fondo para ponerlos en la imagen resultante.
  C(a) = B(a);
  if !solo_verde
    % Los indices contrarios a los encontrados en el analisis anterior,
    % son tomados de la figura para ponerlos en la imagen resultante.
    C(~a) = A(~a);
  endif
  C = uint8(C);
endfunction