using ComputerVisionMetrics
using ImageDistances: hausdorff
using Test

@testset "Hausdorff Metric" begin
	@testset "hausdorff_metric 2D" begin
		img1, img2 = rand([0.0f0, 1.0f0], 100, 100), rand([0.0f0, 1.0f0], 100, 100)
		for i in 1:100
			hd = hausdorff_metric(img1, img2)
			@test isapprox(hd, hausdorff(img1, img2); rtol = 0.5)
		end
	end

	@testset "hausdorff_metric 3D" begin
		img1, img2 = rand([0.0f0, 1.0f0], 10, 10, 10), rand([0.0f0, 1.0f0], 10, 10, 10)
		for i in 1:100
			hd = hausdorff_metric(img1, img2)
			@test isapprox(hd, hausdorff(img1, img2); rtol = 0.5)
		end
	end
end
