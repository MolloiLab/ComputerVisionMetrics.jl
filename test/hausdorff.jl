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

# ╔═╡ e8abc2e9-9cc0-409d-8412-baf88bccd78e
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
	PlutoTest.@test ComputerVisionMetrics._hausdorff(edges_pred, edges_gt) == 0
end

# ╔═╡ 13bd5d8b-cbb9-46ab-adc3-2fea2905ca0b
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

# ╔═╡ e86c21c0-48c8-4768-b4cf-0279dcb8d61a
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
	PlutoTest.@test ComputerVisionMetrics._hausdorff(edges_pred, edges_gt) == 0
end

# ╔═╡ addca125-99af-46ad-ae11-55dcfec898dd
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

# ╔═╡ 6ae03a2e-7bdc-4c86-b182-35eb9724fae4
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
	PlutoTest.@test hausdorff(seg_pred, seg_gt) == 0
end

# ╔═╡ ff8bd60d-62ae-44ce-af88-56fbf466d1a2
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

# ╔═╡ 9b8d518e-34f0-4134-85cb-3616b4148bce
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
	PlutoTest.@test hausdorff(seg_pred, seg_gt) == 0
end

# ╔═╡ 25c4aa9a-8a40-4ebc-a14d-56f27b5f3718
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
# ╠═e8abc2e9-9cc0-409d-8412-baf88bccd78e
# ╠═13bd5d8b-cbb9-46ab-adc3-2fea2905ca0b
# ╠═e86c21c0-48c8-4768-b4cf-0279dcb8d61a
# ╠═addca125-99af-46ad-ae11-55dcfec898dd
# ╟─3f4c791e-1d43-4d42-89bf-7693face792a
# ╠═6ae03a2e-7bdc-4c86-b182-35eb9724fae4
# ╠═ff8bd60d-62ae-44ce-af88-56fbf466d1a2
# ╠═9b8d518e-34f0-4134-85cb-3616b4148bce
# ╠═25c4aa9a-8a40-4ebc-a14d-56f27b5f3718
