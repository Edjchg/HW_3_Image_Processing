function C = extraer_verde(A, tol)
  [m n k] = size(A);
  if k==3
    C=zeros(m,n,k);
    for i=1:m
      for j=1:n
        if (0 <= A(i,j,1) && A(i,i,1) <= floor(255-255*tol)) && (floor(255-255*tol) <= A(i,j,2) && A(i,j,2) <= 255) && (0 <= A(i,j,3) && A(i,j,3) <= floor(255*tol))
        %if 0 == A(i,j,1) && A(i,j,2) == 255 && 0 == A(i,j,3) 
        %  C(i,j,:) = B(i,j,:);
        %else
          C(i,j,:) = A(i,j,:);
        endif
      endfor
    endfor
  endif
  %C=uint8(255-C(:,:,2));
  %C=255-C;
endfunction