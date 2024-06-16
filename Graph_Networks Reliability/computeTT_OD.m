function TT_OD = computeTT_OD(TT_link)
    % Input: TT_link 3D matrix (assumed to be of dimensions num_stops x num_stops x num_samples)

    % Loop through each sample in TT_matrix
    for sample = 1:size(TT_link, 3)
        % Call dijkstra function for the current sample
        [shortest_paths, total_times] = dijkstra_algorithm(TT_link(:, :, sample), 1);

        % Assign the total_times to the TT_OD matrix for the current sample
        TT_OD(:, :, sample) = total_times;
    end
end
