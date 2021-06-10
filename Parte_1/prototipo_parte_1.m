clc;clear all;

pkg load image

A = imread("fondo_verde.jpg");
B = imread("playa.jpg");

[m n z] = size(B);

C=zeros(m,n,z);

tol = 0.20;



'''
for i=1:m
  for j=1:n
    if (0 <= A(i,j,1) && A(i,j,1) < 255-255*tol) && (255-255*tol < A(i,j,2) && A(i,j,2) <= 255) && (0 <= A(i,j,3) && A(i,j,3) < 255-255*tol)
      C(i,j,:) = B(i,j,:);
    else
      C(i,j,:) = A(i,j,:);
    endif
  endfor
endfor'''

imshow(uint8(C))


