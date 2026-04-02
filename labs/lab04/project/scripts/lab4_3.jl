# # Случай 3: Колебания с затуханием и внешней силой
# Уравнение: $\ddot{x} + 7\dot{x} + 6.6x = 0.3\sin(12t)$

using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots

# ## Создание директории для сохранения графиков
plot_dir = plotsdir("lab4")
mkpath(plot_dir)

# ## Параметры системы
# Собственная частота: $\omega_0 = \sqrt{6.6}$
# Коэффициент затухания: $\gamma = 7$
const ω = √(6.6)
const γ = 7.0

# ## Функция внешней силы
# Гармоническая внешняя сила: $f(t) = 0.3\sin(12t)$
f(t) = 0.3 * sin(12 * t)

# ## Правая часть системы дифференциальных уравнений
# Система в форме Коши с затуханием и внешней силой:
# \[
# \begin{cases}
# \dot{x} = y \\
# \dot{y} = -\omega_0^2 x - \gamma y + 0.3\sin(12t)
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
     title = "Случай 3: x(t) с затуханием и внешней силой",
     legend = false,
     linewidth = 2)
savefig(joinpath(plot_dir, "lab4_julia_3.png"))

# ### Фазовый портрет $(x, \dot{x})$
plot(sol, idxs = (1, 2),
     xlabel = "x",
     ylabel = "dx/dt",
     title = "Фазовый портрет с внешней силой (случай 3)",
     legend = false,
     linewidth = 1)
savefig(joinpath(plot_dir, "lab4_julia_3_phase.png"))

println("Случай 3 выполнен. Графики сохранены в папку plots/lab4/")