function [max_savings, min_savings] = calculateSavings(TT_OD)
    % Input: TT_OD - 3D matrix of travel times
    %        VOT - Value of Time (in monetary units per hour)

    VOT = 11.4;

    #####Calculate median
    median=prctile(TT_OD,50,3)
    worst_travel_time = max(TT_OD(:));
    best_travel_time = min(TT_OD(:));


    min_savings = (median-best_travel_time)*(VOT / 60); %Convert minutes to hours for VOT
    max_savings = (median-worst_travel_time)*(VOT / 60); % Convert minutes to hours for VOT

end
