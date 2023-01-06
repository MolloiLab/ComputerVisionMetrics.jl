### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ fc7c5b98-8d77-11ed-0865-453a051b9dae
# ╠═╡ show_logs = false
begin
	using Pkg; Pkg.activate("..")
	using ComputerVisionMetrics, PlutoUI, PlutoTest
	using StatsBase: percentile
end

# ╔═╡ 94dc6b34-27cc-4af6-bac2-7ac273262d9f
TableOfContents()

# ╔═╡ 2848969d-28d5-451d-8fcf-9d917ea857b8
md"""
# `_hausdorff`
"""

# ╔═╡ c2b20bc1-9164-455e-8f06-97296524ad34
"""
```julia
_hausdorff(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, directed=false) where N
```
```julia
_hausdorff(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, p, directed=false) where N
```

Given two sets of points, `set1` & `set2`, compute the Hausdorff distance between the two sets. By default, the returned Hausdorff is the max Hausdorff and is two-sided. If given a parameter `p`, return a tuple for each set's percentile. To choose a one-sided Hausdorff, change `directed=true`

#### Arguments
- `set1`: set of points in 2D or 3D space
- `set2`: set of points in 2D or 3D space
- `p`: percentile to be computed based on `StatsBase.percentile`
"""
function _hausdorff(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, directed::Bool=false) where N
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

# ╔═╡ 2bf857bb-952e-4c9b-bf4d-2194dd151cdf
function _hausdorff(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, p, directed::Bool=false) where N
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

# ╔═╡ 079dc65c-fe10-4f5c-9ed4-ecacd9151207
md"""
## Tests
"""

# ╔═╡ ee8df24d-85e7-4327-af6c-ebd2c746dfda
let
	seg_pred = [
		0 0 0 0 0
	    0 1 1 1 0
	    0 1 1 1 0
	    0 1 1 1 0
	    0 1 1 1 0
		0 0 0 0 0
	]
	seg_gt = copy(seg_pred)
	edges_pred, edges_gt = get_mask_edges(seg_pred, seg_gt)
	PlutoTest.@test _hausdorff(edges_pred, edges_gt, 40) == 0
end

# ╔═╡ efcfc548-e507-4f67-9a92-f0965b3358b4
let
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
	edges_pred, edges_gt = get_mask_edges(seg_pred, seg_gt)
	PlutoTest.@test _hausdorff(edges_pred, edges_gt, 40) == 0
end

# ╔═╡ 891cb402-ec4b-46de-bb9b-724112f496a9
md"""
# `hausdorff`
"""

# ╔═╡ 63364395-b6ab-4f91-8f15-f5312d96c3bc
"""
```julia
hausdorff(seg_pred::AbstractArray, seg_gt::AbstractArray, directed=false)
```
```julia
hausdorff(seg_pred::AbstractArray, seg_gt::AbstractArray, p, directed=false)
```

Given two arrays, `seg_pred` & `seg_gt`, compute the Hausdorff distance. By default, the returned Hausdorff is the max Hausdorff and is two-sided. If given a parameter `p`, return a tuple for each set's percentile. To choose a one-sided Hausdorff, change `directed=true`

#### Arguments
- `seg_pred`: predicted mask. 2D or 3D array of `::Bool` or `::Int`
- `seg_gt`: ground_truth mask. 2D or 3D array of `::Bool` or `::Int`
- `p`: percentile to be computed based on `StatsBase.percentile`
"""
function hausdorff(seg_pred::AbstractArray, seg_gt::AbstractArray, directed::Bool=false)
	edges_pred, edges_gt = get_mask_edges(seg_pred, seg_gt)
	return _hausdorff(edges_pred, edges_gt)
end

# ╔═╡ 17131b9d-f27d-4292-af65-65d7c2715cd4
function hausdorff(seg_pred::AbstractArray, seg_gt::AbstractArray, p, directed::Bool=false)
	edges_pred, edges_gt = get_mask_edges(seg_pred, seg_gt)
	return _hausdorff(edges_pred, edges_gt, p)
end

# ╔═╡ f29d35ea-d71c-49c4-84d5-41301e1f1046
export hausdorff

# ╔═╡ 094a8181-789e-46e4-a064-dff7e2e6ac00
md"""
## Tests
"""

# ╔═╡ 9a86ac8d-db53-476b-a8cf-2dd53b394bcd
let
	seg_pred = [
		0 0 0 0 0
	    0 1 1 1 0
	    0 1 1 1 0
	    0 1 1 1 0
	    0 1 1 1 0
		0 0 0 0 0
	]
	seg_gt = copy(seg_pred)
	PlutoTest.@test hausdorff(seg_pred, seg_gt, 40) == 0
end

# ╔═╡ 0bef36bd-2c38-4bca-95be-d8b14130ca87
let
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
	PlutoTest.@test hausdorff(seg_pred, seg_gt, 40) == 0
end

# ╔═╡ Cell order:
# ╠═fc7c5b98-8d77-11ed-0865-453a051b9dae
# ╠═94dc6b34-27cc-4af6-bac2-7ac273262d9f
# ╟─2848969d-28d5-451d-8fcf-9d917ea857b8
# ╠═c2b20bc1-9164-455e-8f06-97296524ad34
# ╠═2bf857bb-952e-4c9b-bf4d-2194dd151cdf
# ╟─079dc65c-fe10-4f5c-9ed4-ecacd9151207
# ╠═ee8df24d-85e7-4327-af6c-ebd2c746dfda
# ╠═efcfc548-e507-4f67-9a92-f0965b3358b4
# ╟─891cb402-ec4b-46de-bb9b-724112f496a9
# ╠═63364395-b6ab-4f91-8f15-f5312d96c3bc
# ╠═17131b9d-f27d-4292-af65-65d7c2715cd4
# ╠═f29d35ea-d71c-49c4-84d5-41301e1f1046
# ╟─094a8181-789e-46e4-a064-dff7e2e6ac00
# ╠═9a86ac8d-db53-476b-a8cf-2dd53b394bcd
# ╠═0bef36bd-2c38-4bca-95be-d8b14130ca87
