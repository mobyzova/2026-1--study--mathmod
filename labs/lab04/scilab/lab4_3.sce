// Случай 3: x'' + 15x' + 5x = 0.8 cos(12t)
w = sqrt(5);
g = 15;

function f = f(t)
    f = 0.8 * cos(12 * t);
endfunction

function dx = rhs(t, x)
    dx(1) = x(2);
    dx(2) = -w^2 * x(1) - g * x(2) + f(t);
endfunction

t0 = 0;
x0 = [0; -0.6];
t = 0:0.05:77;

x = ode(x0, t0, t, rhs);

scf(5);
plot(t, x(1,:));
xlabel('t');
ylabel('x');
title('Случай 3: x(t) с затуханием и внешней силой');

scf(6);
plot(x(1,:), x(2,:));
xlabel('x');
ylabel('x''');
title('Фазовый портрет (случай 3)');
