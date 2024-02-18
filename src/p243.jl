using Primes
using Test

const EPSILON = 0.000000001

resilience = d -> count(map(n -> gcd(n, d) == 1, range(1, d)))
resilienceFactor = d -> resilience(d) / (d - 1)

candidates = collect(map(i -> reduce(*, Iterators.take(Primes.primes(1, 1000000), i)), range(1, 12)))
lowerBound = (candidates, goal) -> begin
    index = findfirst(d -> resilienceFactor(d) - goal < EPSILON, candidates)
    candidates[index]
end

smallestDenominator = goal -> begin
    min = lowerBound(candidates, goal)
    possibilities = map(i -> min * i, range(2, 32))
    smallest = findfirst(d -> resilienceFactor(d) - goal < 0, possibilities)
    possibilities[smallest]
end

@test smallestDenominator(4 / 10) == 12
@test smallestDenominator(15499 / 94744) == 892371480