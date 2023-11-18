using Random

"""
## `hausdorff_metric`
```julia
    hausdorff_metric(ar1, ar2; seed::Int = 0)
```

Early breaking Hausdorff distance implementation in pure Julia

#### References
A. A. Taha and A. Hanbury, "An efficient algorithm for
calculating the exact Hausdorff distance." IEEE Transactions On
Pattern Analysis And Machine Intelligence, vol. 37 pp. 2153-63,
2015.
"""
function hausdorff_metric(ar1, ar2; seed = 0)
    # Ensure the sizes of input arrays are compatible
    @assert size(ar1) == size(ar2)

    # Find the coordinates of non-zero elements
    coords1 = findall(x -> x == 1, ar1)
    coords2 = findall(x -> x == 1, ar2)

    # Convert CartesianIndex to array of integers
    coords1 = [tuple(c.I...) for c in coords1]
    coords2 = [tuple(c.I...) for c in coords2]

    N1, N2 = length(coords1), length(coords2)
    data_dims = ndims(ar1)

    rng = Random.MersenneTwister(seed)
    coords1 = coords1[Random.shuffle(rng, 1:N1)]
    coords2 = coords2[Random.shuffle(rng, 1:N2)]

    cmax = 0.0
    for i in 1:N1
        cmin = Inf
        local d
        for j in 1:N2
            d = 0.0
            for k in 1:data_dims
                d += (coords1[i][k] - coords2[j][k]) ^ 2
            end
            if d < cmax
                break
            end
            if d < cmin
                cmin = d
            end
        end
        if cmin >= cmax && d >= cmax
            cmax = cmin
        end
    end

    return sqrt(cmax)
end

export hausdorff_metric