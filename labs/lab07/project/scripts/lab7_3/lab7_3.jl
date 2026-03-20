using DrWatson
@quickactivate "project"

using DifferentialEquations
using Plots

const N = 584      # общий объём аудитории
const n0 = 3.0      # начальное количество знающих

function advertising!(du, u, p, t)
    n = u[1]
    α₁_t = 0.7 * t
    α₂_t = 0.8 * sin(t)
    du[1] = (α₁_t + α₂_t * n) * (N - n)
end

u0 = [n0]
tspan = (0.0, 2.0)  # интервал для наблюдения осцилляций

prob = ODEProblem(advertising!, u0, tspan)
sol = solve(prob, Tsit5(), saveat = 0.01)

n_values = [u[1] for u in sol.u]
t_values = [t for t in sol.t]

α₁_values = 0.7 .* t_values
α₂_values = 0.8 .* sin.(t_values)

plt1 = plot(
    dpi = 300,
    title = "Модель распространения рекламы (случай 3)",
    xlabel = "Время t",
    ylabel = "Число знающих n(t)",
    size = (800, 600)
)
plot!(plt1, t_values, n_values, linewidth = 2, color = :purple, label = "n(t)")

mkpath(plotsdir("lab7"))
savefig(plt1, plotsdir("lab7", "case3_n(t).png"))

plt2 = plot(
    dpi = 300,
    title = "Зависимость коэффициентов от времени",
    xlabel = "Время t",
    ylabel = "Значение коэффициентов",
    size = (800, 600)
)
plot!(plt2, t_values, α₁_values, linewidth = 2, color = :blue, label = "α₁(t) = 0.7t")
plot!(plt2, t_values, α₂_values, linewidth = 2, color = :red, label = "α₂(t) = 0.8·sin(t)")
savefig(plt2, plotsdir("lab7", "case3_coefficients.png"))

println("\n" * "="^60)
println("РЕЗУЛЬТАТЫ МОДЕЛИРОВАНИЯ (СЛУЧАЙ 3)")
println("="^60)
println("Параметры модели:")
println("  N = $N")
println("  n₀ = $n0")
println("  α₁(t) = 0.7t")
println("  α₂(t) = 0.8·sin(t)")
println("\nРезультаты:")
println("  Конечное значение n(2.0) = $(round(n_values[end], digits=2))")
println("  Минимальное значение n(t) = $(round(minimum(n_values), digits=2))")
println("  Максимальное значение n(t) = $(round(maximum(n_values), digits=2))")
println("\nСохранённые файлы:")
println("  График n(t): $(plotsdir("lab7", "case3_n(t).png"))")
println("  График коэффициентов: $(plotsdir("lab7", "case3_coefficients.png"))")
println("="^60)
