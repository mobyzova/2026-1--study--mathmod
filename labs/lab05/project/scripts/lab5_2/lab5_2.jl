using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots

plots_dir = "plots/lab5"
mkpath(plots_dir)

a = 0.43   # коэффициент смертности хищников
b = 0.061  # коэффициент прироста хищников
c = 0.47   # коэффициент прироста жертв
d = 0.059  # коэффициент смертности жертв

x0_stat = c / d  # стационарная численность хищников
y0_stat = a / b  # стационарная численность жертв

println("Стационарное состояние системы:")
println("x0 = $(round(x0_stat, digits=2)) (численность хищников)")
println("y0 = $(round(y0_stat, digits=2)) (численность жертв)")

u0 = [x0_stat; y0_stat]

tspan = (0.0, 100.0)

function predator_prey!(du, u, p, t)
    x, y = u
    du[1] = -a*x + b*x*y  # хищники
    du[2] = c*y - d*x*y    # жертвы
end

prob = ODEProblem(predator_prey!, u0, tspan)
sol = solve(prob, Tsit5(), saveat=0.1)

t = sol.t
x = [u[1] for u in sol.u]
y = [u[2] for u in sol.u]

p1 = plot(t, [x y],
    linewidth=2,
    label=["Хищники" "Жертвы"],
    xlabel="Время t",
    ylabel="Численность",
    title="Стационарное состояние системы",
    color=[:red :green],
    grid=true
)
savefig(p1, joinpath(plots_dir, "stationary_time.png"))

p2 = scatter(x, y,
    markersize=8,
    color=:blue,
    markerstrokecolor=:blue,
    xlabel="Численность хищников (x)",
    ylabel="Численность жертв (y)",
    title="Стационарная точка на фазовой плоскости",
    label="Стационарная точка",
    grid=true
)
savefig(p2, joinpath(plots_dir, "stationary_point.png"))

println("\nГрафики сохранены в директорию: $plots_dir")
println("Файлы:")
println("  - stationary_time.png")
println("  - stationary_point.png")
