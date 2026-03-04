// Случай 2: x'' + 12x' + 25x = 0
w = sqrt(25);
g = 12;

function f = f(t)
    f = 0;
endfunction

function dx = rhs(t, x)
    dx(1) = x(2);
    dx(2) = -w^2 * x(1) - g * x(2) + f(t);
endfunction

t0 = 0;
x0 = [0; -0.6];
t = 0:0.05:77;

x = ode(x0, t0, t, rhs);

scf(3);
plot(t, x(1,:));
xlabel('t');
ylabel('x');
title('Случай 2: x(t) с затуханием');

scf(4);
plot(x(1,:), x(2,:));
xlabel('x');
ylabel('x''');
title('Фазовый портрет (случай 2)');
