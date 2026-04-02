# # Случай 1: Колебания без затухания и без внешней силы
# Уравнение: $\ddot{x} + 1.3x = 0$

using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots

# ## Создание директории для сохранения графиков
plot_dir = plotsdir("lab4")
mkpath(plot_dir)

# ## Параметры системы
# Собственная частота: $\omega_0 = \sqrt{1.3}$
const ω = √(1.3)
const γ = 0.0

# ## Функция внешней силы
# В данном случае внешняя сила отсутствует: $f(t) = 0$
f(t) = 0.0

# ## Правая часть системы дифференциальных уравнений
# Система в форме Коши:
# \[
# \begin{cases}
# \dot{x} = y \\
# \dot{y} = -\omega_0^2 x - \gamma y + f(t)
# \end{cases}
# \]
function oscillator!(du, u, p, t)
    du[1] = u[2]
    du[2] = -ω^2 * u[1] - γ * u[2] + f(t)
end

# ## Начальные условия
# $x_0 = 1.5$, $\dot{x}_0 = 0$
u0 = [1.5, 0.0]
tspan = (0.0, 73.0)

# ## Решение системы ОДУ
prob = ODEProblem(oscillator!, u0, tspan)
sol = solve(prob, Tsit5(), saveat = 0.05)

# ## Построение графиков
# ### График решения $x(t)$
plot(sol, idxs = 1, 
     xlabel = "Время t", 
     ylabel = "Смещение x",
     title = "Случай 1: x(t) без затухания (ω = √1.3)",
     legend = false,
     linewidth = 2)
savefig(joinpath(plot_dir, "lab4_julia_1.png"))

# ### Фазовый портрет $(x, \dot{x})$
plot(sol, idxs = (1, 2),
     xlabel = "x",
     ylabel = "dx/dt",
     title = "Фазовый портрет (случай 1)",
     legend = false,
     linewidth = 1)
savefig(joinpath(plot_dir, "lab4_julia_1_ph.png"))

println("Случай 1 выполнен. Графики сохранены в папку plots/lab4/")