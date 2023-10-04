using StatsBase: percentile

"""
## `compute_min_euc_distances`

```julia
compute_min_euc_distances(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}) where N
```

Compute the minimum Euclidean distances for each point in `set1` to every point in `set2`.

#### Arguments
- `set1`: First set of points in 2D or 3D space.
- `set2`: Second set of points in 2D or 3D space.

#### Returns
- Vector of minimum Euclidean distances.
"""
function compute_min_euc_distances(set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}}) where N
    min_euc_list = []
    for point1 in set1
        euc_dists = [euc(point1, point2) for point2 in set2]
        push!(min_euc_list, minimum(euc_dists))
    end
    return min_euc_list
end

"""
## `_hausdorff_metric`
```julia
_hausdorff_metric(
    set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}};
    per::Union{Nothing, Real}=nothing, directed::Bool=false
) where N
```

Compute the Hausdorff distance between two sets of points, `set1` and `set2`.

This function has multiple methods depending on the arguments provided:

1. Without `per`: Computes the standard Hausdorff distance.
2. With `per`: Computes the Hausdorff distance at the specified percentile.

#### Arguments
- `set1`: First set of points in 2D or 3D space.
- `set2`: Second set of points in 2D or 3D space.
- `per`: Percentile for the Hausdorff distance (optional).
- `directed`: If `true`, computes one-sided Hausdorff. Default is `false`.

#### Returns
- Hausdorff distance or Hausdorff distance at the specified percentile.
"""
function _hausdorff_metric(
	set1::Vector{CartesianIndex{N}}, set2::Vector{CartesianIndex{N}};
	per::Union{Nothing, Real}=nothing, directed::Bool=false
	) where N
    if isempty(set1) && isempty(set2)
        return 0
    elseif isempty(set1) || isempty(set2)
        return Inf
    end

    min_euc_list_u = compute_min_euc_distances(set1, set2)

    if !directed
        min_euc_list_v = compute_min_euc_distances(set2, set1)
        max_distance = max(maximum(min_euc_list_u), maximum(min_euc_list_v))
    else
        max_distance = maximum(min_euc_list_u)
    end

	return isnothing(per) ? max_distance : percentile([min_euc_list_u; min_euc_list_v], per)
end

"""
## `hausdorff_metric`
```julia
hausdorff_metric(
    prediction::AbstractArray, ground_truth::AbstractArray;
    per::Union{Nothing, Real}=nothing, directed::Bool=false
)
```

Compute the Hausdorff distance between two masks, `prediction` and `ground_truth`.

This function has multiple methods depending on the arguments provided:

1. Without `per`: Computes the standard Hausdorff distance.
2. With `per`: Computes the Hausdorff distance at the specified percentile.

#### Arguments
- `prediction`: Predicted mask, 2D or 3D array of `::Bool` or `::Int`.
- `ground_truth`: Ground truth mask, 2D or 3D array of `::Bool` or `::Int`.
- `per`: Percentile for the Hausdorff distance (optional).
- `directed`: If `true`, computes one-sided Hausdorff. Default is `false`.

#### Returns
- Hausdorff distance or Hausdorff distance at the specified percentile.
"""
function hausdorff_metric(prediction::AbstractArray, ground_truth::AbstractArray;
		per::Union{Nothing, Real}=nothing, directed::Bool=false)
    edges_pred, edges_gt = get_mask_edges(prediction, ground_truth)
    return _hausdorff_metric(edges_pred, edges_gt; per=per, directed=directed)
end

export hausdorff_metric
