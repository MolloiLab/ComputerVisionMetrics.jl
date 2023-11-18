# using ImageMorphology: erode, feature_transform, distance_transform

# """
# ## `get_mask_edges`

# ```julia
# get_mask_edges(seg_pred::AbstractMatrix, seg_gt::AbstractMatrix, points=true)
# get_mask_edges(seg_pred::BitMatrix, seg_gt::BitMatrix, points=true)
# get_mask_edges(seg_pred::BitArray, seg_gt::BitArray, points=true)
# get_mask_edges(seg_pred::BitArray, seg_gt::BitArray, points=true)
# ```

# See [Monai](https://github.com/Project-MONAI/MONAI/blob/dev/monai/metrics/utils.py#L106)
# """
# function get_mask_edges(seg_pred::AbstractMatrix, seg_gt::AbstractMatrix, points=true)
# 	seg_pred, seg_gt = Bool.(seg_pred), Bool.(seg_gt)
	
#     # Do binary erosion and use XOR to get edges
#     edges_pred = erode(seg_pred) .⊻ seg_pred
#     edges_gt = erode(seg_gt) .⊻ seg_gt

# 	if points
# 		return findall(x -> x == 1, edges_pred), findall(x -> x == 1, edges_gt)
# 	else
# 		edges_pred, edges_gt
# 	end
# end

# function get_mask_edges(seg_pred::BitMatrix, seg_gt::BitMatrix, points=true)
#     # Do binary erosion and use XOR to get edges
#     edges_pred = erode(seg_pred) .⊻ seg_pred
#     edges_gt = erode(seg_gt) .⊻ seg_gt

# 	if points
# 		return findall(isone, edges_pred), findall(isone, edges_gt)
# 	else
# 		edges_pred, edges_gt
# 	end
# end

# function get_mask_edges(seg_pred::AbstractArray, seg_gt::AbstractArray, points=true)
# 	seg_pred, seg_gt = Bool.(seg_pred), Bool.(seg_gt)
# 	edges_pred, edges_gt = BitArray(undef, size(seg_pred)), BitArray(undef, size(seg_gt))
# 	for z in axes(seg_pred, 3)
# 	    # Do binary erosion and use XOR to get edges
# 	    edges_pred[:, :, z] = erode(seg_pred[:, :, z]) .⊻ seg_pred[:, :, z]
# 	    edges_gt[:, :, z] = erode(seg_gt[:, :, z]) .⊻ seg_gt[:, :, z]
# 	end

# 	if points
# 		return findall(isone, edges_pred), findall(isone, edges_gt)
# 	else
# 		edges_pred, edges_gt
# 	end
# end

# function get_mask_edges(seg_pred::BitArray, seg_gt::BitArray, points=true)
# 	edges_pred, edges_gt = BitArray(undef, size(seg_pred)), BitArray(undef, size(seg_gt))
# 	for z in axes(seg_pred, 3)
# 	    # Do binary erosion and use XOR to get edges
# 	    edges_pred[:, :, z] = erode(seg_pred[:, :, z]) .⊻ seg_pred[:, :, z]
# 	    edges_gt[:, :, z] = erode(seg_gt[:, :, z]) .⊻ seg_gt[:, :, z]
# 	end

# 	if points
# 		return findall(isone, edges_pred), findall(isone, edges_gt)
# 	else
# 		edges_pred, edges_gt
# 	end
# end

# export get_mask_edges

# """
# ## `euc`

# ```julia
# euc(u::CartesianIndex{2}, v::CartesianIndex{2})
# euc(u::CartesianIndex{3}, v::CartesianIndex{3})
# ```

# Euclidean distance
# """
# function euc(u::CartesianIndex{2}, v::CartesianIndex{2})
#     return √((u[1] - v[1])^2 + (u[2] - v[2])^2)
# end

# function euc(u::CartesianIndex{3}, v::CartesianIndex{3})
#     return √((u[1] - v[1])^2 + (u[2] - v[2])^2 + (u[3] - v[3])^2)
# end

# export euc