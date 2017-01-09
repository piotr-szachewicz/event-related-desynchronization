function [kappa_value, index, all_kappas] = get_kappa(cl_lab, lab)
    IX = cl_lab;
    cl = lab;

    CL = unique(cl(~isnan(cl)));

	CMX = repmat(zeros,[size(IX,1),length(CL)*[1,1]]);
    for k = 1:length(CL),
        for j = 1:length(CL),
           CMX(:,k,j)=sum(IX(:,CL(k)==cl)==j,2);
        end;
    end;
    o.CMX = CMX;

    o.KAP00 = zeros(size(CMX,1),1);
    o.Ksd00 = zeros(size(CMX,1),1);
    o.ACC00 = zeros(size(CMX,1),1);
    o.R     = zeros(size(CMX,1),1);

    for k = 1:size(CMX,1),
        [o.KAP00(k),o.Ksd00(k),h,z,o.ACC00(k),sa,o.I_Nykopp(k,1)] = kappa(squeeze(CMX(k,:,:)));
    end;

    all_kappas = o.KAP00;
    [kappa_value, index] = max(o.KAP00);
end


