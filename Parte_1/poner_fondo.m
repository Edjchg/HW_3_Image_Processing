function C = poner_fondo(A,B,tol)
  [m n z] = size(B);
  C=zeros(m,n,z);
  for i=1:m
    for j=1:n
      rango=floor(255-255*tol);
      if (0 <= A(i,j,1) && A(i,i,1) <= rango) && (rango <= A(i,j,2) && A(i,j,2) <= 255) && (0 <= A(i,j,3) && A(i,j,3) <= -(rango-255))
        C(i,j,:) = B(i,j,:);
      else
        C(i,j,:) = A(i,j,:);
      endif
    endfor
  endfor
  C = uint8(C);
endfunction