### A Pluto.jl notebook ###
# v0.19.18

using Markdown
using InteractiveUtils

# ╔═╡ e9b2b958-6455-4069-9ce5-14cc90495ff6
# ╠═╡ show_logs = false
begin
	using Pkg; Pkg.activate("..")
	using ComputerVisionMetrics, PlutoUI, PlutoTest
end

# ╔═╡ fb907954-e9cc-4928-8172-688130f15509
TableOfContents()

# ╔═╡ 2b7f4ea8-5446-47cd-8173-45fd2ee0098f
md"""
# `dice`
"""

# ╔═╡ ac31ccdc-a00c-4f96-9949-c0a45a014f3a
let
	x = [0 0 0 1; 0 0 0 1; 0 0 0 1; 0 0 0 1]
	y = [1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0]
	PlutoTest.@test dice(x, y) == 0
end

# ╔═╡ 112b7dc8-a811-473c-aac8-932c3735175c
let
	x = [1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0]
	PlutoTest.@test dice(x, x) == 1
end

# ╔═╡ Cell order:
# ╠═e9b2b958-6455-4069-9ce5-14cc90495ff6
# ╠═fb907954-e9cc-4928-8172-688130f15509
# ╟─2b7f4ea8-5446-47cd-8173-45fd2ee0098f
# ╠═ac31ccdc-a00c-4f96-9949-c0a45a014f3a
# ╠═112b7dc8-a811-473c-aac8-932c3735175c
