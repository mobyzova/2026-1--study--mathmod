t0 = 0;
x0 = 3;
N = 584;
t = 0:0.1:10;

function g = k(t)
    g = 0.93;
endfunction

function v = p(t)
    v = 0.00005;
endfunction

function xd = f(t, x)
    xd = (k(t) + p(t)*x)*(N - x);
endfunction

x = ode(x0, t0, t, f);
plot(t, x);
xlabel('Время t');
ylabel('Число знающих n(t)');
title('Случай 1: α₁ = 0.93, α₂ = 0.00005');
