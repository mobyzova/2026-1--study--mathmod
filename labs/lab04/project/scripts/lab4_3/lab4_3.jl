using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots

plot_dir = plotsdir("lab4")
mkpath(plot_dir)

const ω = √(5.0)
const γ = 15.0

f(t) = 0.8 * cos(12 * t)

function oscillator!(du, u, p, t)
    du[1] = u[2]
    du[2] = -ω^2 * u[1] - γ * u[2] + f(t)
end

u0 = [0.0, -0.6]
tspan = (0.0, 77.0)

prob = ODEProblem(oscillator!, u0, tspan)
sol = solve(prob, Tsit5(), saveat = 0.05)

plot(sol, idxs = 1,
     xlabel = "Время t",
     ylabel = "Смещение x",
     title = "Случай 3: x(t) с затуханием и внешней силой",
     legend = false,
     linewidth = 2)
savefig(joinpath(plot_dir, "lab4_julia_3.png"))

plot(sol, idxs = (1, 2),
     xlabel = "x",
     ylabel = "dx/dt",
     title = "Фазовый портрет с внешней силой (случай 3)",
     legend = false,
     linewidth = 1)
savefig(joinpath(plot_dir, "lab4_julia_3_phase.png"))

println("Случай 3 выполнен. Графики сохранены в папку plots/lab4/")
