using Primes
using Test

distinctSum = r -> begin
    squarefree = n -> !any(p -> n % p^2 == 0, Primes.primes(1, ceil(Integer, sqrt(n))))
    triangle = map(n -> map(k -> binomial(n, k), range(0, n)), range(0, r))
    sqf = filter(squarefree, unique(Iterators.flatten(Iterators.take(triangle, r))))
    sum(sqf)
end

@test distinctSum(8) == 105
@test distinctSum(50) == 34029210557338