t0 = 0;
x0 = 3;
N = 584;
t = 0:0.01:2;

function g = k(t)
    g = 0.7*t;
endfunction

function v = p(t)
    v = 0.8*sin(t);
endfunction

function xd = f(t, x)
    xd = (k(t) + p(t)*x)*(N - x);
endfunction

x = ode(x0, t0, t, f);
plot(t, x);
xlabel('Время t');
ylabel('Число знающих n(t)');
title('Случай 3: α₁(t) = 0.7*t, α₂(t) = 0.8*sin(t)');
