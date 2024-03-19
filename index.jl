### A Pluto.jl notebook ###
# v0.19.40

#> [frontmatter]
#> title = "Home"

using Markdown
using InteractiveUtils

# ╔═╡ 90f47371-c6a1-499c-812e-42fd84217781
# ╠═╡ show_logs = false
begin
	using Pkg
	Pkg.activate(joinpath(pwd(), "docs"))
	Pkg.instantiate()

	using HTMLStrings: to_html, head, link, script, divv, h1, img, p, span, a, figure, hr, select, option, label, h2, li, ul
	using PlutoUI
end

# ╔═╡ b9c530bf-d81f-44d2-a607-55dd5b83890c
md"""
## Tutorials
"""

# ╔═╡ 2bdcaa42-25e3-4012-acc0-f066d68e5dc6
md"""
## References
"""

# ╔═╡ e81b2642-0442-42c3-a5ef-7ec312aa3181
to_html(hr())

# ╔═╡ 3cf724dd-8103-430e-a3eb-2b2f25db1324
TableOfContents()

# ╔═╡ 476678f2-4af0-45fa-8993-2372607d11f2
data_theme = "dracula";

# ╔═╡ e532258c-7652-455e-97b0-2ce4ce1eaeb5
function index_title_card(title::String, subtitle::String, image_url::String; data_theme::String = "pastel", border_color::String = "primary")
	return to_html(
	    divv(
	        head(
				link(:href => "https://cdn.jsdelivr.net/npm/daisyui@3.7.4/dist/full.css", :rel => "stylesheet", :type => "text/css"),
	            script(:src => "https://cdn.tailwindcss.com")
	        ),
			divv(:data_theme => "$data_theme", :class => "card card-bordered flex justify-center items-center border-$border_color text-center w-full dark:text-[#e6e6e6]",
				divv(:class => "card-body flex flex-col justify-center items-center",
					img(:src => "$image_url", :class => "h-24 w-24 md:h-40 md:w-40 rounded-md", :alt => "$title Logo"),
					divv(:class => "text-3xl md:text-5xl font-bold bg-gradient-to-r from-accent to-primary inline-block text-transparent bg-clip-text py-10", "$title"),
					p(:class => "card-text text-md font-serif", "$subtitle"
					)
				)
			)
	    )
	)
end;

# ╔═╡ 64ad0e5b-cd12-4c4b-ad27-b65d1d7938e1
index_title_card(
	"ComputerVisionMetrics.jl",
	"Common Metrics for Evaluating Segmentation Tasks",
	"https://img.freepik.com/free-photo/colorful-bar-graph-sits-table-with-dark-background_1340-34474.jpg";
	data_theme = data_theme
)

# ╔═╡ 9f5dedbb-92ee-4099-ab47-24eb4954392c
begin
	struct Article
		title::String
		path::String
		image_url::String
	end
	
	article_list_tutorials = Article[
		Article("Getting Started", "docs/01_getting_started.jl", "https://img.freepik.com/free-photo/futuristic-spaceship-takes-off-into-purple-galaxy-fueled-by-innovation-generated-by-ai_24640-100023.jpg"),
	];
	article_list_api = Article[
		Article("API", "docs/99_api.jl", "https://img.freepik.com/free-photo/modern-technology-workshop-creativity-innovation-communication-development-generated-by-ai_188544-24548.jpg"),
	];

	function article_card(article::Article, color::String; data_theme = "pastel")
		a(:href => article.path, :class => "w-full md:w-1/2 p-2",
			divv(:data_theme => "$data_theme", :class => "card card-bordered border-$color text-center dark:text-[#e6e6e6]",
				divv(:class => "card-body justify-center items-center h-32 md:h-40",
					p(:class => "text-lg md:text-2xl", article.title),
					p(:class => "text-sm md:text-base", "Click to open the notebook")
				),
				figure(
					img(:class => "w-full h-40 md:h-48 object-cover", :src => article.image_url, :alt => article.title)
				)
			)
		)
	end
end;

# ╔═╡ 89394b04-55aa-4d68-a8e7-500a4e15a343
to_html(
    divv(:class => "flex flex-wrap justify-center items-start",
        [article_card(article, "accent"; data_theme = data_theme) for article in article_list_tutorials]...
    )
)

# ╔═╡ 61a70dd2-eeae-40d9-97dc-206f1100c251
to_html(
    divv(:class => "flex flex-wrap justify-center items-start",
        [article_card(article, "secondary"; data_theme = data_theme) for article in article_list_api]...
    )
)

# ╔═╡ Cell order:
# ╟─64ad0e5b-cd12-4c4b-ad27-b65d1d7938e1
# ╟─b9c530bf-d81f-44d2-a607-55dd5b83890c
# ╟─89394b04-55aa-4d68-a8e7-500a4e15a343
# ╟─2bdcaa42-25e3-4012-acc0-f066d68e5dc6
# ╟─61a70dd2-eeae-40d9-97dc-206f1100c251
# ╠═e81b2642-0442-42c3-a5ef-7ec312aa3181
# ╠═90f47371-c6a1-499c-812e-42fd84217781
# ╠═3cf724dd-8103-430e-a3eb-2b2f25db1324
# ╠═476678f2-4af0-45fa-8993-2372607d11f2
# ╠═e532258c-7652-455e-97b0-2ce4ce1eaeb5
# ╠═9f5dedbb-92ee-4099-ab47-24eb4954392c
