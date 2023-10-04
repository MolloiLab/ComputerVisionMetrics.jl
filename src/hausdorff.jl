using StatsBase: percentile

"""

	_hausdorff_metric(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, directed=false) where N
	_hausdorff_metric(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, p, directed=false) where N

Given two sets of points, `set1` & `set2`, compute the Hausdorff distance between the two sets. By default, the returned Hausdorff is the max Hausdorff and is two-sided. If given a parameter `p`, return a tuple for each set's percentile. To choose a one-sided Hausdorff, change `directed=true`

#### Arguments
- `set1`: set of points in 2D or 3D space
- `set2`: set of points in 2D or 3D space
- `p`: percentile to be computed based on `StatsBase.percentile`
"""
function _hausdorff_metric(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}; directed::Bool=false) where N
	if length(set1) == 0 && length(set2) == 0
		return 0
	elseif length(set1) == 0
		return Inf
	elseif length(set2) == 0
		return Inf
	end
    min_euc_list_u = []
    min_euc_list_v = []

    # Loop through every point in `set1` and 
	# find its corresponding closest point to `set2`
    for points1 in set1
        euc_list_1 = []
        for points2 in set2
            euclidean_dist = euc(points1, points2)
            append!(euc_list_1, euclidean_dist)
        end
        append!(min_euc_list_u, minimum(euc_list_1))
    end

	if !directed
	    # Loop through every point in `set2` and 
		# find its corresponding closest point to `set1`
	    for points1 in set2
	        euc_list_1 = []
	        for points2 in set1
	            euclidean_dist = euc(points1, points2)
	            append!(euc_list_1, euclidean_dist)
	        end
	        append!(min_euc_list_v, minimum(euc_list_1))
	    end
	    # Take the mean of each of these points 
		# to return the mean Hausdorff distance 
	    return max(maximum(min_euc_list_u), maximum(min_euc_list_v))
	else
		return maximum(min_euc_list_u)
	end
end

function _hausdorff_metric(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}, p; directed::Bool=false) where N
	if length(set1) == 0 && length(set2) == 0
		return 0
	elseif length(set1) == 0
		return Inf
	elseif length(set2) == 0
		return Inf
	end
    min_euc_list_u = []
    min_euc_list_v = []

    # Loop through every point in `set1` and 
	# find its corresponding closest point to `set2`
    for points1 in set1
        euc_list_1 = []
        for points2 in set2
            euclidean_dist = euc(points1, points2)
            append!(euc_list_1, euclidean_dist)
        end
        append!(min_euc_list_u, minimum(euc_list_1))
    end

	if !directed
	    # Loop through every point in `set2` and 
		# find its corresponding closest point to `set1`
	    for points1 in set2
	        euc_list_1 = []
	        for points2 in set1
	            euclidean_dist = euc(points1, points2)
	            append!(euc_list_1, euclidean_dist)
	        end
	        append!(min_euc_list_v, minimum(euc_list_1))
	    end
	
	    return max(percentile(min_euc_list_u, p), percentile(min_euc_list_v, p))
	else
		return percentile(min_euc_list_u, p)
	end
end

"""

	hausdorff_metric(seg_pred::AbstractArray, seg_gt::AbstractArray, directed=false)
	hausdorff_metric(seg_pred::AbstractArray, seg_gt::AbstractArray, p, directed=false)

Given two arrays, `seg_pred` & `seg_gt`, compute the Hausdorff distance. By default, the returned Hausdorff is the max Hausdorff and is two-sided. If given a parameter `p`, return a tuple for each set's percentile. To choose a one-sided Hausdorff, change `directed=true`

#### Arguments
- `seg_pred`: predicted mask. 2D or 3D array of `::Bool` or `::Int`
- `seg_gt`: ground_truth mask. 2D or 3D array of `::Bool` or `::Int`
- `p`: percentile to be computed based on `StatsBase.percentile`
"""
function hausdorff_metric(seg_pred::AbstractArray, seg_gt::AbstractArray; directed::Bool=false)
	edges_pred, edges_gt = get_mask_edges(seg_pred, seg_gt)
	return _hausdorff_metric(edges_pred, edges_gt; directed = directed)
end

function hausdorff_metric(seg_pred::AbstractArray, seg_gt::AbstractArray, p; directed::Bool=false)
	edges_pred, edges_gt = get_mask_edges(seg_pred, seg_gt)
	return _hausdorff_metric(edges_pred, edges_gt, p; directed = directed)
end

export hausdorff_metric