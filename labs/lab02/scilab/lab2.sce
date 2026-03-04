// Лабораторная работа №2 - Вариант 60
// k = 20.4 км, n = 5.3

clear;
clc;

k = 20.4;           // начальное расстояние
n = 5.3;            // отношение скоростей

// Начальные расстояния
r0_1 = k/(n + 1);   // случай 1
r0_2 = k/(n - 1);   // случай 2


c = sqrt(n^2 - 1);

disp('Вариант 60: k = ' + string(k) + ', n = ' + string(n));
disp('r0_1 = ' + string(r0_1));
disp('r0_2 = ' + string(r0_2));
disp('c = ' + string(c));


function dr = f1(theta, r)
    dr = r/c;
endfunction

r0 = r0_1;
theta0 = 0;
theta = 0:0.01:2*%pi;
r = ode(r0, theta0, theta, f1);

// Лодка под углом 45°
function xt = boat(t)
    xt = tan(%pi/4)*t;
endfunction

t = 0:1:100;

scf(1);
clf();
polarplot(theta, r, style=color('green'));
plot2d(t, boat(t), style=color('red'));
xtitle('Случай 1');
legend(['Катер'; 'Лодка'], 4);

function dr = f2(theta, r)
    dr = r/c;
endfunction

r0 = r0_2;
theta0 = -%pi;
theta = -%pi:0.01:%pi;
r = ode(r0, theta0, theta, f2);

scf(2);
clf();
polarplot(theta, r, style=color('blue'));
plot2d(t, boat(t), style=color('red'));
xtitle('Случай 2');
legend(['Катер'; 'Лодка'], 4);
