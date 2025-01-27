# Test standard form transformation
r = mdopen("shaw", 100, false)
A, x = r.A, r.x
rn = CSV.read("random_numbers.csv", DataFrame)
y = A * x
b = y + 0.1y .* rn.x
x₀ = 0.6x

λ = 2.0
n,m = size(A)

L = Γ(m, 0)
Ψ = setupRegularizationProblem(A, L)
b̄, x̄₀ = to_standard_form(Ψ, b, x₀)
sol1 = @>> solve(Ψ, b̄, x̄₀, λ) to_general_form(Ψ, b) 
sol2 = inv(A'A + λ^2.0 * L'L) * (A' * b + λ^2.0 * L'L*x₀)
@test sol1 ≈ sol2

L = Γ(m, 1)
Ψ = setupRegularizationProblem(A, L)
b̄, x̄₀ = to_standard_form(Ψ, b, x₀)
sol1 = @>> solve(Ψ, b̄, x̄₀, λ) to_general_form(Ψ, b) 
sol2 = inv(A'A + λ^2.0 * L'L) * (A' * b + λ^2.0 * L'L*x₀)
@test sol1 ≈ sol2

L = Γ(m, 2)
Ψ = setupRegularizationProblem(A, L)
b̄, x̄₀ = to_standard_form(Ψ, b, x₀)
sol1 = @>> solve(Ψ, b̄, x̄₀, λ) to_general_form(Ψ, b) 
sol2 = inv(A'A + λ^2.0 * L'L) * (A' * b + λ^2.0 * L'L*x₀)
@test sol1 ≈ sol2

# Test reduced size L matrix
L = Γ(m, 2)
p, n = size(L)
L = L[1:n-2, :]
p, n = size(L)
Ψ = setupRegularizationProblem(A, L)
b̄, x̄₀ = to_standard_form(Ψ, b, x₀)
sol1 = @>> solve(Ψ, b̄, x̄₀, λ) to_general_form(Ψ, b) 
sol2 = inv(A'A + λ^2.0 * L'L) * (A' * b + λ^2.0 * L'L*x₀)
@test sol1[1:p] ≈ sol2[1:p]


L = Γ(m, 0)
r = mdopen("shaw", 100, false)
A, x = r.A, r.x

L = CSV.read("random_matrix.csv", DataFrame) |> Matrix
Ψ = setupRegularizationProblem(A, L)
b̄ = to_standard_form(Ψ, b)
sol1 = @>> solve(Ψ, b̄, λ) to_general_form(Ψ, b) 
sol2 = inv(A'A + λ^2.0 * L'L) * A' * b 
@test sol1 ≈ sol2

L = Γ(m, 1)
Ψ = setupRegularizationProblem(A, L)
b̄ = to_standard_form(Ψ, b)
sol1 = @>> solve(Ψ, b̄, λ) to_general_form(Ψ, b) 
sol2 = inv(A'A + λ^2.0 * L'L) * A' * b 
@test sol1 ≈ sol2

L = Γ(m, 2)
Ψ = setupRegularizationProblem(A, L)
b̄ = to_standard_form(Ψ, b)
sol1 = @>> solve(Ψ, b̄, λ) to_general_form(Ψ, b) 
sol2 = inv(A'A + λ^2.0 * L'L) * A' * b 
@test sol1 ≈ sol2
