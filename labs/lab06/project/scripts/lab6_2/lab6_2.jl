using Plots
using DifferentialEquations

N = 16548

I0 = 208   # инфицированные особи
R0 = 48    # особи с иммунитетом
S0 = N - I0 - R0  # восприимчивые, но здоровые особи

alpha = 0.01  # коэффициент заболеваемости
beta = 0.02   # коэффициент выздоровления

function ode_fn_case2(du, u, p, t)
    S, I, R = u
    du[1] = -alpha * S          # dS/dt
    du[2] = alpha * S - beta * I # dI/dt
    du[3] = beta * I             # dR/dt
end

v0 = [S0, I0, R0]

tspan = (0.0, 200.0)

prob = ODEProblem(ode_fn_case2, v0, tspan)
sol = solve(prob, dtmax = 0.1)

S = [u[1] for u in sol.u]
I = [u[2] for u in sol.u]
R = [u[3] for u in sol.u]
T = [t for t in sol.t]

plt = plot(
    dpi = 300,
    legend = :topright,
    title = "Модель эпидемии: случай I(0) > I*",
    xlabel = "Время t",
    ylabel = "Численность особей",
    linewidth = 2
)

plot!(
    plt,
    T,
    S,
    label = "Восприимчивые особи S(t)",
    color = :blue
)

plot!(
    plt,
    T,
    I,
    label = "Инфицированные особи I(t)",
    color = :green
)

plot!(
    plt,
    T,
    R,
    label = "Особи с иммунитетом R(t)",
    color = :red
)

mkpath("plots/lab6")
savefig(plt, "plots/lab6/lab6_case2.png")

println("=== Модель эпидемии. Случай 2: I(0) > I* ===")
println("Начальные условия:")
println("  S(0) = ", S0)
println("  I(0) = ", I0)
println("  R(0) = ", R0)
println("Коэффициенты:")
println("  α = ", alpha)
println("  β = ", beta)
println("\nФинальные значения при t = 200:")
println("  S(200) = ", round(S[end], digits=2))
println("  I(200) = ", round(I[end], digits=2))
println("  R(200) = ", round(R[end], digits=2))
println("\nГрафик сохранен в файл: plots/lab6/lab6_case2.png")
