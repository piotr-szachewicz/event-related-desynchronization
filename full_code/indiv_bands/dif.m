function d = dif(ymi, i)
    d = 3*ymi(:,i);
    for j=1:4
        if(i != j)
            d = d - ymi(:,j);
        end
    end
    d = abs(d);
end

