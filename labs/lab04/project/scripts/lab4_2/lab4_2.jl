using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots

plot_dir = plotsdir("lab4")
mkpath(plot_dir)

const ω = √(13.0)
const γ = 2.5

f(t) = 0.0

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
     title = "Случай 2: x(t) с затуханием (γ = 2.5)",
     legend = false,
     linewidth = 2)
savefig(joinpath(plot_dir, "lab4_julia_2.png"))

plot(sol, idxs = (1, 2),
     xlabel = "x",
     ylabel = "dx/dt",
     title = "Фазовый портрет с затуханием (случай 2)",
     legend = false,
     linewidth = 1)
savefig(joinpath(plot_dir, "lab4_julia_2_ph.png"))

println("Случай 2 выполнен. Графики сохранены в папку plots/lab4/")
