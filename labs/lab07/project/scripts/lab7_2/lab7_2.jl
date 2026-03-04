using DrWatson
@quickactivate "project"

using DifferentialEquations
using Plots

const N = 584      # общий объём аудитории
const n0 = 3.0      # начальное количество знающих
const α₁ = 0.00003  # коэффициент платной рекламы
const α₂ = 0.7      # коэффициент сарафанного радио

function advertising!(du, u, p, t)
    n = u[1]
    du[1] = (α₁ + α₂ * n) * (N - n)
end

u0 = [n0]
tspan = (0.0, 0.3)  # меньший интервал из-за быстрого роста

prob = ODEProblem(advertising!, u0, tspan)
sol = solve(prob, Tsit5(), saveat = 0.001)

n_values = [u[1] for u in sol.u]
t_values = [t for t in sol.t]

dn_dt = zeros(length(t_values))
for i in eachindex(t_values)
    dn_dt[i] = (α₁ + α₂ * n_values[i]) * (N - n_values[i])
end

max_speed, max_idx = findmax(dn_dt)
max_time = t_values[max_idx]
max_n = n_values[max_idx]

plt = plot(
    dpi = 300,
    title = "Модель распространения рекламы (случай 2)",
    xlabel = "Время t",
    ylabel = "Число знающих n(t)",
    legend = false,
    size = (800, 600)
)

plot!(plt, t_values, n_values, linewidth = 2, color = :red, label = "n(t)")

scatter!(plt, [max_time], [max_n],
    color = :red,
    markersize = 8,
    markerstrokewidth = 2,
    label = "max скорость")

mkpath(plotsdir("lab7"))
savefig(plt, plotsdir("lab7", "case2_α₁=0.00003_α₂=0.7.png"))

plt_speed = plot(
    dpi = 300,
    title = "Скорость распространения рекламы (случай 2)",
    xlabel = "Время t",
    ylabel = "Скорость dn/dt",
    size = (800, 600)
)
plot!(plt_speed, t_values, dn_dt, linewidth = 2, color = :green)
scatter!(plt_speed, [max_time], [max_speed],
    color = :green,
    markersize = 8,
    label = "max скорость = $(round(max_speed, digits=2))")
savefig(plt_speed, plotsdir("lab7", "case2_speed.png"))

println("\n" * "="^60)
println("РЕЗУЛЬТАТЫ МОДЕЛИРОВАНИЯ (СЛУЧАЙ 2)")
println("="^60)
println("Параметры модели:")
println("  N = $N")
println("  n₀ = $n0")
println("  α₁ = $α₁")
println("  α₂ = $α₂")
println("\n" * "="^40)
println("МАКСИМАЛЬНАЯ СКОРОСТЬ РАСПРОСТРАНЕНИЯ")
println("="^40)
println("  Время t_max = $(round(max_time, digits=4))")
println("  Значение n(t_max) = $(round(max_n, digits=2))")
println("  Максимальная скорость dn/dt = $(round(max_speed, digits=2))")
println("\nСохранённые файлы:")
println("  График n(t): $(plotsdir("lab7", "case2_α₁=0.00003_α₂=0.7.png"))")
println("  График скорости: $(plotsdir("lab7", "case2_speed.png"))")
println("="^60)
