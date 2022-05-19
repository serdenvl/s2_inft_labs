disp("\n������� 1\n")

M = [ 1 0 0 0 0 0; 
      0 2 0 0 0 0; 
      0 0 3 0 0 0;
      0 0 0 3 0 0;
      0 0 0 0 2 0;
      0 0 0 0 0 1;
    ]
    
disp("\n������������: "); disp(det(M));

disp("\n��������: "); disp(inv(M));


disp("enter ��� �����������")
clear()
pause()
disp("\n������� 2\n")


function r = f2(x)
  if (abs(x) < 1)
    r = acos(x);
    return;
  else
    r = 1.2^x - x^1.2;
    return;
  endif
endfunction

disp("   X        F(x)");
R = [];
for i = 0.2 : 0.4 : 2.2
  R = [R; i f2(i)];
endfor
disp(R)


disp("enter ��� �����������")
pause()
disp("\n������� 3\n")


function r = f3(x,y)
  r = cos(y).+x.*y;
  return;  
endfunction

[x y] = meshgrid(0:1, 0:1);
mesh(x, y, f3(x,y));

[x y] = ode45(@f3, [0 1], [0.2]);
disp("������� ���� (ode45): "); disp([x y]);

disp("enter ��� �����������")
pause()
disp("\n������� 4\n")


function r = f4(x)
  r = 1./sqrt(9+x.^3);
  return;
endfunction

disp("\n����� ��������: ");
v = 2 : 0.001 : 5;
disp(trapz(v, f4(v)));

disp("\n��������: ");
disp(quad(@f4, 2, 5, 0.001));


disp("enter ��� �����������")
pause()
disp("\n������� 5\n")


function r = f5(x)
  r = sin(sqrt(x)) - cos(sqrt(x)) + 2*sqrt(x);
  return;
endfunction

a = 0.0;
b = 0.2;

D = a : 0.01 : b;
plot(D, f5(D));

disp("\n���� ������, ���������� OX => fzero");

disp("\nfzero: "); disp(fzero(@f5, [a b]));
disp("\nfsolve: "); disp(fsolve(@f5, [a b]));


disp("enter ��� �����������")
pause()
disp("\n������� 6\n")


function r = f6(x,y)
  r = (x.^2 - y + 2).^2 + (x - y - 1).^2;
  return;
endfunction

d = 0 : 0.1 : 1;

plot3(d, d, @f6(d, d));

function r = f6_(v)
  r = f6(v(1), v(2));
  return;
endfunction

disp("\n�������: "); disp(fminsearch(@f6_, [1;1]));