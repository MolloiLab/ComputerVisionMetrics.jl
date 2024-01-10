### A Pluto.jl notebook ###
# v0.19.36

#> [frontmatter]
#> title = "Getting Started"

using Markdown
using InteractiveUtils

# ╔═╡ e44dced4-338b-405a-92a4-4bbf2ae5d45b
# ╠═╡ show_logs = false
using Pkg; Pkg.activate("."); Pkg.instantiate()

# ╔═╡ 526a7728-cd2a-4df4-a88e-cc389db00a3e
using ComputerVisionMetrics: dice_metric, hausdorff_metric

# ╔═╡ 6822f0bf-f953-40e9-8969-289fc841c882
prediction = rand([0, 1], 10, 10, 10);

# ╔═╡ 5d56ab65-fab5-47d5-8452-4330ee589241
ground_truth = rand([0, 1], 10, 10, 10);

# ╔═╡ 53f96607-6f10-41a7-9ae4-2397924ce41d
dsc_metric = dice_metric(prediction, ground_truth)

# ╔═╡ 063e9158-50d8-41fc-a2f2-311b40caa376
hd_metric = hausdorff_metric(prediction, ground_truth)

# ╔═╡ Cell order:
# ╠═e44dced4-338b-405a-92a4-4bbf2ae5d45b
# ╠═526a7728-cd2a-4df4-a88e-cc389db00a3e
# ╠═6822f0bf-f953-40e9-8969-289fc841c882
# ╠═5d56ab65-fab5-47d5-8452-4330ee589241
# ╠═53f96607-6f10-41a7-9ae4-2397924ce41d
# ╠═063e9158-50d8-41fc-a2f2-311b40caa376
