function C = poner_fondo(A,B,tol, solo_verde)
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