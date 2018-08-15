%define a(x) 1+b(x)
%define b(x) 2*x

mov ax, a(8)
# mov ax, 1+2*8