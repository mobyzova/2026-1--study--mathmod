using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots

plot_dir = plotsdir("lab4")
mkpath(plot_dir)

const ω = √(6.6)
const γ = 7.0

f(t) = 0.3 * sin(12 * t)

function oscillator!(du, u, p, t)
    du[1] = u[2]
    du[2] = -ω^2 * u[1] - γ * u[2] + f(t)
end

u0 = [1.5, 0.0]
tspan = (0.0, 73.0)

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
