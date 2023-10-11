### A Pluto.jl notebook ###
# v0.19.26

#> [frontmatter]
#> title = "Advanced Usage"
#> category = "Tutorials"

using Markdown
using InteractiveUtils

# ╔═╡ d0d4cee1-2cfa-4a53-a814-f642339f4c87
# ╠═╡ show_logs = false
begin
	using Pkg
	Pkg.activate(".")

	using ComputerVisionMetrics
end

# ╔═╡ ee835afd-333f-4cf2-86cf-720411bed228
prediction = rand([0, 1], 200, 200, 10);

# ╔═╡ abac9329-6441-4607-ad21-7706dc46c489
ground_truth = rand([0, 1], 200, 200, 10);

# ╔═╡ 5236a9f0-26da-4c8e-851c-1eba8dbf3ae9
hd_metric = hausdorff_metric(prediction, ground_truth)

# ╔═╡ b3fe71f9-591e-48f3-9ca2-4a59d975835a
hd_metric_per = hausdorff_metric(prediction, ground_truth; per = 0.9)

# ╔═╡ Cell order:
# ╠═d0d4cee1-2cfa-4a53-a814-f642339f4c87
# ╠═ee835afd-333f-4cf2-86cf-720411bed228
# ╠═abac9329-6441-4607-ad21-7706dc46c489
# ╠═5236a9f0-26da-4c8e-851c-1eba8dbf3ae9
# ╠═b3fe71f9-591e-48f3-9ca2-4a59d975835a
