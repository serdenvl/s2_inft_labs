disp("\nЗадание 1\n")

M = [ 1 0 0 0 0 0; 
      0 2 0 0 0 0; 
      0 0 3 0 0 0;
      0 0 0 3 0 0;
      0 0 0 0 2 0;
      0 0 0 0 0 1;
    ]
    
disp("\nопределитель: "); disp(det(M));

disp("\nобратная: "); disp(inv(M));


disp("enter для продолжения")
clear()
pause()
disp("\nЗадание 2\n")


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


disp("enter для продолжения")
pause()
disp("\nЗадание 3\n")


function r = f3(x,y)
  r = cos(y).+x.*y;
  return;  
endfunction

[x y] = meshgrid(0:1, 0:1);
mesh(x, y, f3(x,y));

[x y] = ode45(@f3, [0 1], [0.2]);
disp("Решение Коши (ode45): "); disp([x y]);

disp("enter для продолжения")
pause()
disp("\nЗадание 4\n")


function r = f4(x)
  r = 1./sqrt(9+x.^3);
  return;
endfunction

disp("\nМетод трапеций: ");
v = 2 : 0.001 : 5;
disp(trapz(v, f4(v)));

disp("\nСимпсона: ");
disp(quad(@f4, 2, 5, 0.001));


disp("enter для продолжения")
pause()
disp("\nЗадание 5\n")


function r = f5(x)
  r = sin(sqrt(x)) - cos(sqrt(x)) + 2*sqrt(x);
  return;
endfunction

a = 0.0;
b = 0.2;

D = a : 0.01 : b;
plot(D, f5(D));

disp("\nОдин корень, пересекает OX => fzero");

disp("\nfzero: "); disp(fzero(@f5, [a b]));
disp("\nfsolve: "); disp(fsolve(@f5, [a b]));


disp("enter для продолжения")
pause()
disp("\nЗадание 6\n")


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

disp("\nМинимум: "); disp(fminsearch(@f6_, [1;1]));