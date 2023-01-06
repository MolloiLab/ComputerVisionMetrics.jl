### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ b96e693a-0659-4e14-83f4-69481f2b5231
# ╠═╡ show_logs = false
begin
	using Pkg; Pkg.activate("..")
	using ComputerVisionMetrics, PlutoUI, PlutoTest
end

# ╔═╡ 6429671c-6b7d-4649-8285-4ac640523d09
TableOfContents()

# ╔═╡ 528eaa0f-5dd2-41ff-a3ae-57afe999e4ef
md"""
# `get_mask_edges`
"""

# ╔═╡ d3193880-ba3a-425b-a14f-c38c8092e90e
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
	PlutoTest.@test edges_pred == answer
end

# ╔═╡ 0f44c31f-60ca-4a95-9925-949eb28998f6
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
	PlutoTest.@test edges_pred == answer
end

# ╔═╡ c2eebe0c-39d3-4e26-a5b6-af5ff839c1aa
md"""
# `euc`
"""

# ╔═╡ 8b8859e0-472c-4bfe-bd27-03fe901edd3b
let
	A = CartesianIndex(1, 3, 1)
    PlutoTest.@test euc(A, A) == 0
end

# ╔═╡ 303b281b-626b-435a-bde3-e20bcc1b84f3
let
	A = CartesianIndex(1, 3, 1)
	C = CartesianIndex(1, 3, 2)
	PlutoTest.@test euc(A, C) == 1.0
end

# ╔═╡ Cell order:
# ╠═b96e693a-0659-4e14-83f4-69481f2b5231
# ╠═6429671c-6b7d-4649-8285-4ac640523d09
# ╟─528eaa0f-5dd2-41ff-a3ae-57afe999e4ef
# ╠═d3193880-ba3a-425b-a14f-c38c8092e90e
# ╠═0f44c31f-60ca-4a95-9925-949eb28998f6
# ╟─c2eebe0c-39d3-4e26-a5b6-af5ff839c1aa
# ╠═8b8859e0-472c-4bfe-bd27-03fe901edd3b
# ╠═303b281b-626b-435a-bde3-e20bcc1b84f3
