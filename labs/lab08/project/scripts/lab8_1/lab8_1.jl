using DrWatson
@quickactivate "project"
using DifferentialEquations
using Plots

p_cr = 41      # критическая стоимость продукта
τ₁ = 21        # длительность производственного цикла фирмы 1
p₁ = 7.8       # себестоимость продукта у фирмы 1
τ₂ = 18        # длительность производственного цикла фирмы 2
p₂ = 9.5       # себестоимость продукта у фирмы 2
N = 45         # число потребителей
q = 1          # максимальная потребность одного человека

a₁ = p_cr / (τ₁^2 * p₁^2 * N * q)
a₂ = p_cr / (τ₂^2 * p₂^2 * N * q)
b = p_cr / (τ₁^2 * p₁^2 * τ₂^2 * p₂^2 * N * q)
c₁ = (p_cr - p₁) / (τ₁ * p₁)
c₂ = (p_cr - p₂) / (τ₂ * p₂)

function system!(du, u, p, t)
    M₁, M₂ = u
    du[1] = (c₁/c₁)*M₁ - (a₁/c₁)*M₁^2 - (b/c₁)*M₁*M₂
    du[2] = (c₂/c₁)*M₂ - (a₂/c₁)*M₂^2 - (b/c₁)*M₁*M₂
end

u₀ = [7.4, 8.5]          # начальные оборотные средства
tspan = (0.0, 40.0)      # интервал времени
prob = ODEProblem(system!, u₀, tspan)

sol = solve(prob, Tsit5(), saveat=0.1)

gr(size=(800, 600), dpi=300)
plot(sol,
     xlabel="Безразмерное время θ = t/c₁",
     ylabel="Оборотные средства M₁, M₂ (млн. ед.)",
     title="Случай 1: Конкуренция только рыночными методами",
     label=["Фирма 1" "Фирма 2"],
     linewidth=2,
     legend=:topright,
     grid=true)

mkpath("plots/lab8")
savefig("plots/lab8/lab8_julia_case1.png")

println("Коэффициенты для случая 1:")
println("a₁ = ", a₁)
println("a₂ = ", a₂)
println("b = ", b)
println("c₁ = ", c₁)
println("c₂ = ", c₂)
println("\nФинальные значения оборотных средств:")
println("M₁(40) = ", sol[end][1])
println("M₂(40) = ", sol[end][2])
