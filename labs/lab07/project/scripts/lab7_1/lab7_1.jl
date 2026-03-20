using DrWatson
@quickactivate "project"

using DifferentialEquations
using Plots

const N = 584      # общий объём аудитории
const n0 = 3.0      # начальное количество знающих
const α₁ = 0.93     # коэффициент платной рекламы
const α₂ = 0.00005  # коэффициент сарафанного радио

function advertising!(du, u, p, t)
    n = u[1]
    du[1] = (α₁ + α₂ * n) * (N - n)
end

u0 = [n0]
tspan = (0.0, 10.0)

prob = ODEProblem(advertising!, u0, tspan)
sol = solve(prob, Tsit5(), saveat = 0.1)

n_values = [u[1] for u in sol.u]
t_values = [t for t in sol.t]

plt = plot(
    dpi = 300,
    title = "Модель распространения рекламы (случай 1)",
    xlabel = "Время t",
    ylabel = "Число знающих n(t)",
    legend = false,
    size = (800, 600)
)
plot!(plt, t_values, n_values, linewidth = 2, color = :blue)

mkpath(plotsdir("lab7"))
savefig(plt, plotsdir("lab7", "case1_α₁=0.93_α₂=0.00005.png"))

println("\n" * "="^60)
println("РЕЗУЛЬТАТЫ МОДЕЛИРОВАНИЯ (СЛУЧАЙ 1)")
println("="^60)
println("Параметры модели:")
println("  N = $N")
println("  n₀ = $n0")
println("  α₁ = $α₁")
println("  α₂ = $α₂")
println("\nРезультаты:")
println("  Конечное значение n(10.0) = $(round(n_values[end], digits=2))")
println("  График сохранён: $(plotsdir("lab7", "case1_α₁=0.93_α₂=0.00005.png"))")
println("="^60)
