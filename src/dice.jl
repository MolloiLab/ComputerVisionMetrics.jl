
"""
## `dice_metric`
```julia
dice_metric(prediction::AbstractArray, ground_truth::AbstractArray)
```

Compute the Dice Coefficient (also known as the Sørensen–Dice index) between two binary masks, `prediction` and `ground_truth`.

The Dice Coefficient measures the similarity between two sets and ranges from 0 (no overlap) to 1 (perfect overlap).

#### Arguments
- `predicted_segment`: Predicted binary mask.
- `ground_truth_segment`: Ground truth binary mask.

#### Returns
- Dice Coefficient value between the two masks.
"""
function dice_metric(prediction::AbstractArray, ground_truth::AbstractArray)
    return 2 * sum((prediction .& ground_truth)) / (sum(prediction) + sum(ground_truth))
end

export dice_metric
