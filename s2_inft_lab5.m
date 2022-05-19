disp("\nЗадание 1\n")

function r = f1(x)
  if (x > 3.5)
    r = sin(x).*log10(x);
  else
    r = cos(x).^2;
  endif
endfunction

xs = 2 : 1 : 5;

disp("   X          F(X)");
disp(transpose([xs; f1(xs)]));


disp("enter для продолжения")
#pause()
disp("\nЗадание 2\n")

function [r, count] = f2(tol, i=1)
  r = (-1)^i * (pi/6)^(2*i) / factorial(2*i);
  count = i;
  
  if (abs(r) < tol)
    return;
  endif
  
  [fr, fcount] = f2(tol, i+1);
  r = r + fr;
  count = fcount;
endfunction

[sum_, count] = f2(10^-4);
disp("\nСумма: "); disp(sum_);
disp("\nКол-во членов: "); disp(count);

disp("enter для продолжения")
#pause()
disp("\nЗадание 3\n")

_min = 10
_max = 99

M = floor(rand(50)(1, :).*(_max-_min+1).+_min);
disp("матрица: "); disp(M);

sum_ = 0;
for i = 1 : 50
  if mod(M(i),3) == 0
    sum_ = sum_ + M(i);
  endif
endfor
disp(sum_);

disp("enter для продолжения")
#pause()
disp("\nЗадание 4\n")

x = [17 18 19 20 21 22 23];
y = [0.56 0.63 0.58 0.49 0.63 0.55 0.59];

d = 0;
min_dif = 0.0001;

while true
  P = polyfit(x,y,d);
  py = polyval(P, x);
  
  if sum( abs(y.-py) ) < min_dif
    break;
  endif
  
  d = d + 1 ; 
endwhile

plot (x, y, 'ro', x, py, 'r:')
disp(P);
disp(roots(P));
