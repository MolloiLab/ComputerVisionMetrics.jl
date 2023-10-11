### A Pluto.jl notebook ###
# v0.19.26

#> [frontmatter]
#> title = "ComputerVisionMetrics"
#> sidebar = "false"

using Markdown
using InteractiveUtils

# ╔═╡ 90f47371-c6a1-499c-812e-42fd84217781
# ╠═╡ show_logs = false
begin
	using Pkg
	Pkg.activate(".")
	Pkg.instantiate()

	using HTMLStrings: to_html, head, link, script, divv, h1, img, p, span, a, figure, hr
	using PlutoUI
end

# ╔═╡ b9c530bf-d81f-44d2-a607-55dd5b83890c
md"""
## Tutorials
"""

# ╔═╡ 2bdcaa42-25e3-4012-acc0-f066d68e5dc6
md"""
## API
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
					img(:src => "$image_url", :class => "h-20 w-20 md:h-32 md:w-32 rounded-md", :alt => "$title Logo"),
					divv(:class => "text-5xl font-bold bg-gradient-to-r from-accent to-primary inline-block text-transparent bg-clip-text py-10", "$title"),
					p(:class => "card-text text-md font-serif", "$subtitle"
					)
				)
			)
	    )
	)
end;

# ╔═╡ 64ad0e5b-cd12-4c4b-ad27-b65d1d7938e1
index_title_card(
	"ComputerVisionMetrics",
	"Common Metrics for Evaluating Segmentation Tasks",
	"https://img.freepik.com/free-photo/colorful-bar-graph-sits-table-with-dark-background_1340-34474.jpg";
	data_theme = data_theme
)

# ╔═╡ 25a553ba-25fa-41df-903c-fdcd2226a81c
struct Article
	title::String
	path::String
	image_url::String
end

# ╔═╡ 9f5dedbb-92ee-4099-ab47-24eb4954392c
article_list_tutorials = Article[
	Article("Getting Started", "getting_started.jl", "https://img.freepik.com/free-photo/futuristic-spaceship-takes-off-into-purple-galaxy-fueled-by-innovation-generated-by-ai_24640-100023.jpg"),
	Article("Advanced Usage", "advanced_usage.jl", "https://img.freepik.com/free-photo/vibrant-colors-flow-liquid-wave-pattern-generated-by-ai_188544-39060.jpg"),
];

# ╔═╡ 881d969b-aeef-451e-8c4f-f25ecbbc379c
article_list_api = Article[
	Article("API", "api.jl", "https://img.freepik.com/free-photo/modern-technology-workshop-creativity-innovation-communication-development-generated-by-ai_188544-24548.jpg"),
];

# ╔═╡ 9a5d201c-546d-4624-95e0-7e0c6a72bf0b
function article_card(article::Article, color::String; data_theme = "pastel")
    a(:href => article.path, :class => "w-1/2 p-2",
		divv(:data_theme => "$data_theme", :class => "card card-bordered border-$color text-center dark:text-[#e6e6e6]",
			divv(:class => "card-body justify-center items-center",
				p(:class => "card-title", article.title),
				p("Click to open the notebook")
			),
			figure(
				img(:src => article.image_url, :alt => article.title)
			)
        )
    )
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
# ╟─e81b2642-0442-42c3-a5ef-7ec312aa3181
# ╟─90f47371-c6a1-499c-812e-42fd84217781
# ╟─3cf724dd-8103-430e-a3eb-2b2f25db1324
# ╟─476678f2-4af0-45fa-8993-2372607d11f2
# ╟─e532258c-7652-455e-97b0-2ce4ce1eaeb5
# ╟─25a553ba-25fa-41df-903c-fdcd2226a81c
# ╟─9f5dedbb-92ee-4099-ab47-24eb4954392c
# ╟─881d969b-aeef-451e-8c4f-f25ecbbc379c
# ╟─9a5d201c-546d-4624-95e0-7e0c6a72bf0b
