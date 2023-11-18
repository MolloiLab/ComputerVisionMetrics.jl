using ComputerVisionMetrics
using Test

@testset "Dice Metric" begin
	@testset "dice_metric 2D" begin
		for i in 1:100
			img1 = rand([0.0f0, 1.0f0], 100, 100)
			img2 = copy(img1)
			@test dice_metric(img1, img2) == 1
		end
		for i in 1:100
			img1 = rand([0.0f0, 1.0f0], 100, 100)
			img2 = rand([0.0f0, 1.0f0], 100, 100)
			@test dice_metric(img1, img2) < 1
		end
	end
	
	@testset "dice_metric 3D" begin
		for i in 1:100
			img1 = rand([0.0f0, 1.0f0], 10, 10, 10)
			img2 = copy(img1)
			@test dice_metric(img1, img2) == 1
		end
		for i in 1:100
			img1 = rand([0.0f0, 1.0f0], 10, 10, 10)
			img2 = rand([0.0f0, 1.0f0], 10, 10, 10)
			@test dice_metric(img1, img2) < 1
		end
	end
end