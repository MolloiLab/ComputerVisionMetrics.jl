function dice_metric(seg_pred, seg_gt)
	return 2 * sum((seg_pred .& seg_gt)) / (sum(seg_pred) + sum(seg_gt))
end

export dice_metric
