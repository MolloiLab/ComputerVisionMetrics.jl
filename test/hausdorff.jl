### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ 820f0661-58bf-4aab-bc71-4cd542fdc759
# ╠═╡ show_logs = false
begin
	using Pkg; Pkg.activate("..")
	using ComputerVisionMetrics, PlutoUI, PlutoTest
end

# ╔═╡ 9236f770-6f90-4195-9631-1e03ac1bd91e
TableOfContents()

# ╔═╡ f654408b-4cb3-42af-bc1a-d7c3640714d0
md"""
# `_hausdorff`
"""

# ╔═╡ f242492b-4dd0-492b-a802-92d3330dec1a
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
	PlutoTest.@test ComputerVisionMetrics._hausdorff(edges_pred, edges_gt, 40) == 0
end

# ╔═╡ cd853166-5b1c-4f88-a578-e1c93877ee23
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
	PlutoTest.@test ComputerVisionMetrics._hausdorff(edges_pred, edges_gt, 40) == 0
end

# ╔═╡ 3f4c791e-1d43-4d42-89bf-7693face792a
md"""
# `hausdorff`
"""

# ╔═╡ f55aadcb-7dc9-458e-8291-1e5de2a3ae7b
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

# ╔═╡ 254b16f5-f4f0-4793-a7e8-53ce189da879
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
# ╠═820f0661-58bf-4aab-bc71-4cd542fdc759
# ╠═9236f770-6f90-4195-9631-1e03ac1bd91e
# ╟─f654408b-4cb3-42af-bc1a-d7c3640714d0
# ╠═f242492b-4dd0-492b-a802-92d3330dec1a
# ╠═cd853166-5b1c-4f88-a578-e1c93877ee23
# ╟─3f4c791e-1d43-4d42-89bf-7693face792a
# ╠═f55aadcb-7dc9-458e-8291-1e5de2a3ae7b
# ╠═254b16f5-f4f0-4793-a7e8-53ce189da879
