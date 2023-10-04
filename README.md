# ComputerVisionMetrics

[![Glass Notebook](https://img.shields.io/badge/Docs-Glass%20Notebook-aquamarine.svg)](https://glassnotebook.io/r/3zGd8BbRwota3gclkiu2j/docs/index.jl)
[![CI Stable](https://github.com/Dale-Black/ComputerVisionMetrics.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/Dale-Black/ComputerVisionMetrics.jl/actions/workflows/CI.yml)
[![CI Nightly](https://github.com/Dale-Black/ComputerVisionMetrics.jl/actions/workflows/Nightly.yml/badge.svg?branch=master)](https://github.com/Dale-Black/ComputerVisionMetrics.jl/actions/workflows/Nightly.yml)
[![Coverage](https://codecov.io/gh/Dale-Black/ComputerVisionMetrics.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Dale-Black/ComputerVisionMetrics.jl)

ComputerVisionMetrics.jl is a Julia package for evaluating segmentation models using various metrics like Dice and Hausdorff distances. The primary functions are `dice_metric()` and `hausdorff_metric()` which evaluate the similarity and dissimilarity between predicted and ground truth segmentations respectively.

## Features
- Supports 2D and 3D segmentation masks
- Provides functions to calculate Dice and Hausdorff metrics
- Offers additional utility functions like `get_mask_edges` and `euc` for edge detection and Euclidean distance calculation

## Installation
```julia
using Pkg
Pkg.add("ComputerVisionMetrics")
```

## Usage
Basic usage involves passing your predicted and ground truth segmentation masks to the metric functions:

```julia
using ComputerVisionMetrics

# Load your data
prediction = rand([0, 1], 10, 10, 10)
ground_truth = rand([0, 1], 10, 10, 10)

# Evaluate Dice metric
dice_score = dice_metric(prediction, ground_truth)

# Evaluate Hausdorff metric
hausdorff_score = hausdorff_metric(prediction, ground_truth)
```

For more advanced usage and options, see the [documentation](https://glassnotebook.io/r/7uus7O8aIcLsGebjQFqxU/docs/(00)%20Getting%20Started.jl)