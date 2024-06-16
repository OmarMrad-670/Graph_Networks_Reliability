function[COV, TT10, TT50, TT80, TT90, TT95, lambda_var, lambda_skew, UIr,BI,PTI, MI, probability_exceeding] = calculateCOV(TT_OD)
    % Input: TT_link 3D matrix (assumed to be of dimensions num_stops x num_stops x num_samples)
    %        B: Constant for Pr(TTi > B + TT50)
    %        Lr: Route length

    % Compute COV
    B = 0.05;  % Buffer time as a fraction of travel time (5%)
    m_speed = 15;  % Mean speed in km/h

############################################################

    COV = std(TT_OD, 0, 3) ./ mean(TT_OD, 3);
    COV(isnan(COV)) = 0;

############################################################

    % Compute Percentiles
    TT10 = prctile(TT_OD, 10, 3);
    TT50 = prctile(TT_OD, 50, 3);
    TT80 = prctile(TT_OD, 80, 3);
    TT90 = prctile(TT_OD, 90, 3);
    TT95 = prctile(TT_OD, 95, 3);

    TT_freeflow=TT95
#############################################

    lr = m_speed*mean(TT_freeflow/60);


    lambda_var = (TT95 - TT10) ./ TT50;
    lambda_skew = (TT90 - TT50) ./ (TT50 - TT10);



#######################################################

    UIr = (lambda_var.*log(lambda_skew))./lr;

####################################################


    BT = TT95 - mean(TT_OD, 3);
    BI = BT ./ mean(TT_OD, 3);


    TT_new = TT_OD > TT80;
    TT_OOOO = TT_OD .* TT_new;

    PTI = TT95 / TT_freeflow;



    MI = (TT80 - mean(TT_OOOO, 3)) / mean(TT_OOOO, 3);


    probability_exceeding = sum(TT_OD > (B + TT50), 3) / size(TT_OD, 3);


end
