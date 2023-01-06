### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ faaba666-8d8e-11ed-3e44-751ee5717d03
# ╠═╡ show_logs = false
begin
	using Pkg; Pkg.activate("..")
	using PlutoUI, PlutoTest
end

# ╔═╡ aa3c3579-ac9d-43bd-90d8-af8ea1cfd803
TableOfContents()

# ╔═╡ 1c0490ba-523d-41f6-b19b-396061ada375
md"""
# `dice`
"""

# ╔═╡ ef3a04bd-30ba-4b04-9761-da42f330a3e0
function dice(seg_pred, seg_gt)
	return 2 * sum((seg_pred .& seg_gt)) / (sum(seg_pred) + sum(seg_gt))
end

# ╔═╡ 1519d285-e475-461f-9070-01b144e1c66c
export dice

# ╔═╡ a34a372b-1656-4230-9971-ef15a28ed56c
md"""
## Tests
"""

# ╔═╡ d6a43a7f-6945-41b6-8e97-c08ef5172fd7
let
	x = [0 0 0 1; 0 0 0 1; 0 0 0 1; 0 0 0 1]
	y = [1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0]
	PlutoTest.@test dice(x, y) == 0
end

# ╔═╡ 3aff6891-1ee5-49de-98e6-28020085469e
let
	x = [1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0]
	PlutoTest.@test dice(x, x) == 1
end

# ╔═╡ Cell order:
# ╠═faaba666-8d8e-11ed-3e44-751ee5717d03
# ╠═aa3c3579-ac9d-43bd-90d8-af8ea1cfd803
# ╟─1c0490ba-523d-41f6-b19b-396061ada375
# ╠═ef3a04bd-30ba-4b04-9761-da42f330a3e0
# ╠═1519d285-e475-461f-9070-01b144e1c66c
# ╟─a34a372b-1656-4230-9971-ef15a28ed56c
# ╠═d6a43a7f-6945-41b6-8e97-c08ef5172fd7
# ╠═3aff6891-1ee5-49de-98e6-28020085469e
