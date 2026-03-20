using Plots
using DifferentialEquations

const k = 20.4      # начальное расстояние между катером и лодкой, км
const n = 5.3       # отношение скоростей (Vкатера / Vлодки)

const r0_1 = k / (n + 1)
const r0_2 = k / (n - 1)

function F(u, p, t)
    return u / sqrt(n*n - 1)
end

const T_1 = (0, 2*pi)
const T_2 = (-pi, pi)

plots_dir = joinpath("plots", "lab2")
if !isdir(plots_dir)
    mkpath(plots_dir)
end

println("=== Лабораторная работа №2 (Вариант 60) ===")
println("k = $k км, n = $n")
println("r0_1 = $(round(r0_1, digits=3)) км")
println("r0_2 = $(round(r0_2, digits=3)) км")
println("√(n²-1) = $(round(sqrt(n*n-1), digits=3))")
println("----------------------------------------")
println("Графики будут сохранены в: $plots_dir")

println("\nСлучай 1 (к полюсу): решение...")

problem1 = ODEProblem(F, r0_1, T_1)
result1 = solve(problem1, abstol=1e-8, reltol=1e-8)

boat_angle = result1.t[1]

plt1 = plot(proj=:polar, aspect_ratio=:equal, dpi=1000, legend=true, bg=:white)
plot!(plt1, xlabel="θ", ylabel="r(θ)", title="Случай 1: катер движется к полюсу", legend=:outerbottom)

plot!(plt1, [boat_angle, boat_angle], [0.0, result1.u[end]],
      label="Путь лодки", color=:blue, lw=2)

plot!(plt1, result1.t, result1.u,
      label="Путь катера", color=:green, lw=2)

file1 = joinpath(plots_dir, "lab2_case1.png")
savefig(plt1, file1)
println("  График сохранен: $file1")

println("\nСлучай 2 (от полюса): решение...")

problem2 = ODEProblem(F, r0_2, T_2)
result2 = solve(problem2, abstol=1e-8, reltol=1e-8)

boat_angle2 = result2.t[div(end, 2)]

plt2 = plot(proj=:polar, aspect_ratio=:equal, dpi=1000, legend=true, bg=:white)
plot!(plt2, xlabel="θ", ylabel="r(θ)", title="Случай 2: катер движется от полюса", legend=:outerbottom)

plot!(plt2, [boat_angle2, boat_angle2], [0.0, result2.u[end]],
      label="Путь лодки", color=:blue, lw=2)

plot!(plt2, result2.t, result2.u,
      label="Путь катера", color=:green, lw=2)

file2 = joinpath(plots_dir, "lab2_case2.png")
savefig(plt2, file2)
println("  График сохранен: $file2")

println("\n--- Точка пересечения (для примера) ---")
φ = π/4  # 45 градусов в радианах
r_intercept = r0_1 * exp(φ / sqrt(n*n - 1))
println("Для лодки под углом φ = 45°:")
println("  Радиус точки встречи: r = $(round(r_intercept, digits=2)) км")
println("  Координаты: x = $(round(r_intercept*cos(φ), digits=2)) км, y = $(round(r_intercept*sin(φ), digits=2)) км")

println("\n=== Готово! ===")
println("Графики сохранены в папку: $(abspath(plots_dir))")
