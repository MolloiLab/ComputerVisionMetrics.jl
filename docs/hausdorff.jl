### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ c6f7a9d0-8d7a-11ed-2267-05d87c7d6f0e
# ╠═╡ show_logs = false
begin
    using Pkg
    Pkg.activate(".")
    using Revise, CairoMakie, PlutoUI
    using Statistics: mean
    using StatsBase: percentile
    using ImageMorphology: erode, feature_transform, distance_transform
end

# ╔═╡ e540f358-6f15-4607-bb4a-b6108530f53e
TableOfContents()

# ╔═╡ 6c7141cc-299e-4773-aeb2-afa5c91b2c28
begin
    seg_pred = [
        0 0 0 0 0
        0 1 1 1 0
        0 1 1 1 0
        0 1 1 1 0
        0 1 1 1 0
        0 0 0 0 0
    ]
    seg_pred = cat(seg_pred, seg_pred, dims=3)
    seg_gt = copy(seg_pred)
end

# ╔═╡ 232e2097-04cc-41d7-b67a-d56660a9dc22
md"""
## Get mask edges
"""

# ╔═╡ c826373d-1c7b-4c7c-bec3-9972181da89f
"""
```julia
get_mask_edges(seg_pred::AbstractMatrix, seg_gt::AbstractMatrix)
```

See [Monai](https://github.com/Project-MONAI/MONAI/blob/dev/monai/metrics/utils.py#L106)
"""
function get_mask_edges(seg_pred::AbstractMatrix, seg_gt::AbstractMatrix, points=true)

    # Do binary erosion and use XOR to get edges
    edges_pred = erode(seg_pred) .⊻ seg_pred
    edges_gt = erode(seg_gt) .⊻ seg_gt

    if points
        return findall(x -> x == 1, edges_pred), findall(x -> x == 1, edges_gt)
    else
        edges_pred, edges_gt
    end
end

# ╔═╡ 5c5c07f3-f189-4204-a732-c4c0163b4269
"""
```julia
get_mask_edges(seg_pred::AbstractArray, seg_gt::AbstractArray)
```

See [Monai](https://github.com/Project-MONAI/MONAI/blob/dev/monai/metrics/utils.py#L106)
"""
function get_mask_edges(seg_pred::AbstractArray, seg_gt::AbstractArray, points=true)

    edges_pred, edges_gt = zeros(size(seg_pred)), zeros(size(seg_gt))
    for z in axes(seg_pred, 3)
        # Do binary erosion and use XOR to get edges
        edges_pred[:, :, z] = erode(seg_pred[:, :, z]) .⊻ seg_pred[:, :, z]
        edges_gt[:, :, z] = erode(seg_gt[:, :, z]) .⊻ seg_gt[:, :, z]
    end

    if points
        return findall(x -> x == 1, edges_pred), findall(x -> x == 1, edges_gt)
    else
        edges_pred, edges_gt
    end
end

# ╔═╡ b8392983-6ed3-4cbc-b845-9415e3c159b7
edges_pred, edges_gt = get_mask_edges(seg_pred, seg_gt)

# ╔═╡ b1b13ec7-b754-4423-b767-754d39c5a0f2
md"""
## Hausdorff
"""

# ╔═╡ 75148910-3f69-4ecf-b8e0-73a5b656f954
function euc(u::CartesianIndex{2}, v::CartesianIndex{2})
    return √((u[1] - v[1])^2 + (u[2] - v[2])^2)
end

# ╔═╡ 3ba6b20c-5e4e-41f6-ba8d-d6ae715fcf07
function euc(u::CartesianIndex{3}, v::CartesianIndex{3})
    return √((u[1] - v[1])^2 + (u[2] - v[2])^2 + (u[3] - v[3])^2)
end

# ╔═╡ aebdca54-b863-4bd5-9fb6-137bd7266040
"""
```julia
_hausdorff(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, directed=false) where N
```
```julia
_hausdorff(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, p, directed=false) where N
```

Given two sets of points, `set1` & `set2`, compute the Hausdorff distance between the two sets. By default, the returned Hausdorff is the max Hausdorff and is two-sided. If given a parameter `p`, return a tuple for each set's percentile. To choose a one-sided Hausdorff, change `directed=true`

# Arguments
- set1: set of points in 2D or 3D space
- set2: set of points in 2D or 3D space
- p: percentile to be computed based on `StatsBase.percentile`
"""
function _hausdorff(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, directed::Bool=false) where {N}
    min_euc_list_u = []
    min_euc_list_v = []

    # Loop through every point in `set1` and 
    # find its corresponding closest point to `set2`
    for points1 in set1
        euc_list_1 = []
        for points2 in set2
            euclidean_dist = euc(points1, points2)
            append!(euc_list_1, euclidean_dist)
        end
        append!(min_euc_list_u, minimum(euc_list_1))
    end

    if !directed
        # Loop through every point in `set2` and 
        # find its corresponding closest point to `set1`
        for points1 in set2
            euc_list_1 = []
            for points2 in set1
                euclidean_dist = euc(points1, points2)
                append!(euc_list_1, euclidean_dist)
            end
            append!(min_euc_list_v, minimum(euc_list_1))
        end
        # Take the mean of each of these points 
        # to return the mean Hausdorff distance 
        return max(min_euc_list_u, min_euc_list_v)
    else
        return max(min_euc_list_u)
    end
end

# ╔═╡ 946087c4-1460-4085-8d9c-76cdee57ae76
function _hausdorff(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, p, directed::Bool=false) where {N}
    min_euc_list_u = []
    min_euc_list_v = []

    # Loop through every point in `set1` and 
    # find its corresponding closest point to `set2`
    for points1 in set1
        euc_list_1 = []
        for points2 in set2
            euclidean_dist = euc(points1, points2)
            append!(euc_list_1, euclidean_dist)
        end
        append!(min_euc_list_u, minimum(euc_list_1))
    end

    if !directed
        # Loop through every point in `set2` and 
        # find its corresponding closest point to `set1`
        for points1 in set2
            euc_list_1 = []
            for points2 in set1
                euclidean_dist = euc(points1, points2)
                append!(euc_list_1, euclidean_dist)
            end
            append!(min_euc_list_v, minimum(euc_list_1))
        end

        return max(percentile(min_euc_list_u, p), percentile(min_euc_list_v, p))
    else
        return percentile(min_euc_list_u, p)
    end
end

# ╔═╡ 2e7a42bf-0396-45d1-97fa-88895ca5c65c
"""
```julia
hausdorff(seg_pred::AbstractArray, seg_gt::AbstractArray, directed=false)
```
```julia
hausdorff(seg_pred::AbstractArray, seg_gt::AbstractArray, p, directed=false)
```

Given two arrays, `seg_pred` & `seg_gt`, compute the Hausdorff distance. By default, the returned Hausdorff is the max Hausdorff and is two-sided. If given a parameter `p`, return a tuple for each set's percentile. To choose a one-sided Hausdorff, change `directed=true`

# Arguments
- `seg_pred`: predicted mask. 2D or 3D array of `::Bool` or `::Int`
- `seg_gt`: ground_truth mask. 2D or 3D array of `::Bool` or `::Int`
- `p`: percentile to be computed based on `StatsBase.percentile`
"""
function hausdorff(seg_pred::AbstractArray, seg_gt::AbstractArray, directed::Bool=false)
    edges_pred, edges_gt = get_mask_edges(seg_pred, seg_gt)
    return _hausdorff(edges_pred, edges_gt)
end

# ╔═╡ 2b04b7be-7cd4-43e4-a795-04a8f3d8c3b8
function hausdorff(seg_pred::AbstractArray, seg_gt::AbstractArray, p, directed::Bool=false)
    edges_pred, edges_gt = get_mask_edges(seg_pred, seg_gt)
    return _hausdorff(edges_pred, edges_gt, p)
end

# ╔═╡ 9f5ac009-ba57-4df1-9ec0-134db392f6a4
_hausdorff(edges_pred, edges_gt, 40)

# ╔═╡ 8a9cbaec-3232-4d1f-9553-3a15d856b4e3
hausdorff(seg_pred, seg_gt, 40)

# ╔═╡ Cell order:
# ╠═c6f7a9d0-8d7a-11ed-2267-05d87c7d6f0e
# ╠═e540f358-6f15-4607-bb4a-b6108530f53e
# ╠═6c7141cc-299e-4773-aeb2-afa5c91b2c28
# ╟─232e2097-04cc-41d7-b67a-d56660a9dc22
# ╠═c826373d-1c7b-4c7c-bec3-9972181da89f
# ╠═5c5c07f3-f189-4204-a732-c4c0163b4269
# ╠═b8392983-6ed3-4cbc-b845-9415e3c159b7
# ╟─b1b13ec7-b754-4423-b767-754d39c5a0f2
# ╠═75148910-3f69-4ecf-b8e0-73a5b656f954
# ╠═3ba6b20c-5e4e-41f6-ba8d-d6ae715fcf07
# ╠═aebdca54-b863-4bd5-9fb6-137bd7266040
# ╠═946087c4-1460-4085-8d9c-76cdee57ae76
# ╠═2e7a42bf-0396-45d1-97fa-88895ca5c65c
# ╠═2b04b7be-7cd4-43e4-a795-04a8f3d8c3b8
# ╠═9f5ac009-ba57-4df1-9ec0-134db392f6a4
# ╠═8a9cbaec-3232-4d1f-9553-3a15d856b4e3
