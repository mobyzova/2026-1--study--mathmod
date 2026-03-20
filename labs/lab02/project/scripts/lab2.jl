# # Лабораторная работа №1 - Задача преследования на море
#
# **Вариант 60**
# * Начальное расстояние: $k = 20.4$ км
# * Отношение скоростей: $n = 5.3$ (катер в 5.3 раза быстрее лодки)

# ## 1. Подключение библиотек

using Plots
using DifferentialEquations

# ## 2. Исходные данные

const k = 20.4      # начальное расстояние между катером и лодкой, км
const n = 5.3       # отношение скоростей (Vкатера / Vлодки)

# ## 3. Начальные расстояния для двух случаев
#
# **Случай 1:** Катер движется **к** полюсу (лодка и катер по одну сторону)
# $$ r_0^{(1)} = \frac{k}{n+1} $$
#
# **Случай 2:** Катер движется **от** полюса (лодка и катер по разные стороны)
# $$ r_0^{(2)} = \frac{k}{n-1} $$

const r0_1 = k / (n + 1)
const r0_2 = k / (n - 1)

# ## 4. Уравнение траектории катера
#
# После выхода на нужный радиус катер движется по спирали:
# $$ \frac{dr}{d\theta} = \frac{r}{\sqrt{n^2-1}} $$

function F(u, p, t)
    return u / sqrt(n*n - 1)
end

# ## 5. Интервалы интегрирования
#
# * Случай 1: $\theta \in [0, 2\pi]$
# * Случай 2: $\theta \in [-\pi, \pi]$

const T_1 = (0, 2*pi)
const T_2 = (-pi, pi)

# Создаем папку для графиков plots/lab2
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

# ## 6. Решение для случая 1 (к полюсу)

println("\nСлучай 1 (к полюсу): решение...")

problem1 = ODEProblem(F, r0_1, T_1)
result1 = solve(problem1, abstol=1e-8, reltol=1e-8)

# Угол для пути лодки (для визуализации)
boat_angle = result1.t[1]

# Построение графика в полярных координатах
plt1 = plot(proj=:polar, aspect_ratio=:equal, dpi=1000, legend=true, bg=:white)
plot!(plt1, xlabel="θ", ylabel="r(θ)", title="Случай 1: катер движется к полюсу", legend=:outerbottom)

# Путь лодки (луч от полюса)
plot!(plt1, [boat_angle, boat_angle], [0.0, result1.u[end]], 
      label="Путь лодки", color=:blue, lw=2)

# Путь катера (спираль)
plot!(plt1, result1.t, result1.u, 
      label="Путь катера", color=:green, lw=2)

# Сохраняем в plots/lab2/
file1 = joinpath(plots_dir, "lab2_case1.png")
savefig(plt1, file1)
println("  График сохранен: $file1")

# ## 7. Решение для случая 2 (от полюса)

println("\nСлучай 2 (от полюса): решение...")

problem2 = ODEProblem(F, r0_2, T_2)
result2 = solve(problem2, abstol=1e-8, reltol=1e-8)

# Угол для пути лодки
boat_angle2 = result2.t[div(end, 2)]

# Построение графика
plt2 = plot(proj=:polar, aspect_ratio=:equal, dpi=1000, legend=true, bg=:white)
plot!(plt2, xlabel="θ", ylabel="r(θ)", title="Случай 2: катер движется от полюса", legend=:outerbottom)

# Путь лодки (луч от полюса)
plot!(plt2, [boat_angle2, boat_angle2], [0.0, result2.u[end]], 
      label="Путь лодки", color=:blue, lw=2)

# Путь катера (спираль)
plot!(plt2, result2.t, result2.u, 
      label="Путь катера", color=:green, lw=2)

# Сохраняем в plots/lab2/
file2 = joinpath(plots_dir, "lab2_case2.png")
savefig(plt2, file2)
println("  График сохранен: $file2")

# ## 8. Точка пересечения траекторий
#
# Для примера возьмем угол лодки $\phi = 45^\circ$:
# $$ r_{пересечения} = r_0^{(1)} \cdot e^{\frac{\phi}{\sqrt{n^2-1}}} $$

println("\n--- Точка пересечения (для примера) ---")
φ = π/4  # 45 градусов в радианах
r_intercept = r0_1 * exp(φ / sqrt(n*n - 1))
println("Для лодки под углом φ = 45°:")
println("  Радиус точки встречи: r = $(round(r_intercept, digits=2)) км")
println("  Координаты: x = $(round(r_intercept*cos(φ), digits=2)) км, y = $(round(r_intercept*sin(φ), digits=2)) км")

println("\n=== Готово! ===")
println("Графики сохранены в папку: $(abspath(plots_dir))")