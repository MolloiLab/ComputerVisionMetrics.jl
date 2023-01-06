### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ fc7c5b98-8d77-11ed-0865-453a051b9dae
# ╠═╡ show_logs = false
begin
	using Pkg; Pkg.activate("..")
	using PlutoUI
	using Statistics: mean
	using StatsBase: percentile
	using ImageMorphology: erode, feature_transform, distance_transform
end

# ╔═╡ 94dc6b34-27cc-4af6-bac2-7ac273262d9f
TableOfContents()

# ╔═╡ Cell order:
# ╠═fc7c5b98-8d77-11ed-0865-453a051b9dae
# ╠═94dc6b34-27cc-4af6-bac2-7ac273262d9f
