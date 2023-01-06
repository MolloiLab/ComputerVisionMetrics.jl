### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ c6f7a9d0-8d7a-11ed-2267-05d87c7d6f0e
# ╠═╡ show_logs = false
begin
	using Pkg; Pkg.activate(".")
	using Revise, CairoMakie, PlutoUI
	using Statistics: mean
	using StatsBase: percentile
	using ImageMorphology: erode, feature_transform, distance_transform
end

# ╔═╡ 679f80e5-780a-4e04-a39d-dfb649267b4f
# ╠═╡ show_logs = false
# ComputerVisionMetrics = include("../src/ComputerVisionMetrics.jl")

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

# ╔═╡ b8392983-6ed3-4cbc-b845-9415e3c159b7
edges_pred, edges_gt = ComputerVisionMetrics.get_mask_edges(seg_pred, seg_gt)

# ╔═╡ b1b13ec7-b754-4423-b767-754d39c5a0f2
md"""
## Hausdorff
"""

# ╔═╡ 9f5ac009-ba57-4df1-9ec0-134db392f6a4
ComputerVisionMetrics._hausdorff(edges_pred, edges_gt, 40)

# ╔═╡ 8a9cbaec-3232-4d1f-9553-3a15d856b4e3
ComputerVisionMetrics.hausdorff(seg_pred, seg_gt, 40)

# ╔═╡ Cell order:
# ╠═679f80e5-780a-4e04-a39d-dfb649267b4f
# ╠═c6f7a9d0-8d7a-11ed-2267-05d87c7d6f0e
# ╠═e540f358-6f15-4607-bb4a-b6108530f53e
# ╠═6c7141cc-299e-4773-aeb2-afa5c91b2c28
# ╟─232e2097-04cc-41d7-b67a-d56660a9dc22
# ╠═b8392983-6ed3-4cbc-b845-9415e3c159b7
# ╟─b1b13ec7-b754-4423-b767-754d39c5a0f2
# ╠═9f5ac009-ba57-4df1-9ec0-134db392f6a4
# ╠═8a9cbaec-3232-4d1f-9553-3a15d856b4e3
