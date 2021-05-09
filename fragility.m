


clear 
close all
clc

load frag_data

%IM= provide IM variable(s)
%EDP= provide EDP variable(s)

% Provide IM bounds for different condition states
%Bound1 = 
%Bound2 = 

% Provide condition states numbering
numS=2;
minor = 1.0;
major = 2.0;

% Assign different condition states in X vector based on IM and provided data

    X = zeros(length(IM),1);
    
    %--------------------------------NOMINAL-----------------------------------
    
    [B_nominal,~,stats] = mnrfit(log(IM),X,'model','nominal');
    [pihat_nominal,dlow_nominal,dhi_nominal] = mnrval(B_nominal,log(k),stats,'type','cumulative','model','nominal','confidence',0.95);  
    CIL_nominal = pihat_nominal-dlow_nominal;
    CIH_nominal = pihat_nominal+dhi_nominal;
    
    figure
    hold('on');
    for j = 1:numS-1
        plot((k),1-pihat_nominal(:,j),'-','linewidth',2);
        p = plot((k),1-CIL_nominal(:,j),':','linewidth',1.0);
        color = get(p, 'Color');
        plot((k),1-CIH_nominal(:,j),':','Color',color,'linewidth',1.0)
    end
    xlabel('Intensity Measure','FontWeight','bold','FontSize',11);
    ylabel('Probability','FontWeight','bold','FontSize',11);
    title('Fragility Functions using Nominal SR','FontWeight','bold','FontSize',13);
    ylim([0 1]);
    box('on');
    grid('on');
    hold('off');
    
    
    %----------------------------------ORDINAL---------------------------------
    
    [B_ordinal,~,stats] = mnrfit(log(IM),X,'model','ordinal');
    [pihat_ordinal,dlow_ordinal,dhi_ordinal] = mnrval(B_ordinal,log(k),stats,'model','ordinal','type','cumulative','confidence',0.95);
    CIL_ordinal = pihat_ordinal-dlow_ordinal;
    CIH_ordinal = pihat_ordinal+dhi_ordinal;
    
    figure
    hold('on');
    for j = 1:numS-1
        plot((k),1-pihat_ordinal(:,j),'-','linewidth',2);
        p =plot((k),1-CIL_ordinal(:,j),':','linewidth',1.0);
        color = get(p, 'Color');
        plot((k),1-CIH_ordinal(:,j),':','Color',color,'linewidth',1.0)
    end
    xlabel('Intensity Measure','FontWeight','bold','FontSize',11);
    ylabel('Probability','FontWeight','bold','FontSize',11);
    title('Fragility Functions using Ordinal SR','FontWeight','bold','FontSize',13);
    ylim([0 1]);
    box('on');
    grid('on');
    hold('off');
    
    %----------------------------ORDINAL(PROBIT LINK)--------------------------
    
    [B_ordinal_pl,~,stats] = mnrfit(log(IM),X,'model','ordinal','Link','probit');
    [pihat_ordinal_pl,dlow_ordinal_pl,dhi_ordinal_pl] = mnrval(B_ordinal_pl,log(k),stats,'model','ordinal','link','probit','type','cumulative','confidence',0.95);
    CIL_ordinal_pl = pihat_ordinal_pl-dlow_ordinal_pl;
    CIH_ordinal_pl = pihat_ordinal_pl+dhi_ordinal_pl;
    
    figure
    hold('on');
    for j = 1:numS-1
        plot((k),1-pihat_ordinal_pl(:,j),'-','linewidth',2);
        p = plot((k),1-CIL_ordinal_pl(:,j),':','linewidth',1.0);
        color = get(p, 'Color');
        plot((k),1-CIH_ordinal_pl(:,j),':','Color',color,'linewidth',1.0)
    end
    xlabel('Intensity Measure','FontWeight','bold','FontSize',11);
    ylabel('Probability','FontWeight','bold','FontSize',11);
    title('Fragility Functions using Ordinal Case and Probit Links','FontWeight','bold','FontSize',13);
    ylim([0 1]);
    box('on');
    grid('on');
    hold('off');

    %---------------------------------HIERARCHICAL-----------------------------
    
    [B_hierarchical,~,stats] = mnrfit(log(IM),X,'model','hierarchical');
    [pihat_hierarchical,dlow_hierarchical,dhi_hierarchical] = mnrval(B_hierarchical,log(k),stats,'model','hierarchical','type','cumulative','confidence',0.95);
    CIL_hierarchical = pihat_hierarchical-dlow_hierarchical;
    CIH_hierarchical = pihat_hierarchical+dhi_hierarchical;
    
    figure
    hold('on');
    for j = 1:numS-1
        plot((k),1-pihat_hierarchical(:,j),'-','linewidth',2);
        p = plot((k),1-CIL_hierarchical(:,j),':','linewidth',1.0);
        color = get(p, 'Color');
        plot((k),1-CIH_hierarchical(:,j),':','Color',color,'linewidth',1.0)
    end
    xlabel('Intensity Measure','FontWeight','bold','FontSize',11);
    ylabel('Probability','FontWeight','bold','FontSize',11);
    title('Fragility Functions using Hierarchical SR','FontWeight','bold','FontSize',13);
    ylim([0 1]);
    box('on');
    grid('on');
    hold('off');

    

