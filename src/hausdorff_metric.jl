"""
    mean_hausdorff(set1, set2)

Given two sets of points `set1` & `set2`, compute the mean Hausdorff between the two sets
"""
function mean_hausdorff(set1, set2)
    min_euc_list_u = []
    min_euc_list_v = []

    # Loop through every point in `set1` and find its corresponding closest point to `set2`
    for points1 in set1
        euc_list_1 = []
        for points2 in set2
            euclidean_dist = euc(points1, points2)
            append!(euc_list_1, euclidean_dist)
        end
        append!(min_euc_list_u, minimum(euc_list_1))
    end

    # Loop through every point in `set2` and find its corresponding closest point to `set1`
    for points1 in set2
        euc_list_1 = []
        for points2 in set1
            euclidean_dist = euc(points1, points2)
            append!(euc_list_1, euclidean_dist)
        end
        append!(min_euc_list_v, minimum(euc_list_1))
    end

    # Take the mean of each of these points to return the mean Hausdorff distance 
    return Statistics.mean([
        Statistics.mean(min_euc_list_u), Statistics.mean(min_euc_list_v)
    ])
end

"""
    percentile_hausdorff(set1, set2, p)

Given two sets of points `set1` & `set2`, compute the percentile `p` of the Hausdorff between the two sets.
Returns a tuple for the percentile of each set
"""
function percentile_hausdorff(set1, set2, p)
    min_euc_list_u = []
    min_euc_list_v = []

    # Loop through every point in `set1` and find its corresponding closest point to `set2`
    for points1 in set1
        euc_list_1 = []
        for points2 in set2
            euclidean_dist = euc(points1, points2)
            append!(euc_list_1, euclidean_dist)
        end
        append!(min_euc_list_u, minimum(euc_list_1))
    end

    # Loop through every point in `set2` and find its corresponding closest point to `set1`
    for points1 in set2
        euc_list_1 = []
        for points2 in set1
            euclidean_dist = euc(points1, points2)
            append!(euc_list_1, euclidean_dist)
        end
        append!(min_euc_list_v, minimum(euc_list_1))
    end

    return (
        StatsBase.percentile(min_euc_list_u, p), StatsBase.percentile(min_euc_list_v, p)
    )
end