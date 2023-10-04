using ComputerVisionMetrics
using Test

@testset "dice_metric" begin
	x = [0 0 0 1; 0 0 0 1; 0 0 0 1; 0 0 0 1]
	y = [1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0]
	@test dice_metric(x, y) == 0

	x = [1 1 1 0; 1 1 1 0; 1 1 1 0; 1 1 1 0]
	@test dice_metric(x, x) == 1
end
