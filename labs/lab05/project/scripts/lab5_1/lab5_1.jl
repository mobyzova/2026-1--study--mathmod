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

x0 = 8.0   # начальная численность хищников
y0 = 24.0  # начальная численность жертв
u0 = [x0; y0]

tspan = (0.0, 400.0)

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

p1 = plot(x, y,
    linewidth=2,
    color=:blue,
    xlabel="Численность хищников (x)",
    ylabel="Численность жертв (y)",
    title="Фазовый портрет системы",
    legend=false,
    grid=true
)
savefig(p1, joinpath(plots_dir, "phase_portrait.png"))

p2 = plot(t, x,
    linewidth=2,
    color=:red,
    xlabel="Время t",
    ylabel="Численность хищников x(t)",
    title="Динамика численности хищников",
    legend=false,
    grid=true
)
savefig(p2, joinpath(plots_dir, "predators_time.png"))

p3 = plot(t, y,
    linewidth=2,
    color=:green,
    xlabel="Время t",
    ylabel="Численность жертв y(t)",
    title="Динамика численности жертв",
    legend=false,
    grid=true
)
savefig(p3, joinpath(plots_dir, "prey_time.png"))

p4 = plot(t, [x y],
    linewidth=2,
    label=["Хищники" "Жертвы"],
    xlabel="Время t",
    ylabel="Численность",
    title="Динамика популяций",
    color=[:red :green],
    grid=true
)
savefig(p4, joinpath(plots_dir, "both_species.png"))

println("Графики сохранены в директорию: $plots_dir")
println("Файлы:")
println("  - phase_portrait.png")
println("  - predators_time.png")
println("  - prey_time.png")
println("  - both_species.png")
