module ComputerVisionMetrics
using ImageMorphology
using ImageEdgeDetection
using Statistics
using StatsBase
using Distances

include("dice_metric.jl")
include("hausdorff_metric.jl")
include("utils.jl")

export 
    dice_metric,
    hausdorff_metric,
    mean_hausdorff_2D,
    euc,
    find_edges,
    detect_edges_3D
end
