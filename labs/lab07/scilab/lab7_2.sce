t0 = 0;
x0 = 3;
N = 584;
t = 0:0.001:0.3;

function g = k(t)
    g = 0.00003;
endfunction

function v = p(t)
    v = 0.7;
endfunction

function xd = f(t, x)
    xd = (k(t) + p(t)*x)*(N - x);
endfunction

x = ode(x0, t0, t, f);

// Нахождение максимальной скорости распространения
dn_dt = zeros(t);
for i = 1:length(t)
    dn_dt(i) = (0.00003 + 0.7*x(i))*(N - x(i));
end

[max_speed, max_index] = max(dn_dt);
max_time = t(max_index);

plot(t, x);
xlabel('Время t');
ylabel('Число знающих n(t)');
title(['Случай 2: α₁ = 0.00003, α₂ = 0.7, max скорость при t = ' + string(max_time)]);

disp('Максимальная скорость распространения рекламы:');
disp('Время t_max = ' + string(max_time));
disp('Значение n(t_max) = ' + string(x(max_index)));
disp('Максимальная скорость dn/dt = ' + string(max_speed));
