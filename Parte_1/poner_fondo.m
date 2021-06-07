function C = poner_fondo(A,B,tol)
  [m n z] = size(B);
  C=zeros(m,n,z);
  for i=1:m
    for j=1:n
      if (0 <= A(i,j,1) && A(i,i,1) <= floor(255-255*tol)) && (floor(255-255*tol) <= A(i,j,2) && A(i,j,2) <= 255) && (0 <= A(i,j,3) && A(i,j,3) <= floor(255*tol))
        C(i,j,:) = B(i,j,:);
      else
        C(i,j,:) = A(i,j,:);
      endif
    endfor
  endfor
  C = uint8(C);
endfunction