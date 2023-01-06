### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ 1c9d396e-8d86-11ed-3eb3-41958693a27b
# ╠═╡ show_logs = false
begin
	using Pkg; Pkg.activate("..")
	using PlutoUI, PlutoTest
	using Statistics: mean
	using StatsBase: percentile
	using ImageMorphology: erode, feature_transform, distance_transform
end

# ╔═╡ 2159f007-7bda-482d-85e7-69d97ab92811
TableOfContents()

# ╔═╡ 388373db-1cb4-4e03-9bbb-24032593b59a
md"""
# `get_mask_edges`
"""

# ╔═╡ c722f492-7a26-4217-bf6f-2c88581bf594
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

# ╔═╡ c7e9927c-8ce2-47ea-a851-1b4fc53b5b26
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

# ╔═╡ a03cce12-2a68-4683-bab8-d9c7a42190f7
md"""
## Tests
"""

# ╔═╡ 7880e999-fac9-42cc-971a-ce2c4dd041b5
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
	edges_pred, _ = get_mask_edges(seg_pred, seg_gt)
	answer = [
		CartesianIndex(2, 2)
		CartesianIndex(3, 2)
		CartesianIndex(4, 2)
		CartesianIndex(5, 2)
		CartesianIndex(2, 3)
		CartesianIndex(5, 3)
		CartesianIndex(2, 4)
		CartesianIndex(3, 4)
		CartesianIndex(4, 4)
		CartesianIndex(5, 4)
	]
	@test edges_pred == answer
end

# ╔═╡ cc913e38-d41b-40d6-a080-456bdf5610c1
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
	edges_pred, _ = get_mask_edges(seg_pred, seg_gt)
	answer = [
		CartesianIndex(2, 2, 1)
		CartesianIndex(3, 2, 1)
		CartesianIndex(4, 2, 1)
		CartesianIndex(5, 2, 1)
		CartesianIndex(2, 3, 1)
		CartesianIndex(5, 3, 1)
		CartesianIndex(2, 4, 1)
		CartesianIndex(3, 4, 1)
		CartesianIndex(4, 4, 1)
		CartesianIndex(5, 4, 1)
		CartesianIndex(2, 2, 2)
		CartesianIndex(3, 2, 2)
		CartesianIndex(4, 2, 2)
		CartesianIndex(5, 2, 2)
		CartesianIndex(2, 3, 2)
		CartesianIndex(5, 3, 2)
		CartesianIndex(2, 4, 2)
		CartesianIndex(3, 4, 2)
		CartesianIndex(4, 4, 2)
		CartesianIndex(5, 4, 2)
	]
	@test edges_pred == answer
end

# ╔═╡ 01a15f04-2eee-493e-a04d-0ed49d8723b0
md"""
# `euc`
"""

# ╔═╡ 9d1d02ed-5755-41d4-9ad4-64352bab54de
function euc(u::CartesianIndex{2}, v::CartesianIndex{2})
    return √((u[1] - v[1])^2 + (u[2] - v[2])^2)
end

# ╔═╡ da95367e-a530-48c0-91a7-c4922d7b4175
function euc(u::CartesianIndex{3}, v::CartesianIndex{3})
    return √((u[1] - v[1])^2 + (u[2] - v[2])^2 + (u[3] - v[3])^2)
end

# ╔═╡ 675436b8-1729-4243-bbf8-6e55df5cdcb8
md"""
## Tests
"""

# ╔═╡ a2352a34-3c48-4f23-ac78-5b9f08630318
let
	A = CartesianIndex(1, 3, 1)
    @test euc(A, A) == 0
end

# ╔═╡ bd511e55-3842-4f2d-8063-ea17955a7ad5
let
	A = CartesianIndex(1, 3, 1)
	C = CartesianIndex(1, 3, 2)
	@test euc(A, C) == 1.0
end

# ╔═╡ Cell order:
# ╠═1c9d396e-8d86-11ed-3eb3-41958693a27b
# ╠═2159f007-7bda-482d-85e7-69d97ab92811
# ╟─388373db-1cb4-4e03-9bbb-24032593b59a
# ╠═c722f492-7a26-4217-bf6f-2c88581bf594
# ╠═c7e9927c-8ce2-47ea-a851-1b4fc53b5b26
# ╟─a03cce12-2a68-4683-bab8-d9c7a42190f7
# ╠═7880e999-fac9-42cc-971a-ce2c4dd041b5
# ╠═cc913e38-d41b-40d6-a080-456bdf5610c1
# ╟─01a15f04-2eee-493e-a04d-0ed49d8723b0
# ╠═9d1d02ed-5755-41d4-9ad4-64352bab54de
# ╠═da95367e-a530-48c0-91a7-c4922d7b4175
# ╟─675436b8-1729-4243-bbf8-6e55df5cdcb8
# ╠═a2352a34-3c48-4f23-ac78-5b9f08630318
# ╠═bd511e55-3842-4f2d-8063-ea17955a7ad5
