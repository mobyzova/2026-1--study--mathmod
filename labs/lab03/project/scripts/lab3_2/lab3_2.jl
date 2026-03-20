using DifferentialEquations, Plots, DataFrames

plot_dir = "plots/lab3"
mkpath(plot_dir)

x0 = 57570.0  # регулярная армия X
y0 = 91210.0  # партизаны Y
a, b, c, h = 0.365, 0.77, 0.61, 0.452
tspan = (0.0, 1.0)

P(t) = abs(sin(2t))
Q(t) = abs(cos(2t))

function system!(du, u, p, t)
    x, y = u
    du[1] = -a*x - b*y + P(t)
    du[2] = -c*x*y - h*y + Q(t)
end

prob = ODEProblem(system!, [x0; y0], tspan)
sol = solve(prob, Tsit5(), saveat=0.05)

df = DataFrame(t=sol.t, x=[u[1] for u in sol.u], y=[u[2] for u in sol.u])
println("\nМОДЕЛЬ №2 (регулярные войска и партизаны)")
println("Начальные условия: X0 = $x0, Y0 = $y0")
println("\nПервые 5 строк:")
println(first(df, 5))

final_x, final_y = last(sol.u)[1], last(sol.u)[2]
println("\nРезультаты при t = 1.0:")
println("Регулярная армия X = $(round(final_x, digits=2))")
println("Партизаны Y = $(round(final_y, digits=2))")
println("Победитель: ", final_x > final_y ? "Регулярная армия X" :
                        final_y > final_x ? "Партизаны Y" : "Ничья")

plt1 = plot(sol,
    label=["Регулярная армия X" "Партизаны Y"],
    xlabel="Время", ylabel="Численность",
    title="Модель №2: Регулярные войска и партизаны",
    linewidth=2, legend=:top)
savefig(joinpath(plot_dir, "model2_partisan_war.png"))

plt2 = plot(sol.t, [u[1] for u in sol.u],
    label="Регулярная армия X", xlabel="Время", ylabel="Численность",
    title="Динамика регулярной армии X", linewidth=2, color=:blue)
savefig(joinpath(plot_dir, "model2_army_X.png"))

plt3 = plot(sol.t, [u[2] for u in sol.u],
    label="Партизаны Y", xlabel="Время", ylabel="Численность",
    title="Динамика партизанских отрядов Y", linewidth=2, color=:red)
savefig(joinpath(plot_dir, "model2_army_Y.png"))

plt4 = plot([u[1] for u in sol.u], [u[2] for u in sol.u],
    label="Фазовая траектория",
    xlabel="Численность армии X", ylabel="Численность армии Y",
    title="Фазовая траектория",
    linewidth=2, color=:green)
savefig(joinpath(plot_dir, "model2_phase_trajectory.png"))

println("\nГрафики сохранены в: $plot_dir")
println("Сохранены файлы:")
println("  - model2_partisan_war.png")
println("  - model2_army_X.png")
println("  - model2_army_Y.png")
println("  - model2_phase_trajectory.png")
display(plt1)
