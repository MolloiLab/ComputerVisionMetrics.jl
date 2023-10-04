using ComputerVisionMetrics
using Test

@testset "get_mask_edges" begin
	seg_pred = [
		0 0 0 0 0
	    0 1 1 1 0
	    0 1 1 1 0
	    0 1 1 1 0
	    0 1 1 1 0
		0 0 0 0 0
	]
	seg_gt = copy(seg_pred)
	edges_pred, _ = get_mask_edges(seg_pred, seg_gt)
	answer = [
		CartesianIndex(2, 2)
		CartesianIndex(3, 2)
		CartesianIndex(4, 2)
		CartesianIndex(5, 2)
		CartesianIndex(2, 3)
		CartesianIndex(5, 3)
		CartesianIndex(2, 4)
		CartesianIndex(3, 4)
		CartesianIndex(4, 4)
		CartesianIndex(5, 4)
	]
	@test edges_pred == answer

	seg_pred = [
		0 0 0 0 0
	    0 1 1 1 0
	    0 1 1 1 0
	    0 1 1 1 0
	    0 1 1 1 0
		0 0 0 0 0
	]
	seg_pred = cat(seg_pred, seg_pred, dims=3)
	seg_gt = copy(seg_pred)
	edges_pred, _ = get_mask_edges(seg_pred, seg_gt)
	answer = [
		CartesianIndex(2, 2, 1)
		CartesianIndex(3, 2, 1)
		CartesianIndex(4, 2, 1)
		CartesianIndex(5, 2, 1)
		CartesianIndex(2, 3, 1)
		CartesianIndex(5, 3, 1)
		CartesianIndex(2, 4, 1)
		CartesianIndex(3, 4, 1)
		CartesianIndex(4, 4, 1)
		CartesianIndex(5, 4, 1)
		CartesianIndex(2, 2, 2)
		CartesianIndex(3, 2, 2)
		CartesianIndex(4, 2, 2)
		CartesianIndex(5, 2, 2)
		CartesianIndex(2, 3, 2)
		CartesianIndex(5, 3, 2)
		CartesianIndex(2, 4, 2)
		CartesianIndex(3, 4, 2)
		CartesianIndex(4, 4, 2)
		CartesianIndex(5, 4, 2)
	]
	@test edges_pred == answer
end

@testset "euc" begin
	A = CartesianIndex(1, 3, 1)
    @test euc(A, A) == 0

	A = CartesianIndex(1, 3, 1)
	C = CartesianIndex(1, 3, 2)
	@test euc(A, C) == 1.0
end
