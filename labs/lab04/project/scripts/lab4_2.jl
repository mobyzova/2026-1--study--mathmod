# # Случай 2: Колебания с затуханием, без внешней силы
# Уравнение: $\ddot{x} + 2.5\dot{x} + 13x = 0$

using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots

# ## Создание директории для сохранения графиков
plot_dir = plotsdir("lab4")
mkpath(plot_dir)

# ## Параметры системы
# Собственная частота: $\omega_0 = \sqrt{13}$
# Коэффициент затухания: $\gamma = 2.5$
const ω = √(13.0)
const γ = 2.5

# ## Функция внешней силы
# Внешняя сила отсутствует: $f(t) = 0$
f(t) = 0.0

# ## Правая часть системы дифференциальных уравнений
# Система в форме Коши с затуханием:
# \[
# \begin{cases}
# \dot{x} = y \\
# \dot{y} = -\omega_0^2 x - \gamma y
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
     title = "Случай 2: x(t) с затуханием (γ = 2.5)",
     legend = false,
     linewidth = 2)
savefig(joinpath(plot_dir, "lab4_julia_2.png"))

# ### Фазовый портрет $(x, \dot{x})$
plot(sol, idxs = (1, 2),
     xlabel = "x",
     ylabel = "dx/dt",
     title = "Фазовый портрет с затуханием (случай 2)",
     legend = false,
     linewidth = 1)
savefig(joinpath(plot_dir, "lab4_julia_2_ph.png"))

println("Случай 2 выполнен. Графики сохранены в папку plots/lab4/")